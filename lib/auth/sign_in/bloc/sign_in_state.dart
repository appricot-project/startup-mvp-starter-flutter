part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  final Map<String, String> textFieldsErrors;
  final Loading? loading;

  const SignInState({required this.textFieldsErrors, required this.loading});

  @override
  List<Object?> get props => [textFieldsErrors, loading];
}

enum Loading { actionLoading }

final class SignInInitial extends SignInState {
  const SignInInitial({
    required super.textFieldsErrors,
    required super.loading,
  });
}

class SignInUpdated extends SignInState {
  const SignInUpdated({
    required super.textFieldsErrors,
    required super.loading,
  });
}

final class SignInError extends SignInState {
  final String error;
  const SignInError({
    required this.error,
    required super.textFieldsErrors,
    required super.loading,
  });

  @override
  List<Object> get props => [super.props, error];
}

class SignInClose extends SignInState {
  const SignInClose({required super.textFieldsErrors, required super.loading});
}

class SignInShowVerification extends SignInState {
  final String gmail;
  const SignInShowVerification({
    required this.gmail,
    required super.textFieldsErrors,
    required super.loading,
  });

  @override
  List<Object> get props => [super.props, gmail];
}
