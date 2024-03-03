import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle text_input(String text, BuildContext context) {
  return TextStyle(
    fontFamily: text.contains(
      RegExp("[ก-๛]"),
    )
        ? "THSarabunPSK"
        : Theme.of(context).textTheme.labelMedium!.fontFamily,
    fontSize: text.contains(
      RegExp("[ก-๛]"),
    )
        ? 24
        : 16,
    fontWeight: text.contains(
      RegExp("[ก-๛]"),
    )
        ? FontWeight.w700
        : FontWeight.normal,
    height: text.contains(
      RegExp("[ก-๛]"),
    )
        ? 0.7
        : 1.0,
  );
}

TextStyle name_place(String text, BuildContext context) {
  return TextStyle(
    fontFamily: text.contains(
      RegExp("[ก-๛]"),
    )
        ? "THSarabunPSK"
        : Theme.of(context).textTheme.labelLarge!.fontFamily,
    fontSize: text.contains(
      RegExp("[ก-๛]"),
    )
        ? 24
        : 22,
    
    fontWeight: text.contains(
      RegExp("[ก-๛]"),
    )
        ? FontWeight.w700
        : FontWeight.w700,
    height: text.contains(
      RegExp("[ก-๛]"),
    )
        ? 0.7
        : 1.0,
  );
}

TextStyle myrestroom(String text, BuildContext context) {
  return TextStyle(
    fontFamily: text.contains(
      RegExp("[ก-๛]"),
    )
        ? "THSarabunPSK"
        : Theme.of(context).textTheme.labelMedium!.fontFamily,
    fontSize: text.contains(
      RegExp("[ก-๛]"),
    )
        ? 28.5714286
        : 20,
    fontWeight: text.contains(
      RegExp("[ก-๛]"),
    )
        ? FontWeight.w700
        : FontWeight.normal,
    height: text.contains(
      RegExp("[ก-๛]"),
    )
        ? 0.7
        : 1.0,
  );
}