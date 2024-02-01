import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemeData _lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xffcb2e23),
        brightness: Brightness.light,
        primary: const Color(0xffcb2e23),
        onPrimary: Colors.white,
        primaryContainer: Colors.white,
        onPrimaryContainer: Colors.black,
        secondary: Colors.blue,
        background: const Color.fromRGBO(221, 221, 221, 1)),
    useMaterial3: true,
  );

  final ThemeData _darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xffcb2e23),
        brightness: Brightness.dark,
        primary: const Color(0xffcb2e23),
        onPrimary: Colors.white,
        primaryContainer: const Color.fromARGB(255, 46, 46, 46),
        onPrimaryContainer: Colors.white,
        secondary: Colors.blue,
        background: const Color.fromARGB(255, 19, 19, 19)),
    useMaterial3: true,
  );

  ThemeData get themeData => _isDarkMode ? _darkTheme : _lightTheme;

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  Color get mainColor => const Color(0xffcb2e23);

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
