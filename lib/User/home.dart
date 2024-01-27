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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AvatarViewer(),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(32),
              child: IntrinsicHeight(
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 25,
                      width: [size.width * 0.8, 800.0].reduce(min),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(15, 40, 15, 15),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome to RuamMitr Portal App",
                              style: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget aliquam ultricies, nunc nisl ultricies nunc, vitae aliquam nisl nisl vitae nisl. Donec euismod, nisl eget aliquam ultricies, nunc nisl ultricies nunc, vitae aliquam nisl nisl vitae nisl.",
                              style: TextStyle(
                                color: textColor,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: [300.0, size.width * 0.5].reduce(min),
                      child: const SearchBox(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
