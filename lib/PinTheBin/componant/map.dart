import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:latlong2/latlong.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:ruam_mitt/Restroom/Component/cardpin.dart';
import 'package:ruam_mitt/global_const.dart';
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
      this.centerMark,
      required this.mapController});
  final MapController mapController;
  final dynamic binInfo;
  final LatLng? centerMark;

  @override
  State<MapPinTheBin> createState() => _MapPinTheBinState();
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
      markerInfo.markers.add(Marker(
        point: LatLng(widget.binInfo[index]['latitude'],
            widget.binInfo[index]['longitude']),
        width: 50,
        height: 50,
        child: Image.asset("assets/images/RestroomRover/Pinred.png"), //รูปหมุด
      ));
      markerInfo.info.add(widget.binInfo[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        FlutterMap(
          mapController: widget.mapController,
          options: MapOptions(
            initialCenter: widget.centerMark ??
                LatLng(
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
                widget.binInfo.length,
                (index) => Marker(
                  point: LatLng(widget.binInfo[index]['latitude'],
                      widget.binInfo[index]['longitude']),
                  width: 50,
                  height: 50,
                  child: GestureDetector(
                    child:
                        Image.asset("assets/images/RestroomRover/Pinred.png"),
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
                  return Container(
                    width: size.width * 0.5,
                    height: size.height * 0.25,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                        children: [Text("${displayBinInfo['location']}")]),
                  );
                }),
              ),
            ),
          ],
        ),
        SlidingBox(
          draggableIcon: Icons.keyboard_arrow_down_sharp,
          draggableIconBackColor: Colors.transparent,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Colors.black.withOpacity(0.8),
          collapsed: true,
          controller: binInfoController,
          maxHeight: size.height * 0.8,
          minHeight: 0,
          animationCurve: Curves.easeInOutQuart,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: size.height * 0.03,
                      bottom: size.height * 0.03,
                    ),
                    width: size.width * 0.7,
                    height: size.height * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: widget.binInfo[selectedIndex]['picture'] == null
                        ? Image.asset(
                            "assets/images/PinTheBin/bin_null.png",
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            widget.binInfo[selectedIndex]['picture']),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.more_horiz,
                            color: Colors.white, size: 40, key: popKey)
                      ],
                    ),
                  ),
                  onTap: () {
                    PopupMenu popupMenu = PopupMenu(
                      onClickMenu: onPopupClick,
                      context: context,
                      items: [
                        MenuItem(
                          title: 'Edit',
                          image: Icon(Icons.edit, color: Colors.white),
                        ),
                        MenuItem(
                          title: 'Navigate',
                          image: Icon(Icons.location_on_outlined,
                              color: Colors.white),
                        ),
                      ],
                    );
                    popupMenu.show(widgetKey: popKey);
                  },
                ),
                const Text(
                  "Location",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextField(
                    maxLines: null,
                    controller: locationTextController,
                    enabled: false,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.9),
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const Text(
                  "Description",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextField(
                    maxLines: null,
                    controller: descriptionTextController,
                    enabled: false,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.9),
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
