import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/color_constants.dart';

abstract class OnboardingIndicatorCellWidget extends StatelessWidget {
  final int index;
  final int currentPage;
  final double progress;

  OnboardingIndicatorCellWidget({
    required this.index,
    required this.currentPage,
    required this.progress,
  });
}

class CustomOnboardingIndicatorCellWidget
    extends OnboardingIndicatorCellWidget {
  CustomOnboardingIndicatorCellWidget({
    required super.index,
    required super.currentPage,
    required super.progress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 4,
      child: Builder(
        builder: (context) {
          if (index < currentPage) {
            return Container(
              decoration: BoxDecoration(
                color: ColorConstants.primary,
                borderRadius: BorderRadius.circular(5),
              ),
            );
          } else if (index == currentPage) {
            return LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.black.withValues(alpha: 0.5),
              valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.primary),
              borderRadius: BorderRadius.circular(5),
            );
          } else {
            return LinearProgressIndicator(
              value: 0,
              backgroundColor: Colors.black.withValues(alpha: 0.5),
              valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.primary),
              borderRadius: BorderRadius.circular(5),
            );
          }
        },
      ),
    );
  }
}
