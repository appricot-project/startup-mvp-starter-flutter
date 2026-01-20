import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  Map<TextFieldKey, String> textFieldsErrors = {};
  Loading? loading;

  SignInBloc() : super(SignInInitial(textFieldsErrors: {}, loading: null)) {
    on<SignInOnAppear>((event, emit) {});
    on<SignInOnCloseButtonTapped>((event, emit) {
      emit(
        SignInClose(
          textFieldsErrors: Map<TextFieldKey, String>.from(textFieldsErrors),
          loading: loading,
        ),
      );
    });
    on<SignInOnGetCodeButtonTapped>((event, emit) async {
      bool isValid = validate(
        TextFieldKey.email,
        event.textFields['email'] ?? '',
      );
      if (isValid) {
        emit(
          SignInShowVerification(
            gmail: event.textFields['email'] ?? '',
            textFieldsErrors: Map<TextFieldKey, String>.from(textFieldsErrors),
            loading: loading,
          ),
        );
      } else {
        _updating(emit);
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
        break;
    }
    return isValid;
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }

  _updating(Emitter<SignInState> emit) {
    emit(
      SignInUpdated(
        textFieldsErrors: Map<TextFieldKey, String>.from(textFieldsErrors),
        loading: loading,
      ),
    );
  }
}
