import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  Map<String, Map<String, CustomThemes>> appThemes = _appsThemes;

  CustomThemes? themeFrom(String app) => _appsThemes[app]?[_isDarkMode ? "dark" : "light"];

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class ThemesPortal {
  static CustomThemes? appThemeFromContext(BuildContext context, String app) {
    ThemeProvider themes = Provider.of<ThemeProvider>(context);
    return themes.themeFrom(app);
  }
}

Map<String, Map<String, CustomThemes>> _appsThemes = {
  "RuamMitr": {
    "light": CustomThemes(
      themeData: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(214, 40, 40, 1),
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
        "main": const Color.fromRGBO(214, 40, 40, 1),
        "onMain": Colors.white,
        "oddContainer": const Color.fromRGBO(238, 238, 238, 1),
        "onOddContainer": Colors.black,
        "evenContainer": Colors.white,
        "onEvenContainer": Colors.black,
        "textInputContainer": const Color.fromRGBO(221, 221, 221, 1),
        "label": const Color.fromRGBO(84, 84, 84, 1),
        "textInput": Colors.black,
        "icon": Colors.black,
        "backgroundStart": const Color(0xFFF8C4C4),
        "backgroundEnd": const Color.fromRGBO(224, 224, 224, 1),
        "hyperlink": const Color.fromRGBO(0, 167, 190, 1),
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
        "main": const Color.fromRGBO(214, 40, 40, 1),
        "onMain": Colors.white,
        "oddContainer": const Color.fromRGBO(77, 77, 77, 1),
        "onOddContainer": Colors.white,
        "evenContainer": const Color.fromRGBO(66, 66, 66, 1),
        "onEvenContainer": Colors.white,
        "textInputContainer": const Color.fromRGBO(84, 84, 84, 1),
        "label": const Color.fromRGBO(221, 221, 221, 1),
        "textInput": Colors.white,
        "icon": Colors.white,
        "backgroundStart": const Color.fromRGBO(67, 49, 49, 1),
        "backgroundEnd": const Color.fromRGBO(61, 61, 61, 1),
        "hyperlink": const Color.fromRGBO(0, 200, 212, 1),
      },
    ),
  },
  "PinTheBin": {
    "light": CustomThemes(
      themeData: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFf77f00),
          brightness: Brightness.light,
          primary: const Color(0xFFf77f00),
          onPrimary: Colors.white,
          primaryContainer: Colors.black,
          onPrimaryContainer: Colors.black,
          secondary: Colors.blue,
          background: Colors.white,
        ),
        useMaterial3: true,
      ),
      customColors: {
        "main": const Color.fromRGBO(214, 40, 40, 1),
        "onMain": Colors.white,
        "oddContainer": const Color.fromRGBO(238, 238, 238, 1),
        "onOddContainer": Colors.black,
        "evenContainer": Colors.white,
        "onEvenContainer": Colors.black,
        "textInputContainer": const Color.fromRGBO(221, 221, 221, 1),
        "label": const Color.fromRGBO(84, 84, 84, 1),
        "textInput": Colors.black,
        "icon": Colors.black,
        "backgroundStart": const Color(0xFFF8C4C4),
        "backgroundEnd": const Color.fromRGBO(224, 224, 224, 1),
        "hyperlink": const Color.fromRGBO(0, 167, 190, 1),
      },
    ),
    "dark": CustomThemes(
      themeData: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFf77f00),
          brightness: Brightness.dark,
          primary: const Color(0xFFf77f00),
          onPrimary: Colors.white,
          primaryContainer: const Color.fromARGB(255, 46, 46, 46),
          onPrimaryContainer: Colors.white,
          secondary: Colors.blue,
          background: const Color.fromARGB(255, 19, 19, 19),
        ),
        useMaterial3: true,
      ),
      customColors: {
        "main": const Color.fromRGBO(214, 40, 40, 1),
        "onMain": Colors.white,
        "oddContainer": const Color.fromRGBO(77, 77, 77, 1),
        "onOddContainer": Colors.white,
        "evenContainer": const Color.fromRGBO(66, 66, 66, 1),
        "onEvenContainer": Colors.white,
        "textInputContainer": const Color.fromRGBO(84, 84, 84, 1),
        "label": const Color.fromRGBO(221, 221, 221, 1),
        "textInput": Colors.white,
        "icon": Colors.white,
        "backgroundStart": const Color.fromRGBO(67, 49, 49, 1),
        "backgroundEnd": const Color.fromRGBO(61, 61, 61, 1),
        "hyperlink": const Color.fromRGBO(0, 200, 212, 1),
      },
    ),
  },
  "TuachuayDekhor": {
    "light": CustomThemes(
      themeData: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(0, 48, 73, 1),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      customColors: {
        "main": const Color.fromRGBO(0, 48, 73, 1),
        "onMain": Colors.white,
        "container": const Color.fromRGBO(240, 240, 240, 1),
        "onContainer": Colors.black,
        "textInputContainer": const Color.fromRGBO(221, 221, 221, 1),
        "label": const Color.fromRGBO(84, 84, 84, 1),
        "textInput": Colors.black,
        "icon1": const Color.fromRGBO(217, 192, 41, 1),
        "icon2": const Color.fromRGBO(0, 48, 73, 1),
        "background": Colors.white,
      },
    ),
    "dark": CustomThemes(
      themeData: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      customColors: {
        "main": Colors.white,
        "onMain": Colors.white,
        "container": const Color.fromRGBO(77, 77, 77, 1),
        "onContainer": Colors.white,
        "textInputContainer": const Color.fromRGBO(84, 84, 84, 1),
        "label": const Color.fromRGBO(221, 221, 221, 1),
        "textInput": Colors.white,
        "icon1": const Color.fromRGBO(217, 192, 41, 1),
        "icon2": const Color.fromRGBO(0, 48, 73, 1),
        "background": Colors.black,
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
