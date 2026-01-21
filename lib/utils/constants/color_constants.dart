import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';
import 'package:startup_mvp_starter_flutter/utils/theme_cubit.dart';

class ColorConstants {
  static bool get _isLight {
    return locator<ThemeCubit>().state.brightness == Brightness.light;
  }

  static Color get background => _isLight
      ? const Color.fromRGBO(255, 255, 255, 1)
      : const Color.fromRGBO(25, 41, 55, 1);

  static Color get primary => _isLight
      ? Color.fromRGBO(25, 41, 55, 1)
      : Color.fromRGBO(255, 255, 255, 1);

  static Color get primaryText => _isLight
      ? const Color.fromRGBO(247, 250, 252, 1)
      : const Color.fromRGBO(25, 41, 55, 1);

  static Color get secondary => _isLight
      ? const Color.fromRGBO(34, 55, 73, 1)
      : const Color.fromRGBO(223, 228, 255, 1);

  static Color get secondaryText => _isLight
      ? Color.fromRGBO(213, 217, 220, 1)
      : Color.fromRGBO(113, 117, 122, 1);

  static Color get border => _isLight
      ? const Color.fromRGBO(211, 223, 233, 1)
      : const Color.fromRGBO(59, 77, 94, 1);

  static Color get error => const Color.fromRGBO(235, 85, 69, 1);

  static Color get unselectedNavigation => _isLight
      ? const Color.fromRGBO(30, 30, 30, 1)
      : const Color.fromRGBO(146, 144, 135, 1);

  static Color get disable => Color.fromRGBO(115, 120, 125, 1);

  static Color get pressedColor => Color.fromRGBO(115, 120, 125, 1);

  static Color get activeTextField => Color.fromRGBO(115, 120, 125, 1);
}
