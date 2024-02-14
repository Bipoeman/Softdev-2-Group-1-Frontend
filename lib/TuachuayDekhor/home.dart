import "package:flutter/material.dart";
import "package:ruam_mitt/TuachuayDekhor/Component/navbar.dart";
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
                Stack(
                  children: [
                    Container(
                      height: size.width * 0.6,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          opacity: 0.3,
                          image: AssetImage(
                              "assets/images/Background/TuachuayDekhor_Home.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const NavbarTuachuayDekhor(),
                  ],
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
