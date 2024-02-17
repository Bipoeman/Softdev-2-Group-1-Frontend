import "package:flutter/material.dart";
import 'package:ruam_mitt/PinTheBin/NavBar.dart';

Color colorbackground = const Color(000000);

class EditbinPage extends StatefulWidget {
  const EditbinPage({super.key});

  @override
  State<EditbinPage> createState() => _EditbinPageState();
}

class _EditbinPageState extends State<EditbinPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
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
                        borderRadius: BorderRadius.circular(15)),
                    child: const Icon(Icons.menu),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      drawer: const NavBar(),
    );
  }
}
