import 'package:flutter/material.dart';

class JsoorColorTheme {
  // ** Light Mode
  static const Color lightPrimary =
      Color(0xFF009688); // First Light 10% - Color #009688
  static const Color lightSecondary =
      Color(0xFFB1AAE8); // Second Light 10% - Color #B1AAE8
  static const Color lightWhite = Colors.white; // 30% - Color #607D8B
  static const Color lightBackgroundPrimary =
      Color(0xffEDEFF3); // Light 50% - Color #F5F5F5
  static final List<Color> gradientColors = [
    const Color(0xff1f005c),
    const Color(0xff5b0060),
    const Color(0xff870160),
    const Color(0xffac255e),
    const Color(0xffca485c),
    const Color(0xffe16b5c),
    const Color(0xfff39060),
    const Color(0xffffb56b),
  ];


  // ** Dark Mode
  static const Color darkPrimary =
      Color(0xFF009688); // First Dark 10% - Color #009688
  static const Color darkSecondary =
      Color(0xFFB1AAE8); // Second Dark 10% - Color #B1AAE8
  static const Color darkAccent = Color(0xFF131314); // Dark 30% - Color #1E1E1E
  static const Color darkBackgroundPrimary =
      Color(0xFF121212); // Dark 50% - Color #121212
}
