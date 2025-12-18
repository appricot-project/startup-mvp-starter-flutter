part of 'onboarding_bloc.dart';

abstract class OnboardingState extends Equatable {
  final List<String> assets;
  final int currentPage;
  final double progress;
  final bool isFirstStartTimer;

  const OnboardingState({
    required this.assets,
    required this.currentPage,
    required this.progress,
    required this.isFirstStartTimer,
  });

  @override
  List<Object?> get props => [
    assets,
    currentPage,
    progress,
    isFirstStartTimer,
  ];
}

// enum Loading { initialLoading, storyLoading }

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial({
    required super.assets,
    required super.currentPage,
    required super.progress,
    required super.isFirstStartTimer,
  });
}

class OnboardingUpdated extends OnboardingState {
  const OnboardingUpdated({
    required super.assets,
    required super.currentPage,
    required super.progress,
    required super.isFirstStartTimer,
  });
}

class OnboardingError extends OnboardingState {
  final String? error;

  const OnboardingError({
    required this.error,
    required super.assets,
    required super.currentPage,
    required super.progress,
    required super.isFirstStartTimer,
  });

  @override
  List<Object?> get props => [super.props, error];
}

class OnboardingSkip extends OnboardingState {
  const OnboardingSkip({
    required super.assets,
    required super.currentPage,
    required super.progress,
    required super.isFirstStartTimer,
  });
}
