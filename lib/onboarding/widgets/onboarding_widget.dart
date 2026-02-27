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
import 'package:startup_mvp_starter_flutter/utils/ui/buttons/custom_button.dart';

enum SkipButtonAlignment { topCenter, bottomLeft, bottomRight, bottomCenter }

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({super.key});

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
          return;
        }
        // Sync PageController with bloc state
        if (_pageController.hasClients &&
            _pageController.page?.round() != state.currentPage) {
          _pageController.animateToPage(
            state.currentPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                context.read<OnboardingBloc>().add(OnboardingOnSkip());
              },
              child: Text(
                AppLocalizations.of(context)!.commonSkip,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            if (state.slides.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: state.slides.length,
                    onPageChanged: (index) {
                      context.read<OnboardingBloc>().add(
                        OnboardingOnChangedCurrentPage(newPage: index),
                      );
                    },
                    itemBuilder: (context, index) => SafeArea(
                      bottom: false,
                      child: _buildSlide(state.slides[index]),
                    ),
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OnboardingIndicatorWidget(
                          countPage: state.slides.length,
                          currentPage: state.currentPage,
                          alignment: SkipButtonAlignment.bottomCenter,
                          padding: EdgeInsetsGeometry.zero,
                          cellBuilder: (index, currentPage) =>
                              CustomOnboardingIndicatorCellWidget(
                                index: index,
                                currentPage: currentPage,
                              ),
                          tapOn: (index) {
                            context.read<OnboardingBloc>().add(
                              OnboardingOnChangedCurrentPage(
                                newPage: index,
                              ),
                            );
                          },
                          spacing: 4,
                        ),
                        const SizedBox(height: 16),
                        CustomButton(
                          text: state.currentPage == state.slides.length - 1
                              ? AppLocalizations.of(context)!.commonStart
                              : AppLocalizations.of(context)!.commonNext,
                          onPressed: () {
                            final isLastPage = state.currentPage ==
                                state.slides.length - 1;
                            if (isLastPage) {
                              context
                                  .read<OnboardingBloc>()
                                  .add(OnboardingOnSkip());
                            } else {
                              context.read<OnboardingBloc>().add(
                                OnboardingOnChangedCurrentPage(
                                  newPage: state.currentPage + 1,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
