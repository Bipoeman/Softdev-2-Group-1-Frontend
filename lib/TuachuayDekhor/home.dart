import "package:flutter/material.dart";
import "package:ruam_mitt/TuachuayDekhor/Component/search_box.dart";
import 'package:ruam_mitt/global_const.dart';
import "dart:math";

class TuachuayDekhorHomePage extends StatefulWidget {
  const TuachuayDekhorHomePage({super.key});

  @override
  State<TuachuayDekhorHomePage> createState() => _TuachuayDekhorHomePageState();
}

class _TuachuayDekhorHomePageState extends State<TuachuayDekhorHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: size.height -
                    [size.width * 0.4, 100.0].reduce(min) -
                    MediaQuery.of(context).padding.top),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: size.width * 0.6,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.3,
                      image: AssetImage("assets/images/Background/TuachuayDekhor_Home.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.width * 0.175,
                            width: size.width * 0.175,
                            child: const Image(
                              image: AssetImage(
                                  "assets/images/Logo/TuachuayDekhor_Light.png"),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 12.5),
                        width: size.width * 0.5,
                        child: const TuachuaySearchBox(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10, top: 10),
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              height: size.width * 0.125,
                              width: size.width * 0.125,
                              child: RawMaterialButton(
                                shape: const CircleBorder(),
                                fillColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  size: size.width * 0.075,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, ruamMitrPageRoute["profile"]!);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Column(
                  children: [
                    Text("Catagories"),
                    Text("Blogger"),
                    Text("DekHor Recommended"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
