import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ruam_mitt/Restroom/Component/cardpin.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class MapRestroomRover extends StatelessWidget {
  const MapRestroomRover(
      {super.key, required this.restroomData, this.mapController});

  final List<dynamic> restroomData;
  final MapController? mapController;

  static final Map<String, String> pinImg = {
    "Free": "assets/images/RestroomRover/Pingreen.png",
    "Must Paid": "assets/images/RestroomRover/Pinred.png",
    "Toilet In Stores": "assets/images/RestroomRover/Pinorange.png",
  };
  
  @override
  Widget build(BuildContext context) {
    List<Marker> markers = restroomData.map((restroom) {
    final String type = restroom["type"];
    return Marker(
      point: LatLng(
        restroom["latitude"].toDouble(),
        restroom["longitude"].toDouble(),
      ),
      width: 50,
      height: 50,
      // rotate: true,
      child: type == "Toilet In Stores"
          ? Image.asset(
              pinImg[type]!,
      
            )
          :  Image.asset(
              pinImg[type]!,
              width: 50,
              height: 50,
              scale:5.2,
              
            )
    );
  }).toList();
    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
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
                  Map<String, dynamic> data = restroomData
                      .filter((restroom) =>
                          restroom["latitude"].toDouble() ==
                              marker.point.latitude &&
                          restroom["longitude"].toDouble() ==
                              marker.point.longitude)
                      .single;
                  return Cardpin(marker: marker, restroomData: data);
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
