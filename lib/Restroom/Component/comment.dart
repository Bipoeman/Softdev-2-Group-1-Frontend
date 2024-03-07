import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';
import 'package:ruam_mitt/Restroom/Component/font.dart';
import 'package:ruam_mitt/Restroom/Component/interactive_image.dart';
import 'package:ruam_mitt/Restroom/Component/theme.dart';

class Cardcomment extends StatefulWidget {
  const Cardcomment({super.key, required this.cardData});
  final Map<String, dynamic> cardData;

  @override
  State<Cardcomment> createState() => _CardcommentState();
}

class _CardcommentState extends State<Cardcomment> {
  File? compressedImage;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Theme(
        data: RestroomThemeData,
        child: Builder(builder: (context) {
          return Center(
            child: IntrinsicHeight(
              child: Container(
                width: size.width * 0.85,
                padding: EdgeInsets.only(
                  left: size.width * 0.03,
                  top: size.height * 0.015,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Column(
                  children: [
                    Container(
                      width: size.width * 0.85,
                      height: size.height * 0.1,
                      padding: const EdgeInsets.only(
                        left: 0.1,
                        top: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(widget
                                    .cardData["user_info"]["profile"] ??
                                "https://i.pinimg.com/564x/9b/2a/e8/9b2ae82b19caea75419be79b046b2107.jpg"),
                          ),
                          SizedBox(
                            width: size.width * 0.5,
                            height: size.height * 0.07,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.cardData["user_info"]["username"],
                                  style: name_place(
                                      widget.cardData["user_info"]["username"],
                                      context),
                                ),
                                FlutterRating(
                                  rating: widget.cardData["star"].toDouble(),
                                  size: size.height * 0.0255,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.cardData["picture"] != null
                            ? RestroomInteractiveImage(
                                picture: widget.cardData["picture"],
                                width: size.width * 0.3,
                                height: size.height * 0.2,
                              )
                            : Container(),
                        Container(
                          width: size.width * 0.5,
                          padding: EdgeInsets.only(
                            left: size.width * 0.03,
                            top: size.height * 0.01,
                          ),
                          child: Text(
                            widget.cardData["comment"] != null
                                ? (widget.cardData["comment"].length > 150
                                    ? widget.cardData["comment"]
                                            .substring(0, 147) +
                                        "..."
                                    : widget.cardData["comment"])
                                : "",
                            textAlign: TextAlign.start,
                            style:
                                text_input(widget.cardData["comment"], context),
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: size.height * 0.02)),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
