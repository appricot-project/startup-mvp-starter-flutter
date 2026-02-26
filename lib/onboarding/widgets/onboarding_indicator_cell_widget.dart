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
    final isActive = index == currentPage;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
