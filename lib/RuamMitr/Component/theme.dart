import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  Map<String, Map<String, CustomThemes>> appThemes = _appsThemes;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

Map<String, Map<String, CustomThemes>> _appsThemes = {
  "RuamMitr": {
    "light": CustomThemes(
      themeData: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xffcb2e23),
          brightness: Brightness.light,
          primary: const Color(0xffcb2e23),
          onPrimary: Colors.white,
          primaryContainer: Colors.white,
          onPrimaryContainer: Colors.black,
          secondary: Colors.blue,
          background: const Color.fromRGBO(221, 221, 221, 1),
        ),
        useMaterial3: true,
      ),
      customColors: {
        "backgroundColor": const Color(0xffe8e8e8),
        "mainColor": const Color(0xffd33333),
        "textColor": const Color(0xff000000),
      },
    ),
    "dark": CustomThemes(
      themeData: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xffcb2e23),
          brightness: Brightness.dark,
          primary: const Color(0xffcb2e23),
          onPrimary: Colors.white,
          primaryContainer: const Color.fromARGB(255, 46, 46, 46),
          onPrimaryContainer: Colors.white,
          secondary: Colors.blue,
          background: const Color.fromARGB(255, 19, 19, 19),
        ),
        useMaterial3: true,
      ),
      customColors: {
        "backgroundColor": const Color(0xff1f1f1f),
        "mainColor": const Color(0xffcb2e23),
        "textColor": const Color(0xffe8e8e8),
      },
    ),
  }
};

class CustomThemes {
  late ThemeData themeData;
  late Map<String, Color> customColors;

  CustomThemes({
    required this.themeData,
    required this.customColors,
  });
}
