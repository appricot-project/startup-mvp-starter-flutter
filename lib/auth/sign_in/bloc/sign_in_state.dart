part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  final Map<TextFieldKey, String> textFieldsErrors;
  final Loading? loading;
  final bool isSignUp;

  const SignInState({
    required this.textFieldsErrors,
    required this.loading,
    required this.isSignUp,
  });

  @override
  List<Object?> get props => [textFieldsErrors, loading, isSignUp];
}

enum Loading { actionLoading }

enum TextFieldKey { email, password }

final class SignInInitial extends SignInState {
  const SignInInitial({
    required super.textFieldsErrors,
    required super.loading,
    required super.isSignUp,
  });
}

class SignInUpdated extends SignInState {
  const SignInUpdated({
    required super.textFieldsErrors,
    required super.loading,
    required super.isSignUp,
  });
}

final class SignInError extends SignInState {
  final String error;
  const SignInError({
    required this.error,
    required super.textFieldsErrors,
    required super.loading,
    required super.isSignUp,
  });

  @override
  List<Object> get props => [super.props, error];
}

class SignInClose extends SignInState {
  const SignInClose({
    required super.textFieldsErrors,
    required super.loading,
    required super.isSignUp,
  });
}

class SignInSuccess extends SignInState {
  const SignInSuccess({
    required super.textFieldsErrors,
    required super.loading,
    required super.isSignUp,
  });
}
