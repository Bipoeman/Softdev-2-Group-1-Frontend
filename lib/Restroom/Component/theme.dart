import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/global_var.dart';

// ThemeData RestroomThemeData = ThemeData(
//   fontFamily: "Sen",
//   colorScheme: ColorScheme.fromSeed(
//     seedColor: const Color(0xFFFFB330),
//     background: const Color(0xFFECECEC),
//   ),

//   textTheme: TextTheme(
    
//     headlineMedium: const TextStyle(
//       fontSize: 35,
//       fontWeight: FontWeight.w800,
//       color: Color(0xFF050505),
//     ),
//     headlineSmall: TextStyle(
//       fontSize: 30,
      
//       fontWeight: FontWeight.w500,
//       color: const Color(0xFF050505),
      
      
//     ),
//     displaySmall: TextStyle(
//       fontSize: 10,
//       overflow: TextOverflow.fade,
//       fontWeight: FontWeight.w800,
//       color: const Color(0xFF050505).withOpacity(1),
//     ),
//     displayMedium: TextStyle(
//       fontSize: 20,
//       overflow: TextOverflow.fade,
//       fontWeight: FontWeight.normal,
//       color: const Color(0xFF050505).withOpacity(0.69),
//     ),
//     displayLarge: TextStyle(
//       fontSize: 20,
//       overflow: TextOverflow.fade,
//       fontWeight: FontWeight.w700,
//       color: const Color(0xFF050505),
//     ),
//     titleMedium: TextStyle(
//       fontSize: 20,
      
     
//       color: const Color(0xFF050505),
//     ),
//   ),
//   appBarTheme: const AppBarTheme(
//     iconTheme: IconThemeData(
//       color: Colors.white,
//       size: 35,
//     ),
//   ),
//   drawerTheme: const DrawerThemeData(
//     scrimColor: Colors.transparent,
//     backgroundColor: Color(0xFFFFFFFF),
//   ),
//   searchBarTheme: SearchBarThemeData(
//     textStyle: MaterialStatePropertyAll(
//       TextStyle(
//         fontFamily: GoogleFonts.getFont("Inter").fontFamily,
//         color: Colors.black,
//       ),
//     ),
//   ),
// );

ThemeData RestroomThemeData = ThemesPortal.appThemeFromContext(currentContext, "Restroom")!.themeData;
