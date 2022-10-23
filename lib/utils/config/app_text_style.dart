import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle _styleWith(
    FontWeight weight,
    double size,
    Color color, {
    double? height,
    FontStyle style = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontWeight: weight,
      fontSize: size,
      color: color,
      fontStyle: style,
      height: height,
      decoration: decoration,
    );
  }

  // Font-weight 600
  static TextStyle w600s13(Color color, {double? height}) {
    return _styleWith(FontWeight.w600, 13, color, height: height);
  }

  static TextStyle w400s13(Color color, {double? height}) {
    return _styleWith(FontWeight.w400, 13, color, height: height);
  }

  static TextStyle w400s15(Color color, {double? height}) {
    return _styleWith(FontWeight.w400, 15, color, height: height);
  }
}
