import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode(String app) => appDarkMode[app]!;
  bool globalDarkMode = false;
  Map<String, Map<String, CustomThemes>> appThemes = _appsThemes;
  Map<String, String> themeForApp = {
    "RuamMitr": "RuamMitr",
    "PinTheBin": "PinTheBin",
    "TuachuayDekhor": "TuachuayDekhor",
    "Restroom": "Restroom",
    "Dinodengzz": "Dinodengzz",
  };
  Map<String, bool> appDarkMode = {
    "RuamMitr": false,
    "TuachuayDekhor": false,
  };

  CustomThemes? themeFrom(String app) =>
      _appsThemes[themeForApp[app]]?[appDarkMode[app]! ? "dark" : "light"];

  void resetAllSettings(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!context.mounted) {
      return;
    }
    globalDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    await prefs.remove("Global-DarkMode");
    appDarkMode.forEach((app, _) {
      appDarkMode[app] = globalDarkMode;
      prefs.remove("$app-DarkMode");
    });
    themeForApp.forEach((app, _) {
      themeForApp[app] = app;
      prefs.remove("$app-ThemeColor");
    });
    notifyListeners();
  }

  void toggleTheme() {
    globalDarkMode = !globalDarkMode;
    appDarkMode.forEach((app, _) {
      appDarkMode[app] = globalDarkMode;
    });
    saveTheme();
    notifyListeners();
  }

  void toggleThemeForApp(String app) {
    appDarkMode[app] = !appDarkMode[app]!;
    bool appDarkModeValue = appDarkMode[app]!;
    Iterable<bool> darkModeValues = appDarkMode.values;
    if (darkModeValues.every((element) => element == appDarkModeValue)) {
      debugPrint("All apps are ${appDarkModeValue ? "dark" : "light"}");
      globalDarkMode = appDarkModeValue;
    }
    saveTheme();
    notifyListeners();
  }

  void changeAppTheme(String app, String appTheme) {
    themeForApp[app] = appTheme;
    saveThemeColor(app, appTheme);
    notifyListeners();
  }

  void saveThemeColor(String app, String appTheme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("$app-ThemeColor", appTheme);
  }

  void loadThemeColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeForApp.forEach((app, _) {
      themeForApp[app] = prefs.getString("$app-ThemeColor") ?? app;
    });
    notifyListeners();
  }

  void saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    appDarkMode.forEach((app, darkMode) async {
      await prefs.setBool("$app-DarkMode", darkMode);
    });
    await prefs.setBool("Global-DarkMode", globalDarkMode);
  }

  void loadTheme(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!context.mounted) {
      return;
    }
    globalDarkMode = prefs.getBool("Global-DarkMode") ??
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    appDarkMode.forEach((app, _) {
      appDarkMode[app] = prefs.getBool("$app-DarkMode") ?? globalDarkMode;
    });
    notifyListeners();
  }
}

class ThemesPortal {
  static CustomThemes? appThemeFromContext(BuildContext context, String app) {
    ThemeProvider themes = Provider.of<ThemeProvider>(context, listen: false);
    return themes.themeFrom(app);
  }

  static ThemeProvider getCurrent(BuildContext context) {
    return Provider.of<ThemeProvider>(context);
  }

  static void changeThemeColor(BuildContext context, String app, String appTheme) {
    ThemeProvider themes = Provider.of<ThemeProvider>(context, listen: false);
    themes.changeAppTheme(app, appTheme);
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
        fontFamily: GoogleFonts.getFont("Inter").fontFamily,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xffcb2e23),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      customColors: const {
        "main": Color(0xFFD62828),
        "onMain": Color(0xFFFFFFFF),
        "container": Color(0xFFEEEEEE),
        "onContainer": Color(0xFF000000),
        "oddContainer": Color(0xFFEEEEEE),
        "onOddContainer": Color(0xFF000000),
        "evenContainer": Color(0xFFFFFFFF),
        "onEvenContainer": Color(0xFF000000),
        "textInputContainer": Color(0xFFDDDDDD),
        "label": Color(0xFF545454),
        "textInput": Color(0xFF000000),
        "icon": Color(0xFF000000),
        "icon1": Color(0xFFD62828),
        "icon2": Color(0xFF000000),
        "background": Color(0xFFF8C4C4),
        "backgroundStart": Color(0xFFF8C4C4),
        "backgroundEnd": Color(0xFFE5D1BB),
        "hyperlink": Color(0xFF00A7BE),
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
        fontFamily: GoogleFonts.getFont("Inter").fontFamily,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xffcb2e23),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      customColors: const {
        "main": Color(0xFFD62828),
        "onMain": Color(0xFFFFFFFF),
        "container": Color(0xFF4D4D4D),
        "onContainer": Color(0xFFFFFFFF),
        "oddContainer": Color(0xFF4D4D4D),
        "onOddContainer": Color(0xFFFFFFFF),
        "evenContainer": Color(0xFF424242),
        "onEvenContainer": Color(0xFFFFFFFF),
        "textInputContainer": Color(0xFF545454),
        "label": Color(0xFFDDDDDD),
        "textInput": Color(0xFFFFFFFF),
        "icon": Color(0xFFFFFFFF),
        "icon1": Color(0xFFD62828),
        "icon2": Color(0xB3FFFFFF),
        "background": Color(0xFF131313),
        "backgroundStart": Color(0xFF4c3434),
        "backgroundEnd": Color(0xFF5c473d),
        "hyperlink": Color(0xFF00C8D4),
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
          secondary: Colors.blue,
          background: Colors.white,
        ),
        useMaterial3: true,
        fontFamily: GoogleFonts.getFont("Inter").fontFamily,
      ),
      customColors: const {
        "main": Color(0xFFf77f00),
        "onMain": Colors.white,
        "container": Color.fromRGBO(238, 238, 238, 1),
        "onContainer": Colors.black,
        "oddContainer": Color.fromRGBO(238, 238, 238, 1),
        "onOddContainer": Colors.black,
        "evenContainer": Colors.white,
        "onEvenContainer": Colors.black,
        "textInputContainer": Color.fromRGBO(221, 221, 221, 1),
        "label": Color.fromRGBO(84, 84, 84, 1),
        "textInput": Colors.black,
        "icon": Colors.black,
        "icon1": Color(0xFFf77f00),
        "icon2": Colors.black,
        "background": Colors.white,
        "backgroundStart": Color.fromARGB(255, 247, 204, 155),
        "backgroundEnd": Color.fromRGBO(224, 224, 224, 1),
        "hyperlink": Color.fromRGBO(0, 167, 190, 1),
      },
    ),
    "dark": CustomThemes(
      themeData: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFf77f00),
          brightness: Brightness.dark,
          primary: const Color(0xFFf77f00),
          onPrimary: Colors.white,
          secondary: Colors.blue,
          background: const Color.fromARGB(255, 19, 19, 19),
        ),
        useMaterial3: true,
        fontFamily: GoogleFonts.getFont("Inter").fontFamily,
      ),
      customColors: const {
        "main": Color(0xFFf77f00),
        "onMain": Colors.white,
        "container": Color.fromRGBO(77, 77, 77, 1),
        "onContainer": Colors.white,
        "oddContainer": Color.fromRGBO(77, 77, 77, 1),
        "onOddContainer": Colors.white,
        "evenContainer": Color.fromRGBO(66, 66, 66, 1),
        "onEvenContainer": Colors.white,
        "textInputContainer": Color.fromRGBO(84, 84, 84, 1),
        "label": Color.fromRGBO(221, 221, 221, 1),
        "textInput": Colors.white,
        "icon": Colors.white,
        "icon1": Color(0xFFf77f00),
        "icon2": Colors.white,
        "background": Color.fromARGB(255, 19, 19, 19),
        "backgroundStart": Color.fromARGB(255, 107, 83, 59),
        "backgroundEnd": Color.fromARGB(255, 94, 78, 66),
        "hyperlink": Color.fromRGBO(0, 200, 212, 1),
      },
    ),
  },
  "TuachuayDekhor": {
    "light": CustomThemes(
      themeData: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(0, 48, 73, 1),
          primary: const Color.fromRGBO(0, 48, 73, 1),
          onPrimary: Colors.white,
          secondary: Colors.blue,
          background: Colors.white,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: GoogleFonts.getFont("Inter").fontFamily,
      ),
      customColors: const {
        "main": Color.fromRGBO(0, 48, 73, 1),
        "onMain": Colors.white,
        "container": Color.fromRGBO(240, 240, 240, 1),
        "onContainer": Colors.black,
        "oddContainer": Color.fromRGBO(238, 238, 238, 1),
        "onOddContainer": Colors.black,
        "evenContainer": Colors.white,
        "onEvenContainer": Colors.black,
        "textInputContainer": Color.fromRGBO(221, 221, 221, 1),
        "label": Color.fromRGBO(84, 84, 84, 1),
        "textInput": Colors.black,
        "icon": Colors.black,
        "icon1": Color.fromRGBO(217, 192, 41, 1),
        "icon2": Color.fromRGBO(0, 48, 73, 1),
        "background": Colors.white,
        "backgroundStart": Color.fromARGB(255, 189, 221, 249),
        "backgroundEnd": Color.fromRGBO(224, 224, 224, 1),
        "hyperlink": Color.fromRGBO(0, 167, 190, 1),
      },
    ),
    "dark": CustomThemes(
      themeData: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: Colors.white,
          onPrimary: const Color.fromRGBO(0, 48, 73, 1),
          secondary: Colors.blue,
          background: const Color.fromRGBO(32, 32, 32, 1),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: GoogleFonts.getFont("Inter").fontFamily,
      ),
      customColors: const {
        "main": Colors.white,
        "onMain": Color.fromRGBO(0, 48, 73, 1),
        "container": Color.fromRGBO(77, 77, 77, 1),
        "onContainer": Colors.white,
        "oddContainer": Color.fromRGBO(77, 77, 77, 1),
        "onOddContainer": Colors.white,
        "evenContainer": Color.fromRGBO(66, 66, 66, 1),
        "onEvenContainer": Colors.white,
        "textInputContainer": Color.fromRGBO(84, 84, 84, 1),
        "label": Color.fromRGBO(221, 221, 221, 1),
        "textInput": Colors.white,
        "icon": Colors.white,
        "icon1": Color.fromRGBO(217, 192, 41, 1),
        "icon2": Color.fromRGBO(0, 48, 73, 1),
        "background": Color.fromRGBO(32, 32, 32, 1),
        "backgroundStart": Color.fromRGBO(0, 48, 73, 1),
        "backgroundEnd": Color.fromRGBO(52, 68, 83, 1),
        "hyperlink": Color.fromRGBO(0, 200, 212, 1),
      },
    ),
  },
  "Restroom": {
    "light": CustomThemes(
      themeData: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(255, 179, 48, 1),
          primary: const Color.fromRGBO(255, 179, 48, 1),
          onPrimary: Colors.white,
          secondary: Colors.blue,
          background: const Color(0xFFECECEC),
          brightness: Brightness.light,
        ),
        fontFamily: GoogleFonts.getFont("Inter").fontFamily,
      ),
      customColors: const {
        "main": Color.fromRGBO(255, 179, 48, 1),
        "onMain": Colors.white,
        "container": Color.fromRGBO(228, 228, 228, 1),
        "onContainer": Colors.black,
        "oddContainer": Color.fromRGBO(228, 228, 228, 1),
        "onOddContainer": Colors.black,
        "evenContainer": Colors.white,
        "onEvenContainer": Colors.black,
        "textInputContainer": Color(0xFFECECEC),
        "label": Color.fromRGBO(158, 158, 158, 1),
        "textInput": Colors.black,
        "icon": Colors.black,
        "icon1": Color.fromRGBO(255, 183, 3, 1),
        "icon2": Color.fromRGBO(0, 48, 73, 1),
        "background": Color.fromRGBO(245, 245, 245, 1),
        "backgroundStart": Color.fromARGB(255, 233, 202, 110),
        "backgroundEnd": Color.fromRGBO(224, 224, 224, 1),
        "hyperlink": Color.fromRGBO(0, 167, 190, 1),
      },
    ),
    "dark": CustomThemes(
      themeData: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(255, 179, 48, 1),
          primary: const Color.fromRGBO(255, 179, 48, 1),
          onPrimary: Colors.black,
          secondary: Colors.blue,
          background: const Color.fromARGB(255, 37, 37, 37),
          brightness: Brightness.dark,
        ),
        fontFamily: GoogleFonts.getFont("Inter").fontFamily,
      ),
      customColors: const {
        "main": Color.fromRGBO(255, 179, 48, 1),
        "onMain": Colors.black,
        "container": Color.fromRGBO(60, 60, 60, 1),
        "onContainer": Colors.white,
        "oddContainer": Color.fromRGBO(60, 60, 60, 1),
        "onOddContainer": Colors.white,
        "evenContainer": Color.fromRGBO(66, 66, 66, 1),
        "onEvenContainer": Colors.white,
        "textInputContainer": Color.fromRGBO(80, 80, 80, 1),
        "label": Color.fromRGBO(158, 158, 158, 1),
        "textInput": Colors.white,
        "icon": Colors.white,
        "icon1": Color.fromRGBO(217, 192, 41, 1),
        "icon2": Color.fromRGBO(219, 229, 235, 1),
        "background": Color.fromRGBO(30, 30, 30, 1),
        "backgroundStart": Color.fromRGBO(81, 63, 43, 1),
        "backgroundEnd": Color.fromRGBO(85, 78, 67, 1),
        "hyperlink": Color.fromRGBO(0, 200, 212, 1),
      },
    ),
  },
  "Dinodengzz": {
    "light": CustomThemes(
      themeData: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0A9396),
          primary: const Color(0xFF0A9396),
          onPrimary: Colors.white,
          secondary: Colors.blue,
          background: const Color(0xFFECECEC),
          brightness: Brightness.light,
        ),
        fontFamily: GoogleFonts.getFont("Inter").fontFamily,
      ),
      customColors: const {
        "main": Color(0xFF0A9396),
        "onMain": Colors.white,
        "container": Color.fromRGBO(228, 228, 228, 1),
        "onContainer": Colors.black,
        "oddContainer": Color.fromRGBO(228, 228, 228, 1),
        "onOddContainer": Colors.black,
        "evenContainer": Colors.white,
        "onEvenContainer": Colors.black,
        "textInputContainer": Color(0xFFECECEC),
        "label": Color.fromRGBO(158, 158, 158, 1),
        "textInput": Colors.black,
        "icon": Color(0xFF0A9396),
        "icon1": Color(0xFF0A9396),
        "icon2": Colors.black,
        "background": Color.fromRGBO(245, 245, 245, 1),
        "backgroundStart": Color.fromARGB(255, 126, 225, 226),
        "backgroundEnd": Color.fromRGBO(224, 224, 224, 1),
        "hyperlink": Color.fromRGBO(0, 167, 190, 1),
      },
    ),
    "dark": CustomThemes(
      themeData: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0A9396),
          primary: const Color(0xFF0A9396),
          onPrimary: Colors.white,
          secondary: Colors.blue,
          background: const Color.fromARGB(255, 37, 37, 37),
          brightness: Brightness.dark,
        ),
        fontFamily: GoogleFonts.getFont("Inter").fontFamily,
      ),
      customColors: const {
        "main": Color(0xFF0A9396),
        "onMain": Colors.white,
        "container": Color.fromRGBO(60, 60, 60, 1),
        "onContainer": Colors.white,
        "oddContainer": Color.fromRGBO(60, 60, 60, 1),
        "onOddContainer": Colors.white,
        "evenContainer": Color.fromRGBO(66, 66, 66, 1),
        "onEvenContainer": Colors.white,
        "textInputContainer": Color.fromRGBO(80, 80, 80, 1),
        "label": Color.fromRGBO(158, 158, 158, 1),
        "textInput": Colors.white,
        "icon": Color(0xFF0A9396),
        "icon1": Color(0xFF0A9396),
        "icon2": Colors.white70,
        "background": Color.fromRGBO(30, 30, 30, 1),
        "backgroundStart": Color.fromARGB(255, 11, 48, 48),
        "backgroundEnd": Color.fromRGBO(81, 106, 109, 1),
        "hyperlink": Color.fromRGBO(0, 200, 212, 1),
      },
    ),
  },
};

class CustomThemes {
  late ThemeData themeData;
  late Map<String, Color> customColors;

  CustomThemes({
    required this.themeData,
    required this.customColors,
  });
}
