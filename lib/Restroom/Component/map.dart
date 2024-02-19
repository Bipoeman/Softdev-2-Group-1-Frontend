import 'package:flutter/material.dart';
import 'package:ruam_mitt/Restroom/Component/cardpin.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ruam_mitt/global_const.dart';


class MapRestroomRover extends StatelessWidget {
  static final List<Marker> _markers = [
    const LatLng(13.825605, 100.514476),
    const LatLng(13.825705, 100.514676),
    const LatLng(13.825805, 100.514976),
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
                markers: _markers,
                popupDisplayOptions: PopupDisplayOptions(
                    builder: (BuildContext context, Marker marker) {
                  return Cardpin(marker: marker);
                }),
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
        Positioned(
            width: 50,
            height: 50,
            bottom: 20,
            left: 15,
            child: RawMaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, ruamMitrPageRoute["home"]!);
                },
                child: Image(
                    image: AssetImage(
                        "assets/images/RestroomRover/backtohome.png")))),
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
