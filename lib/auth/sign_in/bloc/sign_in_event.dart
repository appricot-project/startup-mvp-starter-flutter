part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInOnTextChanged extends SignInEvent {
  final TextFieldKey key;
  final String value;
  const SignInOnTextChanged({required this.key, required this.value});

  @override
  List<Object> get props => [key, value];
}

class SignInOnAppear extends SignInEvent {}

class SignInOnCloseButtonTapped extends SignInEvent {}

class SignInOnSubmitButtonTapped extends SignInEvent {
  final String email;
  final String password;
  const SignInOnSubmitButtonTapped({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class SignInOnToggleMode extends SignInEvent {}

class SignInOnReturned extends SignInEvent {}
