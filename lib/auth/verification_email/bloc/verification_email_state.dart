part of 'verification_email_bloc.dart';

abstract class VerificationEmailState extends Equatable {
  final Loading? loading;
  final String gmail;
  final Duration time;
  final String? codeError;

  VerificationEmailState({
    required this.loading,
    required this.gmail,
    required this.time,
    required this.codeError,
  });

  @override
  List<Object?> get props => [loading, gmail, time, codeError];
}

enum Loading { actionLoading }

class VerificationEmailInitial extends VerificationEmailState {
  VerificationEmailInitial({
    required super.loading,
    required super.gmail,
    required super.time,
    required super.codeError,
  });
}

class VerificationEmailUpdating extends VerificationEmailState {
  VerificationEmailUpdating({
    required super.loading,
    required super.gmail,
    required super.time,
    required super.codeError,
  });
}

class VerificationEmailClose extends VerificationEmailState {
  VerificationEmailClose({
    required super.loading,
    required super.gmail,
    required super.time,
    required super.codeError,
  });
}

class VerificationEmailBack extends VerificationEmailState {
  VerificationEmailBack({
    required super.loading,
    required super.gmail,
    required super.time,
    required super.codeError,
  });
}

class VerificationEmailError extends VerificationEmailState {
  final String error;

  VerificationEmailError({
    required super.loading,
    required this.error,
    required super.gmail,
    required super.time,
    required super.codeError,
  });

  @override
  List<Object?> get props => [super.props, error];
}
