import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ruam_mitt/Restroom/Component/NavBar.dart';
import "package:ruam_mitt/global_const.dart";
import 'package:ruam_mitt/Restroom/Component/search_box.dart';
import 'package:ruam_mitt/Restroom/Component/map.dart';
import 'package:ruam_mitt/Restroom/Component/navbarza.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';

class RestroomRoverReview extends StatefulWidget {
  const RestroomRoverReview({super.key});

  @override
  State<RestroomRoverReview> createState() => _RestroomRoverReviewState();
}

class _RestroomRoverReviewState extends State<RestroomRoverReview> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var rating = 2.5;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 183, 3, 1),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: size.width,
              height: size.height,
              color: Color.fromRGBO(255, 255, 255, 1),
              child: Column(
                children: [
                  Container(
                      height: size.height * 0.3,
                      width: size.width * 0.8,
                      padding: EdgeInsets.only(
                        left: size.width * 0.01,
                        top: size.height * 0.04,
                        bottom: size.height * 0.01,
                        right: size.width * 0.01,
                      ),
                      child: Image.network(
                          "https://i.pinimg.com/564x/1c/13/1c/1c131cc30f7c203a4833b6983d025b03.jpg")),
                  Container(
                    height: size.height * 0.07,
                    width: size.width * 0.8,
                    padding: EdgeInsets.only(
                      top: size.height * 0.02,
                    ),
                    child: const Text("Tai taeuk 81",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  Container(
                    height: size.height * 0.002,
                    width: size.width * 0.8,
                    color: Color.fromRGBO(99, 99, 99, 1),
                  ),
                  Row(
                    children: [
                      Container(
                        height: size.height * 0.09,
                        width: size.width * 0.7,
                        padding: EdgeInsets.only(
                          left: size.width * 0.1,
                          top: size.height * 0.01,
                          bottom: size.height * 0.01,
                        ),
                        child: FlutterRating(
                          rating: rating,
                          size: size.height * 0.05,
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                      ),
                      Container(
                        height: size.height * 0.09,
                        width: size.width * 0.2,
                        padding: EdgeInsets.only(
                          left: size.width * 0.07,
                          top: size.height * 0.027,
                          bottom: size.height * 0.01,
                        ),
                        child: Text(
                          rating.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: size.height * 0.12,
                    width: size.width * 0.7,
                    padding: EdgeInsets.only(
                      bottom: size.height * 0.01,
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
                            onPressed: () {},
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
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 183, 3, 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ElevatedButton(
                            onPressed: () {},
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
                              Icons.report,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: size.height * 0.002,
                    width: size.width * 0.8,
                    color: Color.fromRGBO(99, 99, 99, 1),
                  ),
                  ListTile()
                ],
              ),
            ),
          ),
        ));
  }
}
