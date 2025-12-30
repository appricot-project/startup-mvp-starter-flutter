part of 'verification_email_bloc.dart';

abstract class VerificationEmailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerificationEmailOnAppear extends VerificationEmailEvent {}

class VerificationEmailOnClose extends VerificationEmailEvent {}

class VerificationEmailOnBack extends VerificationEmailEvent {}

class VerificationEmailOnTimerTicked extends VerificationEmailEvent {}

class VerificationEmailOnNewCode extends VerificationEmailEvent {}

class VerificationEmailOnCodeChanged extends VerificationEmailEvent {
  final String code;
  VerificationEmailOnCodeChanged({required this.code});

  @override
  List<Object> get props => [code];
}
