import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/onboarding/widgets/onboarding_indicator_cell_widget.dart';
import 'package:startup_mvp_starter_flutter/onboarding/widgets/onboarding_widget.dart';

class OnboardingIndicatorWidget extends StatelessWidget {
  final int countPage;
  final int currentPage;
  final Function(int)? tapOn;
  final SkipButtonAlignment alignment;
  final EdgeInsetsGeometry padding;
  final double spacing;
  final OnboardingIndicatorCellWidget Function(int index, int currentPage)
  cellBuilder;

  OnboardingIndicatorWidget({
    required this.countPage,
    required this.currentPage,
    required this.cellBuilder,
    required this.alignment,
    required this.padding,
    required this.tapOn,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      // height: 4,
      child: Row(
        mainAxisAlignment: _skipCrossAlignment(),
        children: List.generate(countPage, (index) {
          return GestureDetector(
            onTap: () {
              tapOn?.call(index);
            },
            child: Padding(
              padding: EdgeInsetsGeometry.only(right: spacing),
              child: cellBuilder.call(index, currentPage),
            ),
          );
        }),
      ),
    );
  }

  MainAxisAlignment _skipCrossAlignment() {
    if (alignment == SkipButtonAlignment.topCenter ||
        alignment == SkipButtonAlignment.bottomCenter) {
      return MainAxisAlignment.center;
    } else if (alignment == SkipButtonAlignment.bottomRight) {
      return MainAxisAlignment.end;
    } else {
      return MainAxisAlignment.start;
    }
  }
}
