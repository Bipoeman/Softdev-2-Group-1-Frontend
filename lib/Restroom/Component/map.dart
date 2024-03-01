import 'package:flutter/material.dart';
import 'package:ruam_mitt/Restroom/Component/cardpin.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class MapRestroomRover extends StatelessWidget {
  const MapRestroomRover({super.key, required this.restroomData});

  final List<dynamic> restroomData;

  static final Map<String, String> pinImg = {
    "Free": "assets/images/RestroomRover/Pingreen.png",
    "Must Paid": "assets/images/RestroomRover/Pinred.png",
    "Toilet In Stores": "assets/images/RestroomRover/Pinorange.png"
  };

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = restroomData
        .map((restroom) => Marker(
              point: LatLng(restroom["latitude"].toDouble(),
                  restroom["longitude"].toDouble()),
              width: 40,
              height: 40,
              rotate: true,
              child: Image.asset(pinImg[restroom["type"]]!),
            ))
        .toList();

    return Stack(
      children: [
        FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(13.825605, 100.514476),
            initialZoom: 15,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            // PopupMarkerLayer(options: options)
            PopupMarkerLayer(
              options: PopupMarkerLayerOptions(
                markers: markers,
                popupDisplayOptions: PopupDisplayOptions(
                    builder: (BuildContext context, Marker marker) {
                  return Cardpin(marker: marker, restroomData: restroomData);
                }),
              ),
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
            CurrentLocationLayer(
              // followOnLocationUpdate: FollowOnLocationUpdate.always,
              // turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
              style: const LocationMarkerStyle(
                marker: DefaultLocationMarker(
                  child: Icon(
                    Icons.navigation,
                    color: Colors.white,
                  ),
                ),
                markerSize: Size(40, 40),
                markerDirection: MarkerDirection.heading,
              ),
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
      ],
    );
  }
}
