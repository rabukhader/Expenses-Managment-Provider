import 'package:flutter/material.dart';

import 'app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  ThemeData getCurrentTheme(BuildContext context) {
    return _isDarkMode ? AppTheme.darkTheme(context) : AppTheme.lightTheme(context);
  }
}
