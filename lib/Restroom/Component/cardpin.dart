import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';
import 'package:ruam_mitt/Restroom/Component/font.dart';
import 'package:ruam_mitt/Restroom/Component/interactive_image.dart';
import 'package:ruam_mitt/Restroom/Component/theme.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:url_launcher/url_launcher.dart';

class Cardpin extends StatelessWidget {
  const Cardpin({super.key, required this.marker, required this.restroomData});
  final Marker marker;
  final Map<String, dynamic> restroomData;

  @override
  Widget build(BuildContext context) {
    MapController mapController = MapController.of(context);
    MapCamera camera = mapController.camera;
    double zoomFactor = _mapRange(
            camera.zoom, camera.minZoom ?? 10, camera.maxZoom ?? 20, 0.5, 1)
        .clamp(0.5, 1);
    Size size = MediaQuery.of(context).size * zoomFactor;

    return Theme(
        data: RestroomThemeData,
        child: Builder(builder: (context) {
          return IntrinsicHeight(
            child: Container(
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(35 * zoomFactor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(
                        left: size.width * 0.1,
                        top: size.height * 0.03,
                        bottom: size.height * 0.01,
                        right: size.width * 0.1,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150 * zoomFactor,
                            child: Text(
                              restroomData["name"],
                              overflow: TextOverflow.ellipsis,
                              style: name_place(restroomData["name"], context,
                                  size: zoomFactor),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                restroomData["for_who"]["Handicapped"]
                                    ? Icon(Icons.accessible_sharp,
                                        size: 30 * zoomFactor)
                                    : SizedBox(
                                        width: 30 * zoomFactor,
                                        height: 30 * zoomFactor,
                                      ),
                                restroomData["for_who"]["Kid"]
                                    ? Icon(Icons.baby_changing_station,
                                        size: 30 * zoomFactor)
                                    : SizedBox(
                                        width: 30 * zoomFactor,
                                        height: 30 * zoomFactor,
                                      ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  IntrinsicHeight(
                    child: Container(
                      width: size.width * 0.7,
                      padding: EdgeInsets.only(
                        left: size.width * 0.1,
                        top: size.height * 0.001,
                        bottom: size.height * 0.01,
                        right: size.width * 0.1,
                      ),
                      child: Text(restroomData["address"],
                          overflow: TextOverflow.ellipsis,
                          style: text_input(restroomData["address"], context,
                              size: zoomFactor)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          restroomData["avg_star"]?.toStringAsFixed(1) ?? "0.0",
                          style: text_input(restroomData["address"], context,
                              size: zoomFactor)),
                      SizedBox(
                        height: size.height * 0.05,
                        width: size.width * 0.35,
                        child: FlutterRating(
                          rating: restroomData["avg_star"]?.toDouble() ?? 0.0,
                          size: size.height * 0.03,
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ),
                      // ),
                      Text("[ ${restroomData["count"] ?? 0} ]",
                          style: text_input(restroomData["address"], context,
                              size: zoomFactor)),
                    ],
                  ),
                  Center(
                    child: RestroomInteractiveImage(
                      picture: restroomData["picture"] ??
                          "https://media.discordapp.net/attachments/1033741246683942932/1213677182161920020/toilet_sign.png?ex=65f657f5&is=65e3e2f5&hm=69aa24e997ae288613645b0c45363aea72cdb7d9f0cbabacbfe7a3f04d6047ea&=&format=webp&quality=lossless&width=702&height=702",
                      height: size.height * 0.21,
                      borderRadius: 15 * zoomFactor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          debugPrint("Navigate me");
                          String googleMapUrl =
                              'https://www.google.com/maps/search/?api=1&query=${marker.point.latitude},${marker.point.longitude}';
                          Uri googleUrl = Uri.parse(googleMapUrl);
                          if (!await launchUrl(googleUrl)) {
                            throw Exception('Could not launch $googleMapUrl');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(size.width * 0.25, size.height * 0.06),
                          backgroundColor: const Color.fromRGBO(255, 183, 3, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10 * zoomFactor),
                          ),
                        ),
                        child: Icon(
                          Icons.directions,
                          color: Colors.black,
                          size: 35 * zoomFactor,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, restroomPageRoute["review"]!,
                              arguments: restroomData);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(size.width * 0.25, size.height * 0.06),
                          backgroundColor: const Color.fromRGBO(255, 183, 3, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10 * zoomFactor),
                          ),
                        ),
                        child: Icon(
                          Icons.reviews,
                          color: Colors.black,
                          size: 35 * zoomFactor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }));
  }

  double _mapRange(double input, double inputStart, double inputEnd,
      double outputStart, double outputEnd) {
    return outputStart +
        ((outputEnd - outputStart) / (inputEnd - inputStart)) *
            (input - inputStart);
  }
}
