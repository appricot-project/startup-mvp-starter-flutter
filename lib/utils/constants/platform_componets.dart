import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';
import 'package:startup_mvp_starter_flutter/utils/theme_cubit.dart';

class PlatformComponets {
  static bool get _isLight {
    return locator<ThemeCubit>().state == Brightness.light;
  }

  static Widget clearIcon() {
    return Image.asset('assets/images/clear_icon.png');
  }

  static Widget searchIcon() {
    return Image.asset('assets/images/search_icon.png');
  }
}
