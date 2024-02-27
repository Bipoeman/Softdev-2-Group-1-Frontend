import "package:flutter/material.dart";
import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class RestroomRoverFindPosition extends StatefulWidget {
  const RestroomRoverFindPosition({
    super.key,
  });

  @override
  State<RestroomRoverFindPosition> createState() =>
      _RestroomRoverFindPositionState();
}

class _RestroomRoverFindPositionState extends State<RestroomRoverFindPosition> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MapController editMapController = MapController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(
            bottom: size.height * 0.15,
            // left: size.width* 0.2 ,
            ), // ขยับปุ่มขึ้นจากด้านล่าง 25%
        width: size.width * 0.45,
        height: size.height * 0.06,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black), // เพิ่มเส้นขอบสีดำ
          borderRadius:
              BorderRadius.circular(13), // กำหนดรูปร่างของปุ่มเป็นวงกลม
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context, editMapController.camera.center);
          },
          backgroundColor: Color(0xFFE6E6E6),
          child: Text(
            "Confirm Location",
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF000000),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          FlutterMap(
            mapController: editMapController,
            options: const MapOptions(
              initialCenter: LatLng(13.825605, 100.514476),
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: const LatLng(13.825605, 100.514476),
                    width: 50,
                    height: 50,
                    child: Image.asset(
                        "assets/images/RestroomRover/Pinred.png"), //รูปหมุด
                  ),
                  Marker(
                    point: const LatLng(13.826000, 100.514476),
                    width: 50,
                    height: 50,
                    child: Image.asset(
                        "assets/images/RestroomRover/Pinred.png"), //รูปหมุด
                  ),
                ],
              ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () => launchUrl(Uri.parse('')),
                  ),
                ],
              ),
            ],
          ),
          const Center(
            child: Icon(
              Icons.location_on,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
