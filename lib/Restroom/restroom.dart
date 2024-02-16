import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ruam_mitt/Restroom/Component/NavBar.dart';
import "package:ruam_mitt/global_const.dart";
import 'package:ruam_mitt/Restroom/Component/search_box.dart';
import 'package:ruam_mitt/Restroom/Component/map.dart';
import 'package:ruam_mitt/Restroom/Component/navbarza.dart';

class RestroomRover extends StatefulWidget {
  const RestroomRover({super.key});

  @override
  State<RestroomRover> createState() => _RestroomRoverState();
}

class _RestroomRoverState extends State<RestroomRover> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey, // กำหนด GlobalKey ให้กับ Scaffold
        appBar: AppBar(
          title : SizedBox(width: 300,child : RestroomSearchBox(),),
          backgroundColor: Color(0xFFFFB703),
          leading: IconButton(
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
                color: Colors.white,
              ),
              child: Center(
                child: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
            ),
            onPressed: () {
              _scaffoldKey.currentState
                  ?.openDrawer(); // เรียกใช้งาน ScaffoldState เพื่อเปิด Drawer
            },
          ),
        ),
        drawer: Navbar2RestroomRover(),
        body: MapRestroomRover(),
        // drawerEdgeDragWidth: 500,
        );
        
  }
}
