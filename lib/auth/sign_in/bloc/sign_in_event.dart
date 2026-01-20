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

class SignInOnGetCodeButtonTapped extends SignInEvent {
  final Map<String, String> textFields;
  SignInOnGetCodeButtonTapped({required this.textFields});

  @override
  List<Object> get props => [super.props, textFields];
}

class SignInOnReturned extends SignInEvent {}
