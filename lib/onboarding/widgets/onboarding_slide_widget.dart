import 'package:flutter/material.dart';

abstract class OnboardingSlideWidget<SlideModel> extends StatelessWidget {
  final SlideModel slideModel;
  OnboardingSlideWidget({required this.slideModel});
}

class TitleOnboardingSlideWidget extends OnboardingSlideWidget<String> {
  TitleOnboardingSlideWidget({required super.slideModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Text(
          slideModel,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}

class ImageOnboardingSlideWidget extends OnboardingSlideWidget<String> {
  ImageOnboardingSlideWidget({required super.slideModel});

  @override
  Widget build(BuildContext context) {
    return Image.asset(slideModel, fit: BoxFit.fitHeight);
  }
}
