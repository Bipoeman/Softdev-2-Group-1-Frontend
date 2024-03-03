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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, editMapController.camera.center);
        },
      ),
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
