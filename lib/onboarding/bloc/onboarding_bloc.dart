import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc<SlideModel>
    extends Bloc<OnboardingEvent, OnboardingState> {
  SharedStorage shared;

  final List<SlideModel> slides;
  int currentPage;

  OnboardingBloc({
    required this.shared,
    required this.slides,
    this.currentPage = 0,
  }) : super(OnboardingInitial(slides: slides, currentPage: currentPage)) {
    on<OnboardingOnAppear>((event, emit) async {
      await shared.setShowOnboarding();
      emit(OnboardingUpdated(slides: slides, currentPage: currentPage));
    });
    on<OnboardingOnSkip>((event, emit) {
      emit(OnboardingSkip(slides: slides, currentPage: currentPage));
    });
    on<OnboardingOnReturn>((event, emit) {
      emit(OnboardingUpdated(slides: slides, currentPage: currentPage));
    });
    on<OnboardingOnTimerTicked>((event, emit) {
      emit(OnboardingUpdated(slides: slides, currentPage: currentPage));
    });
    on<OnboardingOnChangedCurrentPage>((event, emit) {
      if (event.newPage == slides.length) {
        emit(OnboardingSkip(slides: slides, currentPage: currentPage));
      } else if (event.newPage == -1) {
        return;
      } else {
        currentPage = event.newPage;
        emit(OnboardingUpdated(slides: slides, currentPage: currentPage));
      }
    });
  }
}
