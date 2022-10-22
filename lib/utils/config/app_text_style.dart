import 'package:flutter/material.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/fonts.gen.dart';

class AppTextStyle {
  static TextStyle _styleWith(
    FontWeight weight,
    double size,
    Color color, {
    double? height,
    FontStyle style = FontStyle.normal,
    TextDecoration? decoration,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontWeight: weight,
      fontSize: size,
      color: color,
      fontStyle: style,
      height: height,
      decoration: decoration,
      letterSpacing: letterSpacing,
      fontFamily: FontFamily.sFProDisplay,
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

  static TextStyle w400s10(Color color, {double? height, double? letterSpacing}) {
    return _styleWith(FontWeight.w400, 10, color, height: height, letterSpacing: letterSpacing);
  }

  static TextStyle w400s12(Color color, {double? height, double? letterSpacing}) {
    return _styleWith(FontWeight.w400, 12, color, height: height, letterSpacing: letterSpacing);
  }

  static TextStyle w400s16(Color color, {double? height, double? letterSpacing}) {
    return _styleWith(FontWeight.w400, 16, color, height: height, letterSpacing: letterSpacing);
  }

  static TextStyle w400s17(Color color, {double? height, double? letterSpacing}) {
    return _styleWith(FontWeight.w400, 17, color, height: height, letterSpacing: letterSpacing);
  }

  static TextStyle w500s15(Color color, {double? height, double? letterSpacing}) {
    return _styleWith(FontWeight.w500, 15, color, height: height, letterSpacing: letterSpacing);
  }

  static TextStyle w600s15(Color color, {double? height, double? letterSpacing}) {
    return _styleWith(FontWeight.w600, 15, color, height: height, letterSpacing: letterSpacing);
  }

  static TextStyle w600s33(Color color, {double? height, double? letterSpacing}) {
    return _styleWith(FontWeight.w600, 33, color, height: height, letterSpacing: letterSpacing);
  }

  static TextStyle w700s14(Color color, {double? height, double? letterSpacing}) {
    return _styleWith(FontWeight.w700, 14, color, height: height, letterSpacing: letterSpacing);
  }

  static TextStyle w700s16(Color color, {double? height, double? letterSpacing}) {
    return _styleWith(FontWeight.w700, 16, color, height: height, letterSpacing: letterSpacing);
  }

  static TextStyle w700s17(Color color, {double? height, double? letterSpacing}) {
    return _styleWith(FontWeight.w700, 17, color, height: height, letterSpacing: letterSpacing);
  }

  static TextStyle w800s33(Color color, {double? height, double? letterSpacing}) {
    return _styleWith(FontWeight.w800, 33, color, height: height, letterSpacing: letterSpacing);
  }
}
