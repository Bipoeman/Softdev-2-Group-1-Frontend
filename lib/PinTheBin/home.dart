import "dart:math";

import "package:flutter/material.dart";
import "package:ruam_mitt/PinTheBin/componant/search.dart";
import "package:ruam_mitt/PinTheBin/navbar.dart";
import "package:ruam_mitt/PinTheBin/componant/map.dart";

class BinPage extends StatefulWidget {
  const BinPage({super.key});

  @override
  State<BinPage> createState() => _BinPageState();
}

class _BinPageState extends State<BinPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            MapPinTheBin(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  width: [300.0, size.width * 0.7].reduce(min),
                  child: const SearchBin(),
                ),
              ],
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF77F00),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(Icons.menu),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const NavBar(),
    );
  }
}
