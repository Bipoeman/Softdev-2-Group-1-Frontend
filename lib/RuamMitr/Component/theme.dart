import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  Map<String, Map<String, CustomThemes>> appThemes = _appsThemes;

  CustomThemes? themeFrom(String app) => _appsThemes[app]?[_isDarkMode ? "dark" : "light"];

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    saveTheme();
    notifyListeners();
  }

  void saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDarkMode", _isDarkMode);
  }

  void loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool("isDarkMode") ?? false;
    notifyListeners();
  }
}

class ThemesPortal {
  static CustomThemes? appThemeFromContext(BuildContext context, String app) {
    ThemeProvider themes = Provider.of<ThemeProvider>(context);
    return themes.themeFrom(app);
  }

  static ThemeProvider getCurrent(BuildContext context) {
    return Provider.of<ThemeProvider>(context);
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
      ),
      customColors: {
        "main": const Color.fromRGBO(214, 40, 40, 1),
        "onMain": Colors.white,
        "container": const Color.fromRGBO(238, 238, 238, 1),
        "onContainer": Colors.black,
        "oddContainer": const Color.fromRGBO(238, 238, 238, 1),
        "onOddContainer": Colors.black,
        "evenContainer": Colors.white,
        "onEvenContainer": Colors.black,
        "textInputContainer": const Color.fromRGBO(221, 221, 221, 1),
        "label": const Color.fromRGBO(84, 84, 84, 1),
        "textInput": Colors.black,
        "icon": Colors.black,
        "icon1": const Color.fromRGBO(214, 40, 40, 1),
        "icon2": Colors.white,
        "background": const Color.fromRGBO(221, 221, 221, 1),
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
        "container": const Color.fromRGBO(77, 77, 77, 1),
        "onContainer": Colors.white,
        "oddContainer": const Color.fromRGBO(77, 77, 77, 1),
        "onOddContainer": Colors.white,
        "evenContainer": const Color.fromRGBO(66, 66, 66, 1),
        "onEvenContainer": Colors.white,
        "textInputContainer": const Color.fromRGBO(84, 84, 84, 1),
        "label": const Color.fromRGBO(221, 221, 221, 1),
        "textInput": Colors.white,
        "icon": Colors.white,
        "icon1": const Color.fromRGBO(214, 40, 40, 1),
        "icon2": Colors.white,
        "background": const Color.fromARGB(255, 19, 19, 19),
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
        "main": const Color(0xFFf77f00),
        "onMain": Colors.white,
        "container": const Color.fromRGBO(238, 238, 238, 1),
        "onContainer": Colors.black,
        "oddContainer": const Color.fromRGBO(238, 238, 238, 1),
        "onOddContainer": Colors.black,
        "evenContainer": Colors.white,
        "onEvenContainer": Colors.black,
        "textInputContainer": const Color.fromRGBO(221, 221, 221, 1),
        "label": const Color.fromRGBO(84, 84, 84, 1),
        "textInput": Colors.black,
        "icon": Colors.black,
        "icon1": const Color(0xFFf77f00),
        "icon2": Colors.black,
        "background": Colors.white,
        "backgroundStart": const Color.fromARGB(255, 247, 204, 155),
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
        "main": const Color(0xFFf77f00),
        "onMain": Colors.white,
        "container": const Color.fromRGBO(77, 77, 77, 1),
        "onContainer": Colors.white,
        "oddContainer": const Color.fromRGBO(77, 77, 77, 1),
        "onOddContainer": Colors.white,
        "evenContainer": const Color.fromRGBO(66, 66, 66, 1),
        "onEvenContainer": Colors.white,
        "textInputContainer": const Color.fromRGBO(84, 84, 84, 1),
        "label": const Color.fromRGBO(221, 221, 221, 1),
        "textInput": Colors.white,
        "icon": Colors.white,
        "icon1": const Color(0xFFf77f00),
        "icon2": Colors.white,
        "background": const Color.fromARGB(255, 19, 19, 19),
        "backgroundStart": const Color.fromARGB(255, 107, 83, 59),
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
          secondary: Colors.blue,
          background: Colors.white,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      customColors: {
        "main": const Color.fromRGBO(0, 48, 73, 1),
        "onMain": Colors.white,
        "container": const Color.fromRGBO(240, 240, 240, 1),
        "onContainer": Colors.black,
        "oddContainer": const Color.fromRGBO(238, 238, 238, 1),
        "onOddContainer": Colors.black,
        "evenContainer": Colors.white,
        "onEvenContainer": Colors.black,
        "textInputContainer": const Color.fromRGBO(221, 221, 221, 1),
        "label": const Color.fromRGBO(84, 84, 84, 1),
        "textInput": Colors.black,
        "icon": Colors.black,
        "icon1": const Color.fromRGBO(217, 192, 41, 1),
        "icon2": const Color.fromRGBO(0, 48, 73, 1),
        "background": Colors.white,
        "backgroundStart": const Color.fromARGB(255, 189, 221, 249),
        "backgroundEnd": const Color.fromRGBO(224, 224, 224, 1),
        "hyperlink": const Color.fromRGBO(0, 167, 190, 1),
      },
    ),
    "dark": CustomThemes(
      themeData: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          secondary: Colors.blue,
          background: const Color.fromRGBO(32, 32, 32, 1),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      customColors: {
        "main": Colors.white,
        "onMain": const Color.fromRGBO(0, 48, 73, 1),
        "container": const Color.fromRGBO(77, 77, 77, 1),
        "onContainer": Colors.white,
        "oddContainer": const Color.fromRGBO(77, 77, 77, 1),
        "onOddContainer": Colors.white,
        "evenContainer": const Color.fromRGBO(66, 66, 66, 1),
        "onEvenContainer": Colors.white,
        "textInputContainer": const Color.fromRGBO(84, 84, 84, 1),
        "label": const Color.fromRGBO(221, 221, 221, 1),
        "textInput": Colors.white,
        "icon": Colors.white,
        "icon1": const Color.fromRGBO(217, 192, 41, 1),
        "icon2": const Color.fromRGBO(0, 48, 73, 1),
        "background": const Color.fromRGBO(32, 32, 32, 1),
        "backgroundStart": const Color.fromRGBO(0, 48, 73, 1),
        "backgroundEnd": const Color.fromRGBO(61, 61, 61, 1),
        "hyperlink": const Color.fromRGBO(0, 200, 212, 1),
      },
    ),
  },
  "Restroom": {
    "light": CustomThemes(
      themeData: ThemeData(
        fontFamily: "Sen",
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFB330),
          secondary: Colors.blue,
          background: const Color(0xFFECECEC),
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          headlineMedium: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w800,
            color: Color(0xFF050505),
          ),
          headlineSmall: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Color(0xFF050505),
          ),
          displaySmall: TextStyle(
            fontSize: 10,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF050505).withOpacity(1),
          ),
          displayMedium: TextStyle(
            fontSize: 20,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF050505).withOpacity(0.69),
          ),
          displayLarge: const TextStyle(
            fontSize: 20,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.w700,
            color: Color(0xFF050505),
          ),
          titleMedium: const TextStyle(
            fontSize: 20,
            color: Color(0xFF050505),
          ),
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white,
            size: 35,
          ),
        ),
        drawerTheme: const DrawerThemeData(
          scrimColor: Colors.transparent,
          backgroundColor: Color(0xFFFFFFFF),
        ),
        searchBarTheme: SearchBarThemeData(
          textStyle: MaterialStatePropertyAll(
            TextStyle(
              fontFamily: GoogleFonts.getFont("Inter").fontFamily,
              color: Colors.black,
            ),
          ),
        ),
      ),
      customColors: const {
        "main": Color.fromRGBO(255, 183, 3, 1),
        "onMain": Colors.black,
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
        fontFamily: "Sen",
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFB330),
          secondary: Colors.blue,
          background: const Color.fromARGB(255, 37, 37, 37),
          brightness: Brightness.dark,
        ),
        textTheme: TextTheme(
          headlineMedium: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w800,
            color: Color(0xFFECECEC),
          ),
          headlineSmall: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Color(0xFFECECEC),
          ),
          displaySmall: const TextStyle(
            fontSize: 10,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.w800,
            color: Color(0xFFECECEC),
          ),
          displayMedium: TextStyle(
            fontSize: 20,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.normal,
            color: const Color(0xFFECECEC).withOpacity(0.69),
          ),
          displayLarge: const TextStyle(
            fontSize: 20,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.w700,
            color: Color(0xFFECECEC),
          ),
          titleMedium: const TextStyle(
            fontSize: 20,
            color: Color(0xFFECECEC),
          ),
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Color.fromARGB(255, 69, 69, 69),
            size: 35,
          ),
        ),
        drawerTheme: const DrawerThemeData(
          scrimColor: Colors.transparent,
          backgroundColor: Color.fromARGB(0, 212, 212, 212),
        ),
        searchBarTheme: SearchBarThemeData(
          textStyle: MaterialStatePropertyAll(
            TextStyle(
              fontFamily: GoogleFonts.getFont("Inter").fontFamily,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ),
      customColors: const {
        "main": Color.fromRGBO(255, 183, 3, 1),
        "onMain": Colors.black,
        "container": Color.fromRGBO(60, 60, 60, 1),
        "onContainer": Colors.white,
        "oddContainer": Color.fromRGBO(60, 60, 60, 1),
        "onOddContainer": Colors.white,
        "evenContainer": Color.fromRGBO(66, 66, 66, 1),
        "onEvenContainer": Colors.white,
        "textInputContainer": Color(0xFFECECEC),
        "label": Color.fromRGBO(158, 158, 158, 1),
        "textInput": Colors.white,
        "icon": Colors.white,
        "icon1": Color.fromRGBO(217, 192, 41, 1),
        "icon2": Color.fromRGBO(219, 229, 235, 1),
        "background": Color.fromRGBO(30, 30, 30, 1),
        "backgroundStart": Color.fromRGBO(125, 67, 0, 1),
        "backgroundEnd": Color.fromRGBO(61, 61, 61, 1),
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
