part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class OnboardingOnAppear extends OnboardingEvent {}

class OnboardingOnSkip extends OnboardingEvent {}

class OnboardingOnReturn extends OnboardingEvent {}

class OnboardingOnTimerTicked extends OnboardingEvent {}

class OnboardingOnChangedCurrentPage extends OnboardingEvent {
  final int newPage;

  OnboardingOnChangedCurrentPage({required this.newPage});

  @override
  List<Object?> get props => [super.props, newPage];
}
