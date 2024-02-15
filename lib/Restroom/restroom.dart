import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ruam_mitt/Restroom/Component/NavBar.dart';
import "package:ruam_mitt/global_const.dart";
import 'package:ruam_mitt/Restroom/Component/search_box.dart';
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
      // appBar: AppBar(
      //    flexibleSpace: Container(
      //         padding: const EdgeInsets.only(top: 15),
      //         height: 56,
      //         width: size.width * 0.5,
      //         child: const RestroomSearchBox(),
      //       ),
      // ),
      // drawer: NavbarRestroomRover() ,
      body: Stack(
        children: [
          
          FlutterMap(
            options: MapOptions(
              center: LatLng(13.825605, 100.514476),
              zoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(13.825605, 100.514476),
                    width: 50,
                    height: 50,
                    child:
                        Image.asset("assets/images/RestroomRover/Pinred.png"),
                  ),
                ],
              ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () => launchUrl(
                        Uri.parse('https://openstreetmap.org/copyright')),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
              bottom: 20,
              right: 5,
              child: Image.asset(
                "assets/images/RestroomRover/type.png",
                width: 130,
                height: 130,
              )),
           NavbarRestroomRover()
          // Positioned(
          //     child: NavbarRestroomRover(),
          //     ),
         
          // Positioned(
          //     top: 20,
          //     right: 5,
          //     child: Image.asset(
          //       "assets/images/RestroomRover/type.png",
          //       width: 130,
          //       height: 130,
          //     ))
              
        ],
      ),
      
    );
  }
}
