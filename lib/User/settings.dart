import "package:flutter/material.dart";
import "package:ruam_mitt/Component/theme.dart";

var currentTheme = Themes(LightMode());
Color backgroundColor = currentTheme.backgroundColor;
Color mainColor = currentTheme.mainColor;
Color textColor = currentTheme.textColor;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height - MediaQuery.of(context).padding.top,
            ),
            child: Center(
              child: Text(
                "There is nothing here yet.",
                style: TextStyle(
                    color: textColor,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
