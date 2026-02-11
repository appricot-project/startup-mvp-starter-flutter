import 'dart:async';
import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/onboarding/bloc/onboarding_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/onboarding/widgets/onboarding_indicator_cell_widget.dart';
import 'package:startup_mvp_starter_flutter/onboarding/widgets/onboarding_indicator_widget.dart';
import 'package:startup_mvp_starter_flutter/onboarding/widgets/onboarding_slide_widget.dart';
import 'package:startup_mvp_starter_flutter/utils/funcs/show_error_alert.dart';

enum SkipButtonAlignment { topCenter, bottomLeft, bottomRight, bottomCenter }

class OnboardingWidget<SlideModel> extends StatefulWidget {
  final Widget? onboardingSkipWidget;
  final SkipButtonAlignment skipAligmnment;
  final OnboardingIndicatorCellWidget Function(int index, int currentPage)?
  indicatorCellBuilder;
  final OnboardingSlideWidget Function(SlideModel) slideBuilder;
  final EdgeInsetsGeometry indicatorPadding;
  final Function(int)? tapOnIndicator;
  final double? indicatorSpacing;

  const OnboardingWidget({
    super.key,
    this.skipAligmnment = SkipButtonAlignment.topCenter,
    this.onboardingSkipWidget,
    this.indicatorCellBuilder,
    this.indicatorPadding = EdgeInsetsGeometry.zero,
    this.tapOnIndicator,
    this.indicatorSpacing,
    required this.slideBuilder,
  });

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState<SlideModel>();
}

class _OnboardingWidgetState<SlideModel>
    extends State<OnboardingWidget<SlideModel>> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc<SlideModel>, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingError) {
          showErrorAlert(context: context, error: state.error ?? '');
        }
        if (state is OnboardingSkip) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        body: BlocBuilder<OnboardingBloc<SlideModel>, OnboardingState>(
          builder: (context, state) {
            return Stack(
              children: [
                Builder(
                  builder: (context) {
                    if (state.slides.isEmpty) {
                      return Container();
                    } else {
                      return Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                          ),
                          GestureDetector(
                            onTapUp: (details) {
                              final width = MediaQuery.of(context).size.width;
                              if (details.localPosition.dx > width / 2) {
                                context.read<OnboardingBloc<SlideModel>>().add(
                                  OnboardingOnChangedCurrentPage(
                                    newPage: state.currentPage + 1,
                                  ),
                                );
                              } else {
                                context.read<OnboardingBloc<SlideModel>>().add(
                                  OnboardingOnChangedCurrentPage(
                                    newPage: state.currentPage - 1,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: widget.slideBuilder(
                                state.slides[state.currentPage],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                SafeArea(
                  child: Stack(
                    alignment: AlignmentGeometry.topRight,
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.only(),
                        child: GestureDetector(
                          onTap: () {
                            context.read<OnboardingBloc<SlideModel>>().add(
                              OnboardingOnSkip(),
                            );
                          },
                          child:
                              widget.onboardingSkipWidget ??
                              _customSkipButton(),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: _skipMainAlignment(),
                        crossAxisAlignment: _skipCrossAlignment(),
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 8,
                              bottom: 8,
                            ),
                            child: OnboardingIndicatorWidget(
                              countPage: state.slides.length,
                              currentPage: state.currentPage,
                              alignment: widget.skipAligmnment,
                              padding: widget.indicatorPadding,
                              cellBuilder:
                                  widget.indicatorCellBuilder ??
                                  (index, currentPage) =>
                                      CustomOnboardingIndicatorCellWidget(
                                        index: index,
                                        currentPage: currentPage,
                                      ),
                              tapOn:
                                  widget.tapOnIndicator ??
                                  (index) {
                                    context
                                        .read<OnboardingBloc<SlideModel>>()
                                        .add(
                                          OnboardingOnChangedCurrentPage(
                                            newPage: index,
                                          ),
                                        );
                                  },
                              spacing: widget.indicatorSpacing ?? 4,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  MainAxisAlignment _skipMainAlignment() {
    if (widget.skipAligmnment == SkipButtonAlignment.topCenter) {
      return MainAxisAlignment.start;
    } else {
      return MainAxisAlignment.end;
    }
  }

  CrossAxisAlignment _skipCrossAlignment() {
    if (widget.skipAligmnment == SkipButtonAlignment.topCenter ||
        widget.skipAligmnment == SkipButtonAlignment.bottomCenter) {
      return CrossAxisAlignment.center;
    } else if (widget.skipAligmnment == SkipButtonAlignment.bottomRight) {
      return CrossAxisAlignment.end;
    } else {
      return CrossAxisAlignment.start;
    }
  }

  Widget _customSkipButton() {
    return Container(
      margin: EdgeInsets.only(right: 16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Theme.of(context).primaryColor.withValues(alpha: 0.5),
      ),
      child: Text(
        AppLocalizations.of(context)!.commonSkip,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }

  Future<Image> loadImage(String url, BuildContext context) async {
    final image = Image.network(url, fit: BoxFit.cover);
    await precacheImage(image.image, context);
    return image;
  }
}
