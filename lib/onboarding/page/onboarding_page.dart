import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/onboarding/bloc/onboarding_bloc.dart';
import 'package:startup_mvp_starter_flutter/onboarding/widgets/onboarding_indicator_cell_widget.dart';
import 'package:startup_mvp_starter_flutter/onboarding/widgets/onboarding_slide_widget.dart';
import 'package:startup_mvp_starter_flutter/onboarding/widgets/onboarding_widget.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

class OnboardingPage<SlideModel> extends StatelessWidget {
  final List<SlideModel> slides;
  final SkipButtonAlignment skipAligmnment;
  final Widget? onboardingSkipWidget;
  final OnboardingIndicatorCellWidget Function(int index, int currentPage)?
  indicatorCellBuilder;
  final OnboardingSlideWidget Function(SlideModel) slideBuilder;
  final EdgeInsetsGeometry indicatorPadding;
  final Function(int)? tapOnIndicator;
  final double? indicatorSpacing;

  const OnboardingPage({
    required this.slides,
    required this.slideBuilder,
    this.indicatorCellBuilder,
    this.indicatorPadding = EdgeInsetsGeometry.zero,
    this.indicatorSpacing,
    this.onboardingSkipWidget,
    this.skipAligmnment = SkipButtonAlignment.bottomLeft,
    this.tapOnIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc<SlideModel>(
        shared: locator<SharedStorage>(),
        slides: slides,
      )..add(OnboardingOnAppear()),
      child: OnboardingWidget<SlideModel>(
        indicatorCellBuilder: indicatorCellBuilder,
        indicatorSpacing: indicatorSpacing,
        onboardingSkipWidget: onboardingSkipWidget,
        skipAligmnment: skipAligmnment,
        indicatorPadding: indicatorPadding,
        tapOnIndicator: tapOnIndicator,
        slideBuilder: slideBuilder,
      ),
    );
  }
}
