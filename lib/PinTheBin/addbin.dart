import "package:flutter/material.dart";
import 'package:ruam_mitt/PinTheBin/navbar.dart';

class AddbinPage extends StatefulWidget {
  const AddbinPage({super.key});

  @override
  State<AddbinPage> createState() => _AddbinPageState();
}

class _AddbinPageState extends State<AddbinPage> {
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
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              //padding: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(top: 50),
              child: Text('Add Bin',
                  style: GoogleFonts.getFont(
                    "Sen",
                    color: Color(0xFFF77F00),
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Text(
                      'Locations',
                      style: GoogleFonts.getFont(
                        'Sen',
                        color: const Color(0xFFF77F00),
                        fontSize: 18,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                ),
              ),
                ),
              ),
            ],
          ),
        )
        drawer: const NavBar(),
      );
  }
}
