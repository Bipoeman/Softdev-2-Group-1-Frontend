import 'package:flutter/material.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';

class Cardcomment extends StatefulWidget {
  const Cardcomment({Key? key}) : super(key: key);

  @override
  State<Cardcomment> createState() => _CardcommentState();
}

class _CardcommentState extends State<Cardcomment> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
            height: size.height * 0.3,
            width: size.width * 0.75,
            padding: EdgeInsets.only(
              left: size.width * 0.03,
              top: size.height * 0.015,
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(35),
            ),
            child: Column(
              children: [
                Container(
                  width: size.width * 0.85,
                  height: size.height * 0.1,
                  padding: EdgeInsets.only(
                    left: 0.1,
                    top: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            "https://i.pinimg.com/564x/9b/2a/e8/9b2ae82b19caea75419be79b046b2107.jpg"),
                      ),
                      Container(
                        width: size.width * 0.5,
                        height: size.height * 0.07,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Kitty",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            FlutterRating(
                              rating: 4,
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
                  child: const Text("pun ha tham hai chun terb toe",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        height: size.height * 0.12,
                        width: size.width * 0.3,
                        // padding: EdgeInsets.only(
                        //   bottom: size.height * 0.01,
                        // ),
                        child: Image.network(
                            "https://i.pinimg.com/564x/4a/e8/43/4ae843c10e4fa8ddbfec11071265e383.jpg")),
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
      ),
    );
  }
}
