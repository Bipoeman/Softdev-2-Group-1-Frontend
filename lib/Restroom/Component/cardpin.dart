import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:url_launcher/url_launcher.dart';

class Cardpin extends StatefulWidget {
  const Cardpin({super.key, required this.marker});
  final Marker marker;

  @override
  State<Cardpin> createState() => _CardpinState();
}

class _CardpinState extends State<Cardpin> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.55,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height * 0.09,
            width: size.width * 0.7,
            // color: Color.fromARGB(255, 255, 255, 255),
            padding: EdgeInsets.only(
              left: size.width * 0.1,
              top: size.height * 0.03,
              bottom: size.height * 0.01,
              right: size.width * 0.1,
            ),
            child: const Text("Bally",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 27,
                  fontWeight: FontWeight.w600,
                )),
          ),
          Container(
            height: size.height * 0.05,
            width: size.width * 0.7,
            padding: EdgeInsets.only(
              left: size.width * 0.1,
              top: size.height * 0.001,
              bottom: size.height * 0.01,
              right: size.width * 0.1,
            ),
            child: const Text("97/2 บางซ่อน",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
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
                child: const Text("5.0",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
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
                  rating: 3.5,
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
                child: const Text("[ 9 ]",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ],
          ),
          Container(
              height: size.height * 0.21,
              width: size.width * 0.8,
              padding: EdgeInsets.only(
                left: size.width * 0.1,
                top: size.height * 0.01,
                bottom: size.height * 0.01,
                right: size.width * 0.1,
              ),
              child: Image.network(
                  "https://i.pinimg.com/564x/97/15/0f/97150f3cc7e93677495133ffe6ea77c3.jpg")),
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
                      color: Color.fromRGBO(255, 183, 3, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        debugPrint("Navigate me");
                        String googleMapUrl =
                            'https://www.google.com/maps/search/?api=1&query=${widget.marker.point.latitude},${widget.marker.point.longitude}';
                        Uri googleUrl = Uri.parse(googleMapUrl);
                        if (!await launchUrl(googleUrl)) {
                          throw Exception('Could not launch $googleMapUrl');
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(255, 183, 3, 1)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.directions,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.06,
                    width: size.width * 0.25,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 183, 3, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, restroomPageRoute["review"]!);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(255, 183, 3, 1)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.reviews,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
