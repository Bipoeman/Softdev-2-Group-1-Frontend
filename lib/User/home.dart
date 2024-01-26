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
      body: BoxWithMainNavigator(
        child: BoxWithAvatar(
          child: IntrinsicHeight(
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Positioned(
                  top: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: size.width - 100,
                    height: 1000,
                  ),
                ),
                Positioned(
                  width: [300.0, size.width * 0.6].reduce(min),
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    child: const SearchBox(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
