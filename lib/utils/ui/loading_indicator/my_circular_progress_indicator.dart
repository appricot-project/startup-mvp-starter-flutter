import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/color_constants.dart';

class MyCircularProgressIndicator extends StatelessWidget {
  final bool enabled;
  final Widget? child;
  final Color? color;
  const MyCircularProgressIndicator({
    super.key,
    this.color,
    this.enabled = true,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child ?? Container();
    } else {
      return Center(
        child: CircularProgressIndicator(
          color: color ?? ColorConstants.primary,
          strokeWidth: 2,
        ),
      );
    }
  }
}
