import "package:flutter/material.dart";
import "package:ruam_mitt/Component/main_navigator.dart";
import "package:ruam_mitt/Component/avatar.dart";
import "package:ruam_mitt/Component/search_box.dart";
import "dart:math";

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
      body: const BoxWithMainNavigator(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AvatarViewer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
