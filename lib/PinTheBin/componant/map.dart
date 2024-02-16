// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPinTheBin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: const MapOptions(
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
                  point: const LatLng(13.825605, 100.514476),
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
      ],
    );
  }
}
