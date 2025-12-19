import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/onboarding/widgets/onboarding_indicator_cell_widget.dart';

class OnboardingIndicatorWidget extends StatelessWidget {
  final int countPage;
  final int currentPage;
  final double progress;
  final Function(int)? tapOn;
  final OnboardingIndicatorCellWidget Function(
    int index,
    int currentPage,
    double progress,
  )
  cellBuilder;

  OnboardingIndicatorWidget({
    required this.countPage,
    required this.currentPage,
    required this.progress,
    required this.cellBuilder,
    this.tapOn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(countPage, (index) {
          return GestureDetector(
            onTap: () {
              tapOn.call(index);
            },
            child: cellBuilder(index, currentPage, progress),
          );
        }),
      ),
    );
  }
}
