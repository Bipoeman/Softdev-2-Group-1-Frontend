import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData RestroomThemeData = ThemeData(
  fontFamily: "Sen",
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFFFB330),
    background: const Color(0xFFECECEC),
  ),
  textTheme: TextTheme(
    headlineMedium: const TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.w800,
      color: Color.fromARGB(255, 112, 110, 110),
    ),
    headlineSmall: TextStyle(
      fontSize: 30,
      overflow: TextOverflow.fade,
      fontWeight: FontWeight.w800,
      color: const Color(0xFF003049),
      shadows: [
        Shadow(
          blurRadius: 20,
          offset: const Offset(0, 3),
          color: const Color(0xFF003049).withOpacity(0.3),
        ),
      ],
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
    displayLarge: TextStyle(
      fontSize: 20,
      overflow: TextOverflow.fade,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF050505),
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
);

// TextStyle headlineMedium = TextStyle(
//                                     fontFamily: tempBinData[index]
//                                                 ['description']
//                                             .contains(
//                                       RegExp("[ก-๛]"),
//                                     )
//                                         ? "THSarabunPSK"
//                                         : Theme.of(context)
//                                             .textTheme
//                                             .labelMedium!
//                                             .fontFamily,
//                                     fontSize: tempBinData[index]['description']
//                                             .contains(
//                                       RegExp("[ก-๛]"),
//                                     )
//                                         ? 22
//                                         : 16,
//                                     color: Colors.black.withOpacity(0.6),
//                                     fontWeight: tempBinData[index]
//                                                 ['description']
//                                             .contains(
//                                       RegExp("[ก-๛]"),
//                                     )
//                                         ? FontWeight.w700
//                                         : FontWeight.normal),