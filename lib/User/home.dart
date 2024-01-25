import "package:flutter/material.dart";
import "package:ruam_mitt/Component/theme.dart";

var currentTheme = Themes(LightMode());
Color backgroundColor = currentTheme.backgroundColor;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            // child: Here
          ),
        ),
      ),
    );
  }
}
