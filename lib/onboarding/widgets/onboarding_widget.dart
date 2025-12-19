import 'dart:async';
import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/onboarding/bloc/onboarding_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/onboarding/widgets/onboarding_indicator_cell_widget.dart';
import 'package:startup_mvp_starter_flutter/onboarding/widgets/onboarding_indicator_widget.dart';
import 'package:startup_mvp_starter_flutter/utils/funcs/show_error_alert.dart';

enum SkipButtonAlignment { topCenter, bottomLeft, bottomRight, bottomCenter }

class OnboardingWidget extends StatefulWidget {
  final Widget? onboardingSkipWidget;
  final SkipButtonAlignment skipAligmnmentl;
  final OnboardingIndicatorCellWidget Function(
    int index,
    int currentPage,
    double progress,
  )?
  indicatorCellBuilder;

  const OnboardingWidget({
    super.key,
    this.skipAligmnmentl = SkipButtonAlignment.topCenter,
    this.onboardingSkipWidget,
    this.indicatorCellBuilder,
  });

  @override
  State<OnboardingWidget> createState() => _OnboardingWWidgetState();
}

class _OnboardingWWidgetState extends State<OnboardingWidget> {
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
                // Builder(
                //   builder: (context) {
                //     if (state.assets.isEmpty) {
                //       return Container();
                //     } else {
                //       return Stack(
                //         children: [
                //           Container(
                //             height: MediaQuery.of(context).size.height,
                //             width: MediaQuery.of(context).size.width,
                //             decoration: BoxDecoration(
                //               gradient: GradientConstants.gray,
                //             ),
                //           ),
                //           FutureBuilder(
                //             initialData: Container(
                //               color: ColorConstants.darkText,
                //             ),
                //             future: loadImage(
                //               state.stories[state.currentPage].url,
                //               context,
                //             ),
                //             builder: (context, snapshot) {
                //               if (snapshot.data == null) {
                //                 return Container();
                //               } else {
                //                 if (state.isFirstStartTimer) {
                //                   context.read<StoriesBloc>().add(
                //                     StoriesOnEndLoading(),
                //                   );
                //                 }
                //                 return GestureDetector(
                //                   onTapUp: (details) {
                //                     final width = MediaQuery.of(
                //                       context,
                //                     ).size.width;
                //                     if (details.localPosition.dx > width / 2) {
                //                       context.read<StoriesBloc>().add(
                //                         StoriesOnChangedCurrentPage(
                //                           newPage: state.currentPage + 1,
                //                         ),
                //                       );
                //                     } else {
                //                       context.read<StoriesBloc>().add(
                //                         StoriesOnChangedCurrentPage(
                //                           newPage: state.currentPage - 1,
                //                         ),
                //                       );
                //                     }
                //                   },
                //                   child: Container(
                //                     height: MediaQuery.of(context).size.height,
                //                     width: MediaQuery.of(context).size.width,
                //                     child: snapshot.data,
                //                   ),
                //                 );
                //               }
                //             },
                //           ),
                //         ],
                //       );
                //     }
                //   },
                // ),
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
                              countPage: state.assets.length,
                              currentPage: state.currentPage,
                              progress: state.progress,
                              cellBuilder:
                                  widget.indicatorCellBuilder ??
                                  (index, currentPage, progress) =>
                                      CustomOnboardingIndicatorCellWidget(
                                        index: index,
                                        currentPage: currentPage,
                                        progress: progress,
                                      ),
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
    if (widget.skipAligmnmentl == SkipButtonAlignment.topCenter) {
      return MainAxisAlignment.start;
    } else {
      return MainAxisAlignment.end;
    }
  }

  CrossAxisAlignment _skipCrossAlignment() {
    if (widget.skipAligmnmentl == SkipButtonAlignment.topCenter ||
        widget.skipAligmnmentl == SkipButtonAlignment.bottomCenter) {
      return CrossAxisAlignment.center;
    } else if (widget.skipAligmnmentl == SkipButtonAlignment.bottomRight) {
      return CrossAxisAlignment.end;
    } else {
      return CrossAxisAlignment.start;
    }
  }

  Widget _customSkipButton() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
      child: Text(AppLocalizations.of(context)!.commonSkip),
    );
  }

  Future<Image> loadImage(String url, BuildContext context) async {
    final image = Image.network(url, fit: BoxFit.cover);
    await precacheImage(image.image, context);
    return image;
  }
}
