import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/color_constants.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';
import 'package:startup_mvp_starter_flutter/utils/theme_cubit.dart';

class PlatformComponents {
  static bool get _isLight {
    return locator<ThemeCubit>().state == Brightness.light;
  }

  static Widget clearIcon() {
    return Image.asset('assets/images/clear_icon.png');
  }

  static Widget searchIcon() {
    return Image.asset('assets/images/search_icon.png');
  }

  static Widget profileUserIcon() {
    return Icon(Icons.person_outline, size: 64, color: ColorConstants.primary);
  }

  static Widget arrowRightIcon() {
    return Icon(Icons.chevron_right, size: 24, color: ColorConstants.primary);
  }

  static Widget lineArrowLeftIcon() {
    return Icon(Icons.arrow_back_rounded, size: 24, color: ColorConstants.primary);
  }

  static Widget calendarIcon() {
    return Icon(Icons.calendar_month, size: 24, color: ColorConstants.primary);
  }
}
