import 'package:flutter/material.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';

GestureDetector ContactUs(ThemeProvider themeProvider) {
  return GestureDetector(
    child: Text(
      "Contact Us",
      style: TextStyle(
        color: themeProvider.themeFrom("RuamMitr")!.customColors["hyperlink"],
      ),
    ),
    onTap: () {},
  );
}
