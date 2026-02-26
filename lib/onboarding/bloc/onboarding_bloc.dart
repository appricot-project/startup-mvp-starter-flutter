import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:startup_mvp_starter_flutter/onboarding/models/onboarding_model.dart';
import 'package:startup_mvp_starter_flutter/onboarding/models/video_onboarding_slide_model.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  SharedStorage shared;
  int currentPage;

  static final List<MyOnboardingModel> slides = [
    MyOnboardingModel(
      onboardingType: OnboardingType.title,
      title: 'Hello world!!!',
    ),
    MyOnboardingModel(
      onboardingType: OnboardingType.video,
      videoModel: VideoOnboardingSlideModel(
        assetPath: 'assets/videos/onboarding_first_video.mp4',
        autoPlay: false,
      ),
    ),
    MyOnboardingModel(
      onboardingType: OnboardingType.assetImage,
      assetPath: 'assets/images/onboarding_image.jpeg',
    ),
    MyOnboardingModel(
      onboardingType: OnboardingType.title,
      title: 'End!',
    ),
  ];

  OnboardingBloc({
    required this.shared,
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
