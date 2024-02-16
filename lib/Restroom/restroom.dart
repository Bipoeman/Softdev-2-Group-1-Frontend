import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ruam_mitt/Restroom/Component/NavBar.dart';
import "package:ruam_mitt/global_const.dart";
import 'package:ruam_mitt/Restroom/Component/search_box.dart';
import 'package:ruam_mitt/Restroom/Component/map.dart';
class RestroomRover extends StatefulWidget {
  const RestroomRover({super.key});

  @override
  State<RestroomRover> createState() => _RestroomRoverState();
}

class _RestroomRoverState extends State<RestroomRover> {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        
        //  flexibleSpace: Container(
        //       padding: const EdgeInsets.only(top: 15),
        //       height: 56,
        //       width: size.width * 0.5,
        //       child: const RestroomSearchBox(),
        //     ),
      ),
      drawer: NavbarRestroomRover() ,
      body: MapRestroomRover()
      
    );
  }
}
