import 'package:flutter/material.dart';

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
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(5),
              ),
            );
          } else if (index == currentPage) {
            return Container(
              width: 20,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                borderRadius: BorderRadius.circular(5),
              ),
            );
          } else {
            return Container(
              width: 20,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
            );
          }
        },
      ),
    );
  }
}
