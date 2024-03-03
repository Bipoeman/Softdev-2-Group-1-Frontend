import "package:flutter/material.dart";
import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapaddBinPage extends StatefulWidget {
  const MapaddBinPage({
    super.key,
  });

  @override
  State<MapaddBinPage> createState() => _MapaddBinPageState();
}

class _MapaddBinPageState extends State<MapaddBinPage> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MapController editMapController = MapController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          width: size.width * 0.25,
          height: size.height * 0.05,
          decoration: BoxDecoration(
              color: Color(0xFFF9957F),
              borderRadius: BorderRadius.circular(30)),
          child: Text(
            "Confirm",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        onTap: () {
          Navigator.pop(context, editMapController.camera.center);
        },
      ),
      body: Stack(
        children: [
          // Padding(
          //   padding: EdgeInsets.only(top: 30),
          //   child: InkWell(
          //     child: Ink(
          //       width: 100,
          //       height: 100,
          //       decoration: BoxDecoration(color: Colors.amber),
          //       child: Text("Confirm"),
          //     ),
          //     onTap: () {
          //       Navigator.pop(context, editMapController.camera.center);
          //     },
          //   ),
          // ),
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
