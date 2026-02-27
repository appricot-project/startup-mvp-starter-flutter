import 'package:startup_mvp_starter_flutter/onboarding/models/video_onboarding_slide_model.dart';

enum OnboardingType { video, assetImage, title }

class MyOnboardingModel {
  final OnboardingType onboardingType;
  final String? title;
  final String? assetPath;
  final VideoOnboardingSlideModel? videoModel;

  MyOnboardingModel({
    required this.onboardingType,
    this.assetPath,
    this.videoModel,
    this.title,
  });
}
