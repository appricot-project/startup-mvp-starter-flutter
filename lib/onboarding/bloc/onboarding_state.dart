part of 'onboarding_bloc.dart';

abstract class OnboardingState extends Equatable {
  final List<MyOnboardingModel> slides;
  final int currentPage;

  const OnboardingState({
    required this.slides,
    required this.currentPage,
  });

  @override
  List<Object?> get props => [
    slides,
    currentPage,
  ];
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial({
    required super.slides,
    required super.currentPage,
  });
}

class OnboardingUpdated extends OnboardingState {
  const OnboardingUpdated({
    required super.slides,
    required super.currentPage,
  });
}

class OnboardingError extends OnboardingState {
  final String? error;

  const OnboardingError({
    required this.error,
    required super.slides,
    required super.currentPage,
  });

  @override
  List<Object?> get props => [super.props, error];
}

class OnboardingSkip extends OnboardingState {
  const OnboardingSkip({
    required super.slides,
    required super.currentPage,
  });
}
