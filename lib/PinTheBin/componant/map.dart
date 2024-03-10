import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:latlong2/latlong.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:url_launcher/url_launcher.dart';

class BinLocationInfo {
  BinLocationInfo({required this.info, required this.markers});
  late List<Marker> markers;
  late List<Map<String, dynamic>> info;
}

class MapPinTheBin extends StatefulWidget {
  const MapPinTheBin(
      {super.key, required this.binInfo, required this.mapController});
  final MapController mapController;
  final dynamic binInfo;

  @override
  State<MapPinTheBin> createState() => _MapPinTheBinState();
}

Widget _showEdit(context, bin, width) {
  if ('${bin['user_update']}' == '${profileData['id']}' ||
      profileData['role'] == "admin") {
    print("show");
    return InkWell(
      child: Image.asset(
        "assets/images/PinTheBin/edit_bin_black_white.png",
        height: width * 0.06,
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          pinthebinPageRoute["editbin"]!,
          arguments: {'Bininfo': bin},
        );
      },
    );
  } else {
    return SizedBox(
      height: width * 0.06,
      width: width * 0.06,
    );
  }
}

class _MapPinTheBinState extends State<MapPinTheBin>
    with SingleTickerProviderStateMixin {
  BoxController binInfoController = BoxController();
  TextEditingController locationTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  GlobalKey popKey = GlobalKey();
  int selectedIndex = 0;
  // List<Marker> markers = [];
  BinLocationInfo markerInfo = BinLocationInfo(info: [], markers: []);
  void onPopupClick(MenuItemProvider item) async {
    if (item.menuTitle == "Edit") {
      Navigator.pushNamed(
        context,
        pinthebinPageRoute["editbin"]!,
        arguments: {'Bininfo': widget.binInfo[selectedIndex]},
      );
    } else if (item.menuTitle == "Navigate") {
      print(widget.binInfo[selectedIndex]);
      String googleUrl =
          'https://www.google.com/maps/search/?api=1&query=${widget.binInfo[selectedIndex]['latitude']},${widget.binInfo[selectedIndex]['longitude']}';
      Uri url = Uri.parse(googleUrl);
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $googleUrl');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // markers = List.generate(
    //   widget.binInfo.length,
    //   (index) => Marker(
    //     point: LatLng(widget.binInfo[index]['latitude'],
    //         widget.binInfo[index]['longitude']),
    //     width: 50,
    //     height: 50,
    //     child: Image.asset("assets/images/RestroomRover/Pinred.png"), //รูปหมุด
    //   ),
    // );
    List.generate(widget.binInfo.length, (index) {
      double lattitude = widget.binInfo[index]['latitude'].toDouble();
      double longtitude = widget.binInfo[index]['longitude'].toDouble();
      print("$lattitude $longtitude ${(lattitude > 90 || lattitude < -90)}");
      if ((lattitude < 90 && lattitude > -90) &&
          (longtitude < 180 && longtitude > -180)) {
        markerInfo.markers.add(
          Marker(
            point: LatLng(lattitude, longtitude),
            width: 30,
            height: 30,
            rotate: true,
            child: Image.asset(
              "assets/images/PinTheBin/pin.png",
            ), //รูปหมุด
          ),
        );
        markerInfo.info.add(widget.binInfo[index]);
      }
    });
    print("Array Len : ${markerInfo.info.length}");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        FlutterMap(
          mapController: widget.mapController,
          options: MapOptions(
            initialCenter: LatLng(
              widget.binInfo[0]['latitude'],
              widget.binInfo[0]['longitude'],
            ),
            initialZoom: 15,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: List.generate(
                markerInfo.info.length,
                (index) => Marker(
                  point: markerInfo.markers[index].point,
                  width: 30,
                  height: 30,
                  rotate: true,
                  child: GestureDetector(
                    child: Image.asset(
                      "assets/images/PinTheBin/pin.png",
                    ),
                    onTap: () {
                      print("position $index : ${widget.binInfo[index]}");
                      binInfoController.openBox();
                      setState(() {
                        locationTextController.text =
                            widget.binInfo[index]['location'] ?? "Not provided";

                        // widget.binInfo[index]['location'];
                        descriptionTextController.text = widget.binInfo[index]
                                ['description'] ??
                            "Not provided";
                        selectedIndex = index;
                      });
                    },
                  ), //รูปหมุด
                ),
              ),
              // [
              //   Marker(
              //     point: const LatLng(13.825605, 100.514476),
              //     width: 50,
              //     height: 50,
              //      Image.asset(
              //         "assets/images/RestroomRover/Pinred.png"), //รูปหมุด
              //   ),
              //   Marker(
              //     point: const LatLng(13.826000, 100.514476),
              //     width: 50,
              //     height: 50,
              //     child: Image.asset(
              //         "assets/images/RestroomRover/Pinred.png"), //รูปหมุด
              //   ),
              // ],
            ),
            RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  'OpenStreetMap contributors',
                  onTap: () => launchUrl(
                      Uri.parse('https://openstreetmap.org/copyright')),
                ),
              ],
            ),
            CurrentLocationLayer(
              // followOnLocationUpdate: FollowOnLocationUpdate.always,
              // turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
              style: const LocationMarkerStyle(
                marker: DefaultLocationMarker(
                  child: Icon(
                    Icons.navigation,
                    color: Colors.white,
                  ),
                ),
                markerSize: Size(40, 40),
                markerDirection: MarkerDirection.heading,
              ),
            ),
            PopupMarkerLayer(
              options: PopupMarkerLayerOptions(
                markers: markerInfo.markers,
                popupDisplayOptions: PopupDisplayOptions(
                    animation: const PopupAnimation.fade(
                        duration: Duration(milliseconds: 150)),
                    builder: (BuildContext context, Marker marker) {
                      Map<String, dynamic> displayBinInfo = {};
                      for (int i = 0; i < markerInfo.markers.length; i++) {
                        if (markerInfo.markers[i].point.latitude ==
                                marker.point.latitude &&
                            markerInfo.markers[i].point.longitude ==
                                marker.point.longitude) {
                          displayBinInfo = markerInfo.info[i];
                          break;
                        }
                      }
                      // print(displayBinInfo['bintype']);
                      return AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        width: size.width * 0.65,
                        /*  (404 / 439) are from refrence design */
                        height: (size.width * 0.6) / (404 / 439),
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.07,
                          vertical: size.width * 0.05,
                        ),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: ShaderMask(
                          shaderCallback: (Rect rect) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.white],
                              //set stops as par your requirement
                              stops: [0.0, 0.05], // 50% transparent, 50% white
                            ).createShader(rect);
                          },
                          child: ShaderMask(
                            shaderCallback: (Rect rect) {
                              return const LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.transparent, Colors.white],
                                //set stops as par your requirement
                                stops: [
                                  0.0,
                                  0.05
                                ], // 50% transparent, 50% white
                              ).createShader(rect);
                            },
                            child: SingleChildScrollView(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.46,
                                            top: size.height * 0.013),
                                        child: _showEdit(context,
                                            displayBinInfo, size.width),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: size.height * 0.04),
                                          child: SizedBox(
                                            width: size.width * 0.4,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: AspectRatio(
                                                aspectRatio: 289 / 211,
                                                child:
                                                    // displayBinInfo['picture'] == null
                                                    //     ? Image.asset(
                                                    //         "assets/images/PinTheBin/bin_null.png",
                                                    //         fit: BoxFit.contain,
                                                    //       )
                                                    //     : Image.network(
                                                    //         displayBinInfo['picture'],
                                                    //         fit: BoxFit.cover,
                                                    //       ),
                                                    InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Stack(
                                                                children: [
                                                                  Center(
                                                                      child:
                                                                          SizedBox(
                                                                    width: size
                                                                        .width,
                                                                    height: size
                                                                        .height,
                                                                    child:
                                                                        InteractiveViewer(
                                                                      maxScale:
                                                                          10,
                                                                      child: displayBinInfo['picture'] ==
                                                                              null
                                                                          ? Image
                                                                              .asset(
                                                                              "assets/images/PinTheBin/bin_null.png",
                                                                              fit: BoxFit.contain,
                                                                            )
                                                                          : Image
                                                                              .network(
                                                                              displayBinInfo['picture'],
                                                                            ),
                                                                    ),
                                                                  )),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child:
                                                                        IconButton(
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .close,
                                                                        size:
                                                                            30,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: ClipRRect(
                                                          child: displayBinInfo[
                                                                      'picture'] ==
                                                                  null
                                                              ? Image.asset(
                                                                  "assets/images/PinTheBin/bin_null.png",
                                                                  fit: BoxFit
                                                                      .contain,
                                                                )
                                                              : Image.network(
                                                                  displayBinInfo[
                                                                      'picture'],
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                        )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  //     Row(children: [
                                  //       _showEdit(context, displayBinInfo,
                                  //           size.width),
                                  //       InkWell(
                                  //         child: Image.asset(
                                  //           "assets/images/PinTheBin/navigate_bin.png",
                                  //           height: size.width * 0.06,
                                  //         ),
                                  //         onTap: () async {
                                  //           String googleUrl =
                                  //               'https://www.google.com/maps/search/?api=1&query=${marker.point.latitude},${marker.point.longitude}';
                                  //           Uri url = Uri.parse(googleUrl);
                                  //           if (!await launchUrl(url)) {
                                  //             throw Exception(
                                  //                 'Could not launch $googleUrl');
                                  //           }
                                  //         },
                                  //       ),
                                  //       InkWell(
                                  //         child: Image.asset(
                                  //           "assets/images/PinTheBin/report_bin.png",
                                  //           height: size.width * 0.06,
                                  //         ),
                                  //         onTap: () {
                                  //           Navigator.pushNamed(
                                  //             context,
                                  //             pinthebinPageRoute["report"]!,
                                  //             arguments: {
                                  //               'Bininfo': displayBinInfo
                                  //             },
                                  //           );
                                  //         },
                                  //       ),
                                  //     ]),
                                  //   ],
                                  // ),
                                  SizedBox(height: size.height * 0.013),
                                  SizedBox(
                                    width: size.width * 0.65 * 0.8,
                                    child: Text(
                                      "${displayBinInfo['location']}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          shadows: [
                                            Shadow(
                                              color: const Color(0xFF46384E)
                                                  .withOpacity(0.4),
                                              offset: const Offset(0, 2),
                                              blurRadius: 5,
                                            )
                                          ],
                                          color: const Color(0xFF46384E),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.013),
                                  Row(
                                    children: List.generate(
                                      displayBinInfo['bintype'].keys.length,
                                      (index) {
                                        List<Image> binColors = [
                                          Image.asset(
                                              'assets/images/PinTheBin/warning.png'),
                                          Image.asset(
                                              'assets/images/PinTheBin/recycling.png'),
                                          Image.asset(
                                              'assets/images/PinTheBin/compost.png'),
                                          Image.asset(
                                              'assets/images/PinTheBin/bin.png'),
                                        ];
                                        var keys =
                                            displayBinInfo['bintype'].keys;
                                        print(displayBinInfo['bintype']
                                            [keys.elementAt(index)]);
                                        if (displayBinInfo['bintype']
                                                [keys.elementAt(index)] ==
                                            true) {
                                          return Container(
                                            margin:
                                                const EdgeInsets.only(left: 8),
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              //color: binColors[index],
                                              //shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                          255, 207, 207, 207)
                                                      .withOpacity(0.3),
                                                  offset: const Offset(0, 2),
                                                  blurRadius: 2,
                                                  spreadRadius: 1,
                                                )
                                              ],
                                              // border: Border.all(
                                              //   color: const Color(0xFFECECEC),
                                              //   width: 1.5,
                                              // ),
                                            ),
                                            child: binColors[index],
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.013,
                                  ),
                                  Text(
                                    "${displayBinInfo['description']}",
                                    style: TextStyle(
                                        shadows: [
                                          Shadow(
                                            color: const Color(0xFF46384E)
                                                .withOpacity(0.4),
                                            offset: const Offset(0, 2),
                                            blurRadius: 5,
                                          )
                                        ],
                                        color: const Color(0xFF46384E),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.013,
                                  ),
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.01,
                                            left: size.width * 0.23,
                                            bottom: size.height * 0.025),
                                        child: Row(
                                          children: [
                                            // ClayContainer(
                                            //   width: size.width * 0.1,
                                            //   height: size.height * 0.053,

                                            //   color: Color.fromARGB(255, 255,
                                            //       255, 255), //0xFFE1CFCF
                                            //   surfaceColor: Color(0xFFE1CFCF),
                                            //   borderRadius: 10,
                                            //   depth: 20,
                                            //   curveType: CurveType.convex,
                                            // ),
                                            SizedBox(width: size.width * 0.025),
                                            ClayContainer(
                                              width: size.width * 0.1,
                                              height: size.height * 0.053,

                                              color: Color.fromARGB(255, 255,
                                                  255, 255), //0xFFE1CFCF
                                              surfaceColor: Color(0xFFE1CFCF),
                                              borderRadius: 10,
                                              depth: 20,
                                              curveType: CurveType.convex,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  top: size.height * 0.01,
                                                ),
                                                child: InkWell(
                                                  child: Image.asset(
                                                    "assets/images/PinTheBin/navigate_bin.png",
                                                    height: size.height * 0.1,
                                                    width: size.width * 0.1,
                                                  ),
                                                  onTap: () async {
                                                    String googleUrl =
                                                        'https://www.google.com/maps/search/?api=1&query=${marker.point.latitude},${marker.point.longitude}';
                                                    Uri url =
                                                        Uri.parse(googleUrl);
                                                    if (!await launchUrl(url)) {
                                                      throw Exception(
                                                          'Could not launch $googleUrl');
                                                    }
                                                  },
                                                ),
                                              ),

                                              // child: _showEdit(context,
                                              //     displayBinInfo, size.width),
                                            ),
                                            SizedBox(width: size.width * 0.025),
                                            ClayContainer(
                                              width: size.width * 0.1,
                                              height: size.height * 0.053,

                                              color: Color.fromARGB(255, 255,
                                                  255, 255), //0xFFE1CFCF
                                              surfaceColor: Color(0xFFE1CFCF),
                                              borderRadius: 10,
                                              depth: 20,
                                              curveType: CurveType.convex,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: size.height * 0.01),
                                                child: InkWell(
                                                  child: Image.asset(
                                                    "assets/images/PinTheBin/report_bin.png",
                                                    height: size.width * 0.06,
                                                  ),
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                      context,
                                                      pinthebinPageRoute[
                                                          "report"]!,
                                                      arguments: {
                                                        'Bininfo':
                                                            displayBinInfo
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),

        // SlidingBox(
        //   draggableIcon: Icons.keyboard_arrow_down_sharp,
        //   draggableIconBackColor: Colors.transparent,
        //   borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        //   color: Colors.black.withOpacity(0.8),
        //   collapsed: true,
        //   controller: binInfoController,
        //   maxHeight: size.height * 0.8,
        //   minHeight: 0,
        //   animationCurve: Curves.easeInOutQuart,
        //   body: SingleChildScrollView(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Center(
        //           child: Container(
        //             margin: EdgeInsets.only(
        //               top: size.height * 0.03,
        //               bottom: size.height * 0.03,
        //             ),
        //             width: size.width * 0.7,
        //             height: size.height * 0.4,
        //             decoration: BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.circular(20),
        //             ),
        //             // child: widget.binInfo[selectedIndex]['picture'] == null
        //             //     ? Image.asset(
        //             //         "assets/images/PinTheBin/bin_null.png",
        //             //         fit: BoxFit.cover,
        //             //       )
        //             //     : Image.network(
        //             //         widget.binInfo[selectedIndex]['picture']),
        //           ),
        //         ),
        //         GestureDetector(
        //           child: Container(
        //             padding: const EdgeInsets.only(right: 20),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.end,
        //               children: [
        //                 Icon(Icons.more_horiz,
        //                     color: Colors.white, size: 40, key: popKey)
        //               ],
        //             ),
        //           ),
        //           onTap: () {
        //             PopupMenu popupMenu = PopupMenu(
        //               onClickMenu: onPopupClick,
        //               context: context,
        //               items: [
        //                 MenuItem(
        //                   title: 'Edit',
        //                   image: const Icon(Icons.edit, color: Colors.white),
        //                 ),
        //                 MenuItem(
        //                   title: 'Navigate',
        //                   image: const Icon(
        //                     Icons.location_on_outlined,
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //               ],
        //             );
        //             popupMenu.show(widgetKey: popKey);
        //           },
        //         ),
        //         const Text(
        //           "Location",
        //           textAlign: TextAlign.left,
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 22,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //         Container(
        //           padding:
        //               const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        //           child: TextField(
        //             maxLines: null,
        //             controller: locationTextController,
        //             enabled: false,
        //             style: TextStyle(
        //               color: Colors.black.withOpacity(0.9),
        //             ),
        //             decoration: InputDecoration(
        //               border: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(15),
        //                 borderSide: BorderSide.none,
        //               ),
        //               filled: true,
        //               fillColor: Colors.white,
        //             ),
        //           ),
        //         ),
        //         const Text(
        //           "Description",
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 22,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //         Container(
        //           padding:
        //               const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        //           child: TextField(
        //             maxLines: null,
        //             controller: descriptionTextController,
        //             enabled: false,
        //             style: TextStyle(
        //               color: Colors.black.withOpacity(0.9),
        //             ),
        //             decoration: InputDecoration(
        //               border: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(15),
        //                 borderSide: BorderSide.none,
        //               ),
        //               filled: true,
        //               fillColor: Colors.white,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // )
      ],
    );
  }
}
