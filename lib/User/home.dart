import "package:flutter/material.dart";
import "package:ruam_mitt/Component/main_navigator.dart";

Color backgroundColor = const Color(0xffe8e8e8);
Color mainColor = const Color(0xffd33333);
Color textColor = const Color(0xff000000);

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
              child: BoxWithMainNavigator(
                  child: Center(
                child: Text(
                  "There is nothing in \"Home\" page yet.",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                  ),
                ),
              ))),
        ),
      ),
    );
  }
}
