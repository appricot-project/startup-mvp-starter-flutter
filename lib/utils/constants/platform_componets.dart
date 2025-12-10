import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PlatformComponets {
  static bool get _isLight {
    return SchedulerBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.light;
  }

  static Widget clearIcon() {
    return Image.asset('assets/images/clear_icon.png');
  }

  static Widget searchIcon() {
    return Image.asset('assets/images/search_icon.png');
  }
}
