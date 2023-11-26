import 'package:flutter/material.dart';
import 'color_theme.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: ColorTheme.lightPrimary,
      hintColor: ColorTheme.lightSecondary,
      cardColor: ColorTheme.lightPrimary,
      dialogBackgroundColor: ColorTheme.lightPrimary.withOpacity(0.3),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(15),
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            ColorTheme.lightPrimary,
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(color: Colors.white),
          ),
        ),
      ),
      colorScheme: const ColorScheme(
        background: ColorTheme.lightBackgroundPrimary,
        brightness: Brightness.light,
        error: Colors.red,
        onBackground: Color(0xff212121),
        onError: Colors.red,
        onPrimary: ColorTheme.lightWhite,
        onSecondary: Colors.white,
        onSurface: Color(0xff4A4A4A),
        primary: Color(0xff212121),
        secondary: Color(0xff212121),
        surface: Color(0xff212121),
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: ColorTheme.darkPrimary,
      hintColor: ColorTheme.darkSecondary,
      cardColor: const Color(0xFF8E8FFA),
      dialogBackgroundColor: ColorTheme.darkPrimary.withOpacity(0.3) ,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(10),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xFF009688),
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            ColorTheme.darkAccent,
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(color: Colors.white),
          ),
          animationDuration: Duration.zero,
        ),
      ),
      colorScheme: const ColorScheme(
        background: ColorTheme.darkAccent,
        brightness: Brightness.dark,
        error: Colors.red,
        onBackground: Colors.white,
        onError: Colors.red,
        onPrimary: Color(0xff1B1C1D),
        onSecondary: Color(0xFF2B2C2D),
        onSurface: Color(0xff4A4A4A),
        primary: Colors.white,
        secondary: Colors.white,
        surface: Colors.white,
      ),
    );
  }
}
