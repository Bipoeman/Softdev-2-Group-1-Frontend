import 'package:flutter/material.dart';
import 'package:ruam_mitt/Restroom/Component/cardpin.dart';
import 'package:ruam_mitt/Restroom/Component/search_box.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ruam_mitt/Restroom/Component/comment.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';


class MapRestroomRover extends StatelessWidget {
  static final List<Marker> _markers = [
    const LatLng(13.825605, 100.514476),
    const LatLng(45.683, 10.839),
    const LatLng(45.246, 5.783),
  ]
      .map(
        (markerPosition) => Marker(
          point: markerPosition,
          width: 40,
          height: 40,
          // alignment: Alignment.topCenter,
          child: Image.asset("assets/images/RestroomRover/Pinred.png"),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            // PopupMarkerLayer(options: options)
            PopupMarkerLayer(
              options: PopupMarkerLayerOptions(
                markers: _markers,
                popupDisplayOptions: PopupDisplayOptions(
                    builder: (BuildContext context, Marker marker) =>
                        Cardpin()),
              ),
            ),
            // MarkerLayer(

            //   markers: [
            //     Marker(

            //       point: LatLng(13.825605, 100.514476),
            //       width: 50,
            //       height: 50,
            //       child: Image.asset("assets/images/RestroomRover/Pinred.png"),

            //     ),
            //   ],
            // ),
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
              style: LocationMarkerStyle(
                marker: const DefaultLocationMarker(
                  child: Icon(
                    Icons.navigation,
                    color: Colors.white,
                  ),
                ),
                markerSize: const Size(40, 40),
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
        // Positioned(
        //   bottom: 20,
        //   left: 5,
        //   child: SizedBox(
        //     width: 300,
        //     height: 400,
        //     child: Cardpin(), // สร้าง Cardpin ขึ้นมาเป็น StatefulWidget
        //   ),
        // ),
        // Cardpin()
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
    );

  }
}
