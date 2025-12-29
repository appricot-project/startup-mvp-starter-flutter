import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/color_constants.dart';

abstract class OnboardingIndicatorCellWidget extends StatelessWidget {
  final int index;
  final int currentPage;

  OnboardingIndicatorCellWidget({
    required this.index,
    required this.currentPage,
  });
}

class CustomOnboardingIndicatorCellWidget
    extends OnboardingIndicatorCellWidget {
  CustomOnboardingIndicatorCellWidget({
    required super.index,
    required super.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Builder(
        builder: (context) {
          if (index < currentPage) {
            return Container(
              width: 20,
              decoration: BoxDecoration(
                color: ColorConstants.background,
                borderRadius: BorderRadius.circular(5),
              ),
            );
          } else if (index == currentPage) {
            return Container(
              width: 20,
              decoration: BoxDecoration(
                color: ColorConstants.error,
                borderRadius: BorderRadius.circular(5),
              ),
            );
          } else {
            return Container(
              width: 20,
              decoration: BoxDecoration(
                color: ColorConstants.primary,
                borderRadius: BorderRadius.circular(5),
              ),
            );
          }
        },
      ),
    );
  }
}
