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
      {super.key,
      required this.binInfo,
      required this.mapController,
      this.markers,
      this.popupController});
  final MapController mapController;
  final dynamic binInfo;
  final List<Marker>? markers;
  final PopupController? popupController;
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
    List.generate(widget.binInfo.length, (index) {
      double lattitude = widget.binInfo[index]['latitude'].toDouble();
      double longtitude = widget.binInfo[index]['longitude'].toDouble();
      // print("$lattitude $longtitude ${(lattitude > 90 || lattitude < -90)}");

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
                popupController: widget.popupController,
                markers: widget.markers ?? markerInfo.markers,
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
                                                child: InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Stack(
                                                            children: [
                                                              Center(
                                                                  child:
                                                                      SizedBox(
                                                                width:
                                                                    size.width,
                                                                height:
                                                                    size.height,
                                                                child:
                                                                    InteractiveViewer(
                                                                  maxScale: 10,
                                                                  child: displayBinInfo[
                                                                              'picture'] ==
                                                                          null
                                                                      ? Image
                                                                          .asset(
                                                                          "assets/images/PinTheBin/bin_null.png",
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        )
                                                                      : Image
                                                                          .network(
                                                                          displayBinInfo[
                                                                              'picture'],
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
                                                                    Icons.close,
                                                                    size: 30,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
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
                                                              fit: BoxFit.cover,
                                                            ),
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                            SizedBox(width: size.width * 0.025),
                                            ClayContainer(
                                              width: size.width * 0.1,
                                              height: size.height * 0.053,

                                              color: const Color.fromARGB(255,
                                                  255, 255, 255), //0xFFE1CFCF
                                              surfaceColor:
                                                  const Color(0xFFE1CFCF),
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
      ],
    );
  }
}
