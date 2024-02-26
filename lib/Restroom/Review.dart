import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ruam_mitt/Restroom/Component/NavBar.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var rating = 2.5;
    return Theme(
      data: ThemeData(
        fontFamily: "Sen",
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFB330),
          background: const Color(0xFFECECEC),
        ),
        textTheme: TextTheme(
          headlineMedium: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w800,
            color: Color.fromARGB(255, 112, 110, 110),
          ),
          headlineSmall: TextStyle(
            fontSize: 30,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF003049),
            shadows: [
              Shadow(
                blurRadius: 20,
                offset: const Offset(0, 3),
                color: const Color(0xFF003049).withOpacity(0.3),
              ),
            ],
          ),
          displayMedium: TextStyle(
            fontSize: 20,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF003049).withOpacity(0.69),
          ),
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white,
            size: 35,
          ),
        ),
        drawerTheme: const DrawerThemeData(
          scrimColor: Colors.transparent,
          backgroundColor: Color(0xFFFFFFFF),
        ),
        searchBarTheme: SearchBarThemeData(
          textStyle: MaterialStatePropertyAll(
            TextStyle(
              fontFamily: GoogleFonts.getFont("Inter").fontFamily,
              color: Colors.black,
            ),
          ),
        ),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: SlidingBox(
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
                                width: size.width * 0.8,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: size.height * 0.06,
                                      width: size.width * 0.25,
                                      decoration: BoxDecoration(
                                        color:
                                            const Color.fromRGBO(255, 183, 3, 1),
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
                                          shape: MaterialStateProperty.all<
                                              OutlinedBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                        color:
                                            const Color.fromRGBO(255, 183, 3, 1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            const Color.fromRGBO(255, 183, 3, 1),
                                          ),
                                          shape: MaterialStateProperty.all<
                                              OutlinedBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                color: const Color.fromRGBO(99, 99, 99, 1),
                              ),
                              SizedBox(height: 15),
                              Expanded(
                                child: Column(
                                  children: [
                                    for (int i = 0;
                                        i < 8;
                                        i++) // จำนวน Cardcomment ที่ต้องการแสดง
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                10), // เพิ่มระยะห่าง 10 หน่วยด้านบนและด้านล่างของ Cardcomment
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
            ),
            RestroomAppBar(scaffoldKey: _scaffoldKey),
          ],
        ),
        drawerScrimColor: Colors.transparent,
        drawer: RestroomRoverNavbar(),
      ),
    );
  }
}

class RestroomAppBar extends StatelessWidget {
  const RestroomAppBar({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFFFFB330),
            Color(0xFFFFE9A6),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              GestureDetector(
                child: Icon(
                  Icons.menu_rounded,
                  size: Theme.of(context).appBarTheme.iconTheme!.size,
                  color: Theme.of(context).appBarTheme.iconTheme!.color,
                ),
                onTap: () {
                  debugPrint("Open Drawer");
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              const SizedBox(width: 10),
              Text(
                "Review",
                style: TextStyle(
                  fontSize:
                      Theme.of(context).textTheme.headlineMedium!.fontSize,
                  fontWeight:
                      Theme.of(context).textTheme.headlineMedium!.fontWeight,
                  color: Theme.of(context).textTheme.headlineMedium!.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
