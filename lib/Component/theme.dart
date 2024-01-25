import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemeData _lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xffcb2e23),
      brightness: Brightness.light,
    ),
  );

  final ThemeData _darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xffcb2e23),
      brightness: Brightness.dark,
    ),
  );

  ThemeData get themeData => _isDarkMode ? _darkTheme : _lightTheme;

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
