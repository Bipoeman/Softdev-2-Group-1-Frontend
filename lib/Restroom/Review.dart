import 'package:flutter/material.dart';
import 'package:ruam_mitt/Restroom/Component/write_review.dart';
import 'package:ruam_mitt/Restroom/Component/comment.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'dart:math';

class RestroomRoverReview extends StatefulWidget {
  const RestroomRoverReview({super.key});

  @override
  State<RestroomRoverReview> createState() => _RestroomRoverReviewState();
}

class _RestroomRoverReviewState extends State<RestroomRoverReview> {
  BoxController boxController = BoxController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var rating = 2.5;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 183, 3, 1),
        actions: <Widget>[
          Container(
            width: size.width,
            height: size.width * 0.2,
            color: const Color.fromRGBO(255, 183, 3, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: size.width * 0.3,
                  height: size.width * 0.2,
                  child: Image.network(
                    "https://scontent.fbkk19-1.fna.fbcdn.net/v/t31.18172-8/21741034_1310767655696630_2026636052713423518_o.jpg?_nc_cat=105&cb=99be929b-b574a898&ccb=1-7&_nc_sid=7a1959&_nc_eui2=AeHvdWjoi2M2_3JxecgVYF3wc2i7SYkoRFdzaLtJiShEV-rrQE3QEd5V8X0pC86UQd2WmnoSWSxrEz6VoVS28p6D&_nc_ohc=Rv0UM4XJje8AX8TIx0P&_nc_ht=scontent.fbkk19-1.fna&oh=00_AfCmH6XQGv7tDLkMOniqrq1trwwMvFGd3n-mE8v4EoA3xw&oe=65F8102D",
                  ),
                ),
                Container(
                  width: size.width * 0.6,
                  height: size.height * 0.5,
                  padding: EdgeInsets.only(
                    left: size.width * 0.4,
                    top: size.height * 0.005,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      body: SlidingBox(
        controller: boxController,
        physics: const NeverScrollableScrollPhysics(),
        collapsed: true,
        minHeight: 0,
        maxHeight: 460,
        draggable: false,
        onBoxClose: () => FocusManager.instance.primaryFocus?.unfocus(),
        body: ReviewSlideBar(cancelOnPressed: boxController.closeBox),
        backdrop: Backdrop(
          moving: false,
          overlay: true,
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height -
                    [size.width * 0.4, 100.0].reduce(min) -
                    MediaQuery.of(context).padding.top,
              ),
              child: Center(
                child: IntrinsicHeight(
                  // width: size.width,
                  // height: size.height,
                  // color: const Color.fromRGBO(230, 230, 230, 1),
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
                          "https://i.pinimg.com/564x/1c/13/1c/1c131cc30f7c203a4833b6983d025b03.jpg",
                        ),
                      ),
                      Container(
                        height: size.height * 0.07,
                        width: size.width * 0.8,
                        padding: EdgeInsets.only(
                          top: size.height * 0.02,
                        ),
                        child: const Text(
                          "Tai taeuk 81",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        height: size.height * 0.002,
                        width: size.width * 0.85,
                        color: const Color.fromRGBO(99, 99, 99, 1),
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
                                color: const Color.fromRGBO(255, 183, 3, 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  // showSlidingBox(
                                  //   context: context,
                                  //   box: SlidingBox(
                                  //     draggable: false,
                                  //     maxHeight: maxBoxHeight,
                                  //     body: ReviewSlideBar(
                                  //       setHeight: setMaxBoxHeight,
                                  //     ),
                                  //   ),
                                  // );
                                  boxController.openBox();
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    const Color.fromRGBO(255, 183, 3, 1),
                                  ),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
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
                                color: const Color.fromRGBO(255, 183, 3, 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    const Color.fromRGBO(255, 183, 3, 1),
                                  ),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
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
                        width: size.width * 0.85,
                        color: const Color.fromRGBO(99, 99, 99, 1),
                      ),
                      SizedBox(height: 15),
                      // Cardcomment(),
                      // Cardcomment(),
                      // Cardcomment(),
                      // Cardcomment(),
                      // Cardcomment(),
                      // Cardcomment(),
                      // Cardcomment(),
                      // Cardcomment(),
                      Expanded(
                        child: Column(
                          children: [
                            for (int i = 0; i < 8; i++) // จำนวน Cardcomment ที่ต้องการแสดง
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical : 10), // เพิ่มระยะห่าง 10 หน่วยด้านบนและด้านล่างของ Cardcomment
                                child: Cardcomment(),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
