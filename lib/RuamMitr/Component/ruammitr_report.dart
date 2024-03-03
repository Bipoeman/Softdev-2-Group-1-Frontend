import 'package:flutter/material.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';

GestureDetector reportToUs(
    ThemeProvider themeProvider, BoxController reportBoxController) {
  return GestureDetector(
    child: Text(
      "Report",
      style: TextStyle(
        color: themeProvider.themeFrom("RuamMitr")!.customColors["hyperlink"],
      ),
    ),
    onTap: () {
      reportBoxController.showBox();
    },
  );
}
