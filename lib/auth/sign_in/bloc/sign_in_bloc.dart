import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/auth/auth_service/auth_service.dart';
import 'package:startup_mvp_starter_flutter/utils/auth_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  Map<TextFieldKey, String> textFieldsErrors = {};
  Loading? loading;
  bool isSignUp = false;

  SignInBloc()
      : super(
          SignInInitial(
            textFieldsErrors: {},
            loading: null,
            isSignUp: false,
          ),
        ) {
    on<SignInOnAppear>((event, emit) {});
    on<SignInOnCloseButtonTapped>((event, emit) {
      emit(
        SignInClose(
          textFieldsErrors: Map<TextFieldKey, String>.from(textFieldsErrors),
          loading: loading,
          isSignUp: isSignUp,
        ),
      );
    });
    on<SignInOnToggleMode>((event, emit) {
      isSignUp = !isSignUp;
      textFieldsErrors.clear();
      _updating(emit);
    });
    on<SignInOnSubmitButtonTapped>((event, emit) async {
      bool emailValid = validate(TextFieldKey.email, event.email);
      bool passwordValid = validate(TextFieldKey.password, event.password);

      if (!emailValid || !passwordValid) {
        _updating(emit);
        return;
      }

      loading = Loading.actionLoading;
      _updating(emit);

      try {
        final authService = locator<AuthService>();
        if (isSignUp) {
          await authService.signUp(event.email, event.password);
        } else {
          await authService.signIn(event.email, event.password);
        }
        await locator<AuthCubit>().login();
        loading = null;
        emit(
          SignInSuccess(
            textFieldsErrors: Map<TextFieldKey, String>.from(textFieldsErrors),
            loading: loading,
            isSignUp: isSignUp,
          ),
        );
      } on FirebaseAuthException catch (e) {
        loading = null;
        final errorCode = _mapFirebaseError(e.code);
        emit(
          SignInError(
            error: errorCode,
            textFieldsErrors: Map<TextFieldKey, String>.from(textFieldsErrors),
            loading: loading,
            isSignUp: isSignUp,
          ),
        );
      }
    });
    on<SignInOnTextChanged>((event, emit) {
      validate(event.key, event.value);
      _updating(emit);
    });
    on<SignInOnReturned>((event, emit) {
      _updating(emit);
    });
  }

  bool validate(TextFieldKey key, String value) {
    bool isValid = true;
    switch (key) {
      case TextFieldKey.email:
        if (value.isEmpty) {
          isValid = false;
          textFieldsErrors[key] = 'requiredField';
        } else if (!isValidEmail(value)) {
          isValid = false;
          textFieldsErrors[key] = 'invalidEmail';
        } else {
          textFieldsErrors[key] = '';
        }
      case TextFieldKey.password:
        if (value.isEmpty) {
          isValid = false;
          textFieldsErrors[key] = 'requiredField';
        } else if (value.length < 6) {
          isValid = false;
          textFieldsErrors[key] = 'passwordTooShort';
        } else {
          textFieldsErrors[key] = '';
        }
    }
    return isValid;
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }

  String _mapFirebaseError(String code) {
    switch (code) {
      case 'wrong-password':
      case 'invalid-credential':
        return 'authWrongPassword';
      case 'user-not-found':
        return 'authUserNotFound';
      case 'email-already-in-use':
        return 'authEmailAlreadyInUse';
      case 'weak-password':
        return 'authWeakPassword';
      default:
        return 'errorsSomethingWentWrong';
    }
  }

  _updating(Emitter<SignInState> emit) {
    emit(
      SignInUpdated(
        textFieldsErrors: Map<TextFieldKey, String>.from(textFieldsErrors),
        loading: loading,
        isSignUp: isSignUp,
      ),
    );
  }
}
