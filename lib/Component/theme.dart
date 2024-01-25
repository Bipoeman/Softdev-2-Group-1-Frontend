import "package:flutter/material.dart";

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  ThemeData get themeData => _isDarkMode ? ThemeData.dark() : ThemeData.light();

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
