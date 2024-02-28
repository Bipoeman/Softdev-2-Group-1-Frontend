import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ruam_mitt/Restroom/Component/NavBar.dart';
import 'package:ruam_mitt/Restroom/Component/write_review.dart';
import 'package:ruam_mitt/Restroom/Component/comment.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'dart:math';

class RestroomRoverReport extends StatefulWidget {
  const RestroomRoverReport({super.key});

  @override
  State<RestroomRoverReport> createState() => _RestroomRoverReportState();
}

class _RestroomRoverReportState extends State<RestroomRoverReport> {
  BoxController boxController = BoxController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _LocationstextController = TextEditingController();
  TextEditingController _DescriptiontextController = TextEditingController();
  TextEditingController _TopictextController = TextEditingController();

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
              color: const Color(0xFF050505).withOpacity(0.69),
            ),
            displayLarge: TextStyle(
              fontSize: 17,
              overflow: TextOverflow.fade,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF050505),
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
        child: Builder(builder: (context) {
          return Scaffold(
            key: _scaffoldKey,
            body: Column(
              children: [
                RestroomAppBar(
                    scaffoldKey: _scaffoldKey), // วาง AppBar ไว้ด้านบน
                Expanded(
                  // ใช้ Expanded เพื่อให้ Row และเนื้อหาด้านล่างมีพื้นที่เท่ากัน
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              padding: EdgeInsets.only(left: 40),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Text(
                                  'Topic',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.only(top: size.height * 0.05),
                            child: ClayContainer(
                              width: size.width * 0.6,
                              height: size.height * 0.032,
                              color: Color.fromRGBO(239, 239, 239, 1),
                              borderRadius: 30,
                              depth: -20,
                              child: TextField(
                                controller: _TopictextController,
                                onChanged: (text) {
                                  print('Typed text: $text');
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric( vertical: 10.0)
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                      SizedBox(
                          height:
                              30), // เพิ่มระยะห่างระหว่าง Row กับเนื้อหาด้านล่าง
                      // เพิ่มเนื้อหาด้านล่างของ Row ที่นี่
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Container(
                              padding: EdgeInsets.only(left: 40),
                              child: Text(
                                'Description',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: size.height * 0.02),
                            child: ClayContainer(
                              width: size.width * 0.78,
                              height: size.height * 0.3,
                              color: Color.fromRGBO(239, 239, 239, 1),
                              borderRadius: 30,
                              depth: -20,
                              child: TextField(
                                controller: _DescriptiontextController,
                                onChanged: (text) {
                                  print('Typed text: $text');
                                },
                                maxLines: null,
                                // textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0)
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                          height:
                              size.height * 0.25), // เพิ่มระยะห่างระหว่าง Row กับเนื้อหาด้านล่าง
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.amber,
                              surfaceTintColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                                side: const BorderSide(color: Colors.grey),
                              ),
                            ),
                            child: Text(
                              'Submit',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.grey[300],
                              surfaceTintColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                                side: const BorderSide(color: Colors.grey),
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            drawerScrimColor: Colors.transparent,
            drawer: RestroomRoverNavbar(),
          );
        }));
  }
}

class _NametextController {}

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
                "Report",
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
// import 'package:clay_containers/widgets/clay_container.dart';
// import "package:flutter/material.dart" hide BoxDecoration, BoxShadow;
// import 'package:ruam_mitt/PinTheBin/pin_the_bin_theme.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ruam_mitt/PinTheBin/bin_drawer.dart';
// import 'package:neumorphic_button/neumorphic_button.dart';
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:ruam_mitt/PinTheBin/map_add_bin.dart';
// import 'package:ruam_mitt/Restroom/Component/NavBar.dart';

// class RestroomRoverReport extends StatefulWidget {
//   const RestroomRoverReport({super.key});

//   @override
//   State<RestroomRoverReport> createState() => _RestroomRoverReportState();
// }

// class _RestroomRoverReportState extends State<RestroomRoverReport> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   TextEditingController _NametextController = TextEditingController();
//   final backgroundColor = const Color(0xFFFFFFFF);
//   bool isPressed = true;

//   LatLng? _position;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     print("init");
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     Offset distance = isPressed
//         ? Offset(5, 5)
//         : Offset(size.width * 0.008, size.height * 0.005);
//     double blur = isPressed ? 5.0 : 5;

//     return Theme(
//       data: ThemeData(
//         fontFamily: "Sen",
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color(0xFFFFB330),
//           background: const Color(0xFFECECEC),
//         ),
//         textTheme: TextTheme(
//           headlineMedium: const TextStyle(
//             fontSize: 35,
//             fontWeight: FontWeight.w800,
//             color: Color.fromARGB(255, 112, 110, 110),
//           ),
//           headlineSmall: TextStyle(
//             fontSize: 30,
//             overflow: TextOverflow.fade,
//             fontWeight: FontWeight.w800,
//             color: const Color(0xFF003049),
//             shadows: [
//               Shadow(
//                 blurRadius: 20,
//                 offset: const Offset(0, 3),
//                 color: const Color(0xFF003049).withOpacity(0.3),
//               ),
//             ],
//           ),
//           displayMedium: TextStyle(
//             fontSize: 20,
//             overflow: TextOverflow.fade,
//             fontWeight: FontWeight.normal,
//             color: const Color(0xFF003049).withOpacity(0.69),
//           ),
//         ),
//         appBarTheme: const AppBarTheme(
//           iconTheme: IconThemeData(
//             color: Colors.white,
//             size: 35,
//           ),
//         ),
//         drawerTheme: const DrawerThemeData(
//           scrimColor: Colors.transparent,
//           backgroundColor: Color(0xFFFFFFFF),
//         ),
//         searchBarTheme: SearchBarThemeData(
//           textStyle: MaterialStatePropertyAll(
//             TextStyle(
//               fontFamily: GoogleFonts.getFont("Inter").fontFamily,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//       child: Builder(
//         builder: (context) {
//           return Stack(
//             children: [
//               Scaffold(
//                 key: _scaffoldKey,
//                 drawerScrimColor: Colors.transparent,
//                 drawer: RestroomRoverNavbar(),
//                 body: SafeArea(
//                     child: Stack(
//                   children: [
//                     SizedBox(
//                           height: 200,
//                         ),
//                     Row(
//                       children: [
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Container(
//                             padding: EdgeInsets.only(left: 20),
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 25),
//                               child: Text(
//                                 'Name',
//                                 style:
//                                     Theme.of(context).textTheme.displayMedium,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: size.width * 0.05,
//                         ),
//                         Container(
//                           alignment: Alignment.topRight,
//                           margin: EdgeInsets.only(top: size.height * 0.035),
//                           child: ClayContainer(
//                             width: size.width * 0.65,
//                             height: size.height * 0.032,
//                             color: Color.fromRGBO(239, 239, 239, 1),
//                             borderRadius: 30,
//                             depth: -20,
//                             child: TextField(
//                               controller: _NametextController,
//                               onChanged: (text) {
//                                 print('Typed text: $text');
//                               },
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Container(
//                             padding: EdgeInsets.only(left: 20),
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 76),
//                               child: Text(
//                                 'Position',
//                                 style:
//                                     Theme.of(context).textTheme.displayMedium,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: size.height * 0.02),
//                         Row(
//                           children: [
//                             GestureDetector(
//                               onTap: () async {
//                                 setState(() => isPressed = !isPressed);
//                                 LatLng getPosResult = await Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const MapaddBinPage()),
//                                 );
//                                 print("Result $getPosResult");
//                                 setState(() {
//                                   _position = getPosResult;
//                                 });
//                               },
//                               child: AnimatedContainer(
//                                 duration: const Duration(milliseconds: 100),
//                                 alignment: Alignment.center,
//                                 margin: EdgeInsets.only(left: 30),
//                                 width: size.width * 0.165,
//                                 height: size.height * 0.038,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(30),
//                                   color: Color.fromARGB(255, 255, 255, 255),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       blurRadius: blur,
//                                       offset: distance,
//                                       color: Color(0xFFA7A9AF),
//                                       inset: isPressed,
//                                     ),
//                                     BoxShadow(
//                                       blurRadius: blur,
//                                       offset: -distance,
//                                       color: Color.fromARGB(255, 255, 255, 255),
//                                       inset: isPressed,
//                                     ),
//                                   ],
//                                 ),
//                                 child: Text(
//                                   'select',
//                                   style:
//                                       Theme.of(context).textTheme.displayMedium,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: size.width * 0.05,
//                             ),
//                             Column(
//                               children: [
//                                 ClayContainer(
//                                   width: size.width * 0.6,
//                                   height: size.height * 0.032,
//                                   color: Color.fromRGBO(239, 239, 239, 1),
//                                   borderRadius: 30,
//                                   depth: -20,
//                                   child: Text(
//                                     'Lat: ${_position?.latitude ?? ()}',
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: size.height * 0.02,
//                                 ),
//                                 ClayContainer(
//                                   width: size.width * 0.6,
//                                   height: size.height * 0.032,
//                                   color: Color.fromRGBO(239, 239, 239, 1),
//                                   borderRadius: 30,
//                                   depth: -20,
//                                   child: Text(
//                                     'Lng: ${_position?.longitude ?? ()}',
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(top: size.height * 0.265),
//                       child: Container(
//                         alignment: Alignment.center,
//                         margin: EdgeInsets.only(left: 30),
//                         width: size.width * 0.84,
//                         height: size.height * 0.1,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.bottomCenter,
//                             end: Alignment.topCenter,
//                             colors: [
//                               Color(0xFF292643).withOpacity(0.46),
//                               Color(0xFFF9A58D).withOpacity(0.72),
//                             ],
//                           ),
//                         ),
//                         child: Stack(
//                           children: [
//                             Container(
//                               padding:
//                                   EdgeInsets.only(right: size.width * 0.77),
//                               child: Container(
//                                 margin:
//                                     EdgeInsets.only(bottom: size.height * 0.05),
//                                 alignment: Alignment.topLeft,
//                                 child: Opacity(
//                                   opacity: 0.5,
//                                   child: Image.asset(
//                                       "assets/images/PinTheBin/corner.png"),
//                                 ),
//                                 width: size.width * 0.035,
//                                 height: size.height * 0.035,
//                               ),
//                             ),
//                             Container(
//                               padding: EdgeInsets.only(left: size.width * 0.77),
//                               child: Container(
//                                 margin:
//                                     EdgeInsets.only(bottom: size.height * 0.05),
//                                 alignment: Alignment.topLeft,
//                                 child: Transform.rotate(
//                                   angle: 90 * 3.141592653589793 / 180,
//                                   child: Opacity(
//                                     opacity: 0.5,
//                                     child: Image.asset(
//                                         "assets/images/PinTheBin/corner.png"),
//                                   ),
//                                 ),
//                                 width: size.width * 0.035,
//                                 height: size.height * 0.035,
//                               ),
//                             ),
//                             Container(
//                               padding: EdgeInsets.only(
//                                   right: size.width * 0.77,
//                                   top: size.height * 0.05),

//                               child: Container(
//                                 alignment: Alignment.bottomLeft,
//                                 child: Transform.rotate(
//                                   angle: 270 * 3.141592653589793 / 180,
//                                   child: Opacity(
//                                     opacity: 0.5,
//                                     child: Image.asset(
//                                         "assets/images/PinTheBin/corner.png"),
//                                   ),
//                                 ),
//                                 width: size.width * 0.035,
//                                 height: size.height * 0.035,
//                                 // decoration: BoxDecoration(
//                                 //     border: Border.all(
//                                 //         color: Colors.black, width: 10)),
//                               ),
//                               //),
//                             ),
//                             Container(
//                               padding: EdgeInsets.only(left: size.width * 0.77),
//                               child: Container(
//                                 margin:
//                                     EdgeInsets.only(top: size.height * 0.05),
//                                 alignment: Alignment.bottomLeft,
//                                 child: Transform.rotate(
//                                   angle: 180 * 3.141592653589793 / 180,
//                                   child: Opacity(
//                                     opacity: 0.5,
//                                     child: Image.asset(
//                                         "assets/images/PinTheBin/corner.png"),
//                                   ),
//                                 ),
//                                 width: size.width * 0.035,
//                                 height: size.height * 0.035,
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(
//                                   top: size.height * 0.055,
//                                   left: size.width * 0.23),
//                               child: Opacity(
//                                 opacity: 0.4,
//                                 child: Text(
//                                   "Upload picture",
//                                   style:
//                                       Theme.of(context).textTheme.displayMedium,
//                                 ),
//                               ),
//                             )
//                             // itemSelection(title: 'upload', image: Image.asset("assets/images/PinTheBin/upload.png"), onTap: , context: context)
//                           ],
//                         ),
//                       ),
//                     ),
//                     Column(),
//                     // RestroomAppBar(scaffoldKey: _scaffoldKey),
//                   ],
                  
//                 )),
                
//               )
              
//             ],
            
//           );
//         },
//       ),
//     );
//   }
// }
// class RestroomAppBar extends StatelessWidget {
//   const RestroomAppBar({
//     super.key,
//     required GlobalKey<ScaffoldState> scaffoldKey,
//   }) : _scaffoldKey = scaffoldKey;

//   final GlobalKey<ScaffoldState> _scaffoldKey;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 130,
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: <Color>[
//             Color(0xFFFFB330),
//             Color(0xFFFFE9A6),
//           ],
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             children: [
//               const SizedBox(width: 20),
//               GestureDetector(
//                 child: Icon(
//                   Icons.menu_rounded,
//                   size: Theme.of(context).appBarTheme.iconTheme!.size,
//                   color: Theme.of(context).appBarTheme.iconTheme!.color,
//                 ),
//                 onTap: () {
//                   debugPrint("Open Drawer");
//                   _scaffoldKey.currentState?.openDrawer();
//                 },
//               ),
//               const SizedBox(width: 10),
//               Text(
//                 "Report",
//                 style: TextStyle(
//                   fontSize:
//                       Theme.of(context).textTheme.headlineMedium!.fontSize,
//                   fontWeight:
//                       Theme.of(context).textTheme.headlineMedium!.fontWeight,
//                   color: Theme.of(context).textTheme.headlineMedium!.color,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10)
//         ],
//       ),
//     );
//   }
// }r