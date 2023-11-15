import 'package:flutter/material.dart';

class JsoorTextTheme {
  // Function to calculate responsive font size
  static double _responsiveFontSize(double fontSize, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // Adjust the values as needed for your responsive design
    if (screenWidth <= 320) {
      return fontSize * 0.8;
    } else if (screenWidth <= 768) {
      return fontSize * 0.9;
    } else {
      return fontSize;
    }
  }

  // Light Theme Text Styles
  static TextStyle lightHeadline1(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(32, context),
      fontWeight: FontWeight.bold,
      color: Color(0xff212121),
    );
  }

  static TextStyle lightHeadline2(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(28, context),
      fontWeight: FontWeight.bold,
      color: Color(0xff212121),
    );
  }

  static TextStyle lightHeadline3(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(24, context),
      fontWeight: FontWeight.bold,
      color: Color(0xff212121),
    );
  }

  static TextStyle lightSubtitle1(BuildContext context) {
    return TextStyle(
        fontSize: _responsiveFontSize(18, context),
        color: Color(0xff212121),
        fontWeight: FontWeight.w300);
  }

  static TextStyle lightSubtitle2(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(16, context),
      color: Color(0xff212121),
    );
  }

  static TextStyle lightBodyText1(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(16, context),
      color: Color(0xff212121),
    );
  }

  static TextStyle lightBodyText2(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(14, context),
      color: Color(0xff212121),
    );
  }

  static TextStyle lightButtonText1(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(16, context),
      color: Color(0xff212121),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle lightButtonText2(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(14, context),
      color: Color(0xff212121),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle lightButtonText3(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(12, context),
      color: Color(0xff212121),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle lightCaption(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(12, context),
      color: Colors.white,
    );
  }

  static TextStyle lightErrorText(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(14, context),
      color: Colors.red,
    );
  }

  static TextStyle lightLinkText(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(16, context),
      color: Colors.grey,
      decoration: TextDecoration.underline,
    );
  }

  // Dark Theme Text Styles
  static TextStyle darkHeadline1(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(32, context),
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle darkHeadline2(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(28, context),
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle darkHeadline3(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(24, context),
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle darkSubtitle1(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(18, context),
      color: Colors.white,
    );
  }

  static TextStyle darkSubtitle2(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(16, context),
      color: Colors.white,
    );
  }

  static TextStyle darkBodyText1(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(16, context),
      color: Colors.white,
    );
  }

  static TextStyle darkBodyText2(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(14, context),
      color: Colors.white,
    );
  }

  static TextStyle darkButtonText1(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(16, context),
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle darkButtonText2(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(14, context),
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle darkButtonText3(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(12, context),
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle darkCaption(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(12, context),
      color: Colors.white,
    );
  }

  static TextStyle darkErrorText(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(14, context),
      color: Colors.red,
    );
  }

  static TextStyle darkLinkText(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(16, context),
      color: Colors.grey,
      decoration: TextDecoration.underline,
    );
  }

}
