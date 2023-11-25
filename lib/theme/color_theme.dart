import 'package:flutter/material.dart';

class ColorTheme {
  // ** Light Mode
  static Color lightPrimary = const Color(0xFFDDF2FD);
  static const Color lightSecondary = Color(0xFF164863);
  static const Color lightWhite = Colors.white;
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
  static const Color darkPrimary = Color(0xFF427D9D);
  static const Color darkSecondary = Color(0xFF164863);

  static const Color darkAccent = Color(0xFF131314);
  static const Color darkBackgroundPrimary =
      Color(0xFF121212); // Dark 50% - Color #121212
}
