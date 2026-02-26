import 'dart:async';
import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/onboarding/bloc/onboarding_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/onboarding/models/onboarding_model.dart';
import 'package:startup_mvp_starter_flutter/onboarding/widgets/onboarding_indicator_cell_widget.dart';
import 'package:startup_mvp_starter_flutter/onboarding/widgets/onboarding_indicator_widget.dart';
import 'package:startup_mvp_starter_flutter/onboarding/widgets/onboarding_slide_widget.dart';
import 'package:startup_mvp_starter_flutter/onboarding/widgets/video_onboarding_slide_widget.dart';
import 'package:startup_mvp_starter_flutter/utils/funcs/show_error_alert.dart';

enum SkipButtonAlignment { topCenter, bottomLeft, bottomRight, bottomCenter }

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({super.key});

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  static OnboardingSlideWidget _buildSlide(MyOnboardingModel value) {
    switch (value.onboardingType) {
      case OnboardingType.title:
        return TitleOnboardingSlideWidget(
          slideModel: value.title ?? '',
        );
      case OnboardingType.assetImage:
        return ImageOnboardingSlideWidget(
          slideModel: value.assetPath ?? '',
        );
      case OnboardingType.video:
        return VideoOnboardingSlideWidget(
          slideModel: value.videoModel!,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingError) {
          showErrorAlert(context: context, error: state.error ?? '');
        }
        if (state is OnboardingSkip) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        body: BlocBuilder<OnboardingBloc, OnboardingState>(
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
                                context.read<OnboardingBloc>().add(
                                  OnboardingOnChangedCurrentPage(
                                    newPage: state.currentPage + 1,
                                  ),
                                );
                              } else {
                                context.read<OnboardingBloc>().add(
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
                              child: _buildSlide(
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
                            context.read<OnboardingBloc>().add(
                              OnboardingOnSkip(),
                            );
                          },
                          child: _customSkipButton(),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              alignment: SkipButtonAlignment.bottomLeft,
                              padding: EdgeInsetsGeometry.zero,
                              cellBuilder:
                                  (index, currentPage) =>
                                      CustomOnboardingIndicatorCellWidget(
                                        index: index,
                                        currentPage: currentPage,
                                      ),
                              tapOn:
                                  (index) {
                                    context
                                        .read<OnboardingBloc>()
                                        .add(
                                          OnboardingOnChangedCurrentPage(
                                            newPage: index,
                                          ),
                                        );
                                  },
                              spacing: 4,
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
