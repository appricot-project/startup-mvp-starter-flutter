import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/color_constants.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/text_theme_constants.dart';

class ThemeDataConstants {
  static ThemeData lightTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorConstants.primary,
        brightness: Brightness.light,
        error: ColorConstants.error,
        secondary: ColorConstants.secondary,
        onSecondary: ColorConstants.secondaryText,
        onPrimary: ColorConstants.primaryText,
        outline: ColorConstants.border,
      ),
      primaryColor: ColorConstants.primary,
      dividerColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Color.fromRGBO(25, 41, 55, 1)),
        elevation: 0,
        backgroundColor: ColorConstants.background,
        surfaceTintColor: ColorConstants.background,
      ),
      scaffoldBackgroundColor: ColorConstants.background,
      unselectedWidgetColor: ColorConstants.unselected,
      disabledColor: ColorConstants.disabled,
      focusColor: ColorConstants.focus,
      textTheme: TextThemeConstants.constants,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorConstants.primaryDark,
        brightness: Brightness.dark,
        error: ColorConstants.error,
        secondary: ColorConstants.secondaryDark,
        onSecondary: ColorConstants.secondaryTextDark,
        onPrimary: ColorConstants.primaryTextDark,
        outline: ColorConstants.borderDark,
      ),
      primaryColor: ColorConstants.primaryDark,
      dividerColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Color.fromRGBO(255, 255, 255, 1)),
        elevation: 0,
        backgroundColor: ColorConstants.backgroundDark,
        surfaceTintColor: ColorConstants.backgroundDark,
      ),
      scaffoldBackgroundColor: ColorConstants.backgroundDark,
      unselectedWidgetColor: ColorConstants.unselectedDark,
      disabledColor: ColorConstants.disabled,
      focusColor: ColorConstants.focus,
      textTheme: TextThemeConstants.constants,
    );
  }
}
