// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPinTheBin extends StatelessWidget {
  const MapPinTheBin({super.key, required this.binPos});
  final List<LatLng> binPos;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            // center: LatLng(13.825605, 100.514476),
            // center: binPos[0],
            initialCenter: binPos[0],
            zoom: 15,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: List.generate(
                binPos.length,
                (index) => Marker(
                  point: binPos[index],
                  width: 50,
                  height: 50,
                  child: GestureDetector(
                    child:
                        Image.asset("assets/images/RestroomRover/Pinred.png"),
                    onTap: () {
                      print("position $index");
                    },
                  ), //รูปหมุด
                ),
              ),
              // [
              //   Marker(
              //     point: const LatLng(13.825605, 100.514476),
              //     width: 50,
              //     height: 50,
              //      Image.asset(
              //         "assets/images/RestroomRover/Pinred.png"), //รูปหมุด
              //   ),
              //   Marker(
              //     point: const LatLng(13.826000, 100.514476),
              //     width: 50,
              //     height: 50,
              //     child: Image.asset(
              //         "assets/images/RestroomRover/Pinred.png"), //รูปหมุด
              //   ),
              // ],
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
