import 'package:flutter/material.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';

class Cardcomment extends StatefulWidget {
  const Cardcomment({super.key, required this.cardData});
  final Map<String, dynamic> cardData;

  @override
  State<Cardcomment> createState() => _CardcommentState();
}

class _CardcommentState extends State<Cardcomment> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
          height: size.height * 0.3,
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
                      backgroundImage: NetworkImage(widget.cardData["user_info"]
                              ["profile"] ??
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
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
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
              Container(
                width: size.width * 0.85,
                height: size.height * 0.05,
                padding: EdgeInsets.only(
                  left: size.width * 0.03,
                  top: size.height * 0.01,
                ),
                child: Text(widget.cardData["comment"] ?? "",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  widget.cardData["picture"] != null
                      ? SizedBox(
                          height: size.height * 0.12,
                          width: size.width * 0.3,
                          // padding: EdgeInsets.only(
                          //   bottom: size.height * 0.01,
                          // ),
                          child: Image.network(widget.cardData["picture"]))
                      : Container(),
                  const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.thumb_up_alt_rounded),
                  ),
                  const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.thumb_down_alt_rounded),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
