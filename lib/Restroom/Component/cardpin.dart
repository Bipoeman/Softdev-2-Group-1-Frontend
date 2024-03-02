import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';
import 'package:ruam_mitt/Restroom/Component/theme.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:url_launcher/url_launcher.dart';

class Cardpin extends StatefulWidget {
  const Cardpin({super.key, required this.marker, required this.restroomData});
  final Marker marker;
  final Map<String, dynamic> restroomData;

  @override
  State<Cardpin> createState() => _CardpinState();
}

class _CardpinState extends State<Cardpin> {
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
          return Container(
            height: size.height * 0.52,
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
                            widget.restroomData["name"],
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              widget.restroomData["for_who"]["Handicapped"]
                                  ? Icon(Icons.accessible_sharp,
                                      size: 30 * zoomFactor)
                                  : SizedBox(
                                      width: 30 * zoomFactor,
                                      height: 30 * zoomFactor,
                                    ),
                              widget.restroomData["for_who"]["Kid"]
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
                Container(
                  height: size.height * 0.05,
                  width: size.width * 0.7,
                  padding: EdgeInsets.only(
                    left: size.width * 0.1,
                    top: size.height * 0.001,
                    bottom: size.height * 0.01,
                    right: size.width * 0.1,
                  ),
                  child: Text(widget.restroomData["address"],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20 * zoomFactor,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                Row(
                  children: [
                    Container(
                      height: size.height * 0.05,
                      width: size.width * 0.2,
                      padding: EdgeInsets.only(
                        left: size.width * 0.1,
                        top: size.height * 0.01,
                      ),
                      child: Text(
                          widget.restroomData["avg_star"]?.toStringAsFixed(1) ??
                              "0.0",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17 * zoomFactor,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    Container(
                      height: size.height * 0.05,
                      width: size.width * 0.35,
                      padding: EdgeInsets.only(
                        left: size.width * 0.01,
                        top: size.height * 0.01,
                        bottom: size.height * 0.01,
                        right: size.width * 0.01,
                      ),
                      child: FlutterRating(
                        rating:
                            widget.restroomData["avg_star"]?.toDouble() ?? 0.0,
                        size: size.height * 0.03,
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                    // ),
                    Container(
                      height: size.height * 0.05,
                      width: size.width * 0.15,
                      padding: EdgeInsets.only(
                        left: size.width * 0.01,
                        top: size.height * 0.01,
                      ),
                      child: Text("[ ${widget.restroomData["count"] ?? 0} ]",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17 * zoomFactor,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.1,
                      top: size.height * 0.01,
                      bottom: size.height * 0.01,
                      right: size.width * 0.1,
                    ),
                    child: SizedBox(
                      height: size.height * 0.21,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          widget.restroomData["picture"] ??
                              "https://i.pinimg.com/564x/97/15/0f/97150f3cc7e93677495133ffe6ea77c3.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    height: size.height * 0.1,
                    width: size.width * 0.8,
                    padding: EdgeInsets.only(
                      left: size.width * 0.1,
                      top: size.height * 0.01,
                      bottom: size.height * 0.01,
                      right: size.width * 0.1,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 183, 3, 1),
                            borderRadius:
                                BorderRadius.circular(20 * zoomFactor),
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              debugPrint("Navigate me");
                              String googleMapUrl =
                                  'https://www.google.com/maps/search/?api=1&query=${widget.marker.point.latitude},${widget.marker.point.longitude}';
                              Uri googleUrl = Uri.parse(googleMapUrl);
                              if (!await launchUrl(googleUrl)) {
                                throw Exception(
                                    'Could not launch $googleMapUrl');
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromRGBO(255, 183, 3, 1)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10 * zoomFactor),
                                ),
                              ),
                            ),
                            child: Icon(
                              Icons.directions,
                              color: Colors.black,
                              size: 30 * zoomFactor,
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 183, 3, 1),
                            borderRadius:
                                BorderRadius.circular(20 * zoomFactor),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                      context, restroomPageRoute["review"]!,
                                      arguments: widget.restroomData)
                                  .then((value) {
                                setState(() {});
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromRGBO(255, 183, 3, 1)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10 * zoomFactor),
                                ),
                              ),
                            ),
                            child: Icon(
                              Icons.reviews,
                              color: Colors.black,
                              size: 30 * zoomFactor,
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
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
