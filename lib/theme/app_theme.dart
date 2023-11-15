import 'package:flutter/material.dart';
import 'color_theme.dart';
import 'text_theme.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: JsoorColorTheme.lightPrimary,
      hintColor: JsoorColorTheme.lightSecondary,
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
            JsoorColorTheme.lightPrimary,
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(color: Colors.white),
          ),
        ),
      ),

      textTheme: TextTheme(
        displayLarge: JsoorTextTheme.lightHeadline1(context),
        displayMedium: JsoorTextTheme.lightHeadline2(context),
        displaySmall: JsoorTextTheme.lightHeadline3(context),
        titleMedium: JsoorTextTheme.lightSubtitle1(context),
        titleSmall: JsoorTextTheme.lightSubtitle2(context),
        bodyLarge: JsoorTextTheme.lightBodyText1(context),
        bodyMedium: JsoorTextTheme.lightBodyText2(context),
        labelLarge: JsoorTextTheme.lightButtonText1(context),
        labelMedium: JsoorTextTheme.lightButtonText2(context),
        labelSmall: JsoorTextTheme.lightButtonText3(context),
        bodySmall: JsoorTextTheme.lightCaption(context),
      ),
      colorScheme: const ColorScheme(
        background: JsoorColorTheme.lightBackgroundPrimary,
        brightness: Brightness.light,
        error: Colors.red,
        onBackground: Color(0xff212121),
        onError: Colors.red,
        onPrimary: JsoorColorTheme.lightWhite,
        onSecondary: Color(0xffECEFF3),
        onSurface: Color(0xff212121),
        primary: Color(0xff212121),
        secondary: Color(0xff212121),
        surface: Color(0xff212121),
      ),
    );
  }

  // Define Dark Theme
  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: JsoorColorTheme.darkPrimary,
      hintColor: JsoorColorTheme.darkSecondary,
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
            JsoorColorTheme.darkAccent,
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(color: Colors.white),
          ),
          animationDuration: Duration.zero,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: JsoorTextTheme.darkHeadline1(context),
        displayMedium: JsoorTextTheme.darkHeadline2(context),
        displaySmall: JsoorTextTheme.darkHeadline3(context),
        titleMedium: JsoorTextTheme.darkSubtitle1(context),
        titleSmall: JsoorTextTheme.darkSubtitle2(context),
        bodyLarge: JsoorTextTheme.darkBodyText1(context),
        bodyMedium: JsoorTextTheme.darkBodyText2(context),
        labelLarge: JsoorTextTheme.darkButtonText1(context),
        labelMedium: JsoorTextTheme.darkButtonText2(context),
        labelSmall: JsoorTextTheme.darkButtonText1(context),
        bodySmall: JsoorTextTheme.darkCaption(context),
      ),
      colorScheme: const ColorScheme(
        background: JsoorColorTheme.darkAccent,
        brightness: Brightness.dark,
        error: Colors.red,
        onBackground: Colors.white,
        onError: Colors.red,
        onPrimary: Color(0xff1B1C1D),
        onSecondary: Color(0xFF2B2C2D),
        onSurface: Colors.white,
        primary: Colors.white,
        secondary: Colors.white,
        surface: Colors.white,
      ),
      // Other theme properties...
    );
  }
}
