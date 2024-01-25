import "package:flutter/material.dart";

abstract class ThemeMode {
  late Color backgroundColor;
  late Color mainColor;
  late Color textColor;
  late Color textBoxColor;
  late Color boxColor;
  late Color hyperlinkColor;
  late Color labelColor;
  late Color iconColor;
}

final class LightMode extends ThemeMode {
  @override Color backgroundColor = Color(0xFFE8E8E8);
  @override Color mainColor = Color(0xFFD33333);
  @override Color textColor = Color(0xFF333333);
  @override Color textBoxColor = Color(0xFFFFFFFF);
  @override Color boxColor = Color(0xFFFFFFFF);
  @override Color hyperlinkColor = Color(0xFF7EB0DE);
  @override Color labelColor = Color(0xFFBDBDBD);
  @override Color iconColor = Color(0xFFFFFFFF);
}

final class DarkMode extends ThemeMode {
  @override Color backgroundColor = Color(0xFF333333);
  @override Color mainColor = Color(0xFFD33333);
  @override Color textColor = Color(0xFFFFFFFF);
  @override Color textBoxColor = Color(0xFFFFFFFF);
  @override Color boxColor = Color(0xFF4F4F4F);
  @override Color hyperlinkColor = Color(0xFF7EB0DE);
  @override Color labelColor = Color(0xFF626262);
  @override Color iconColor = Color(0xFF0F0F0F);
}

class Themes {
  late Color backgroundColor;
  late Color mainColor;
  late Color textColor;
  late Color textBoxColor;
  late Color boxColor;
  late Color hyperlinkColor;
  late Color labelColor;
  late Color iconColor;

  Themes(ThemeMode theme) {
    backgroundColor = theme.backgroundColor;
    mainColor = theme.mainColor;
    textColor = theme.textColor;
    textBoxColor = theme.textBoxColor;
    boxColor = theme.boxColor;
    hyperlinkColor = theme.hyperlinkColor;
    labelColor = theme.labelColor;
    iconColor = theme.iconColor;
  }
}
