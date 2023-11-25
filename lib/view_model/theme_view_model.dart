import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ThemeViewModel extends ChangeNotifier {
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
