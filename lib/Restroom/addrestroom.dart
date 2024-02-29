import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ruam_mitt/Restroom/Component/navbar.dart';
import 'package:ruam_mitt/Restroom/Component/theme.dart';
import 'package:ruam_mitt/Restroom/Component/write_review.dart';
import 'package:ruam_mitt/Restroom/Component/comment.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'dart:math';

class RestroomRoverAddrestroom extends StatefulWidget {
  const RestroomRoverAddrestroom({super.key});

  @override
  State<RestroomRoverAddrestroom> createState() =>
      _RestroomRoverAddrestroomState();
}

class _RestroomRoverAddrestroomState extends State<RestroomRoverAddrestroom> {
  BoxController boxController = BoxController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _LocationstextController = TextEditingController();
  TextEditingController _DescriptiontextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var rating = 2.5;
    return Theme(
      data: RestroomThemeData,
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 150),
              height: size.height * 0.12,
              width: size.width * 0.7,
              padding: EdgeInsets.only(
                bottom: size.height * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Text(
                        'Name',
                        style: GoogleFonts.getFont(
                          'Sen',
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF77F00).withOpacity(0.45),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextField(
                      scrollPadding: EdgeInsets.all(5),
                      controller: _LocationstextController,
                      onChanged: (text) {
                        print('Typed text: $text');
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            RestroomAppBar(scaffoldKey: _scaffoldKey),
          ],
        ),
        drawerScrimColor: Colors.transparent,
        drawer: RestroomRoverNavbar(),
      ),
    );
  }
}

class RestroomAppBar extends StatelessWidget {
  const RestroomAppBar({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFFFFB330),
            Color(0xFFFFE9A6),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              GestureDetector(
                child: Icon(
                  Icons.menu_rounded,
                  size: Theme.of(context).appBarTheme.iconTheme!.size,
                  color: Theme.of(context).appBarTheme.iconTheme!.color,
                ),
                onTap: () {
                  debugPrint("Open Drawer");
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              const SizedBox(width: 10),
              Text(
                "Add Restroom",
                style: TextStyle(
                  fontSize:
                      Theme.of(context).textTheme.headlineMedium!.fontSize,
                  fontWeight:
                      Theme.of(context).textTheme.headlineMedium!.fontWeight,
                  color: Theme.of(context).textTheme.headlineMedium!.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
