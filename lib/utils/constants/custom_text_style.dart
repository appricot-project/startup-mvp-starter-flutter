import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle mobileH1({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: 'Calibri',
      fontSize: fontSize ?? 24,
      fontWeight: fontWeight ?? FontWeight.w700,
      color: color ?? Colors.black,
    );
  }

  static TextStyle mobileH2({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: 'Calibri',
      fontSize: fontSize ?? 20,
      fontWeight: fontWeight ?? FontWeight.w700,
      color: color ?? Colors.black,
    );
  }

  static TextStyle title1({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: 'Calibri',
      fontSize: fontSize ?? 18,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? Colors.black,
    );
  }

  static TextStyle title2({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: 'Calibri',
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? Colors.black,
    );
  }

  static TextStyle buttonText({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: 'Calibri',
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? Colors.black,
      letterSpacing: 0,
    );
  }

  static TextStyle body1({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: 'Calibri',
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? Colors.black,
    );
  }

  static TextStyle body2({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: 'Calibri',
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? Colors.black,
    );
  }

  static TextStyle body3({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: 'Calibri',
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? Colors.black,
    );
  }

  static TextStyle caption({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: 'Calibri',
      fontSize: fontSize ?? 12,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? Colors.black,
    );
  }

  static TextStyle custom({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    double? height,
  }) {
    return TextStyle(
      fontFamily: 'Calibri',
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? Colors.black,
      height: height,
    );
  }

  static TextStyle bodyEmphasized({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: 'SFPro',
      fontSize: fontSize ?? 17,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? Colors.black,
    );
  }
}
