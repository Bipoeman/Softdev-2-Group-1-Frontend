import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData pinTheBinThemeData = ThemeData(
  fontFamily: "Sen",
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFF9957F),
    background: const Color(0xFFFFFFFF),
  ),
  textTheme: TextTheme(
    headlineMedium: const TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.w800,
      color: Colors.white,
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
    displayMedium: TextStyle(
      fontSize: 20,
      overflow: TextOverflow.fade,
      fontWeight: FontWeight.normal,
      color: const Color(0xFF003049).withOpacity(0.69),
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
    backgroundColor: Color(0xFFF9957F),
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
