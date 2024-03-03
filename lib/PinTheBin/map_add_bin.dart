import 'dart:convert';

import "package:flutter/material.dart";
import 'package:flutter_map/flutter_map.dart';
import "package:http/http.dart" as http;
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:ruam_mitt/global_func.dart';
import 'package:url_launcher/url_launcher.dart';

import '../global_const.dart';
import '../global_var.dart';

class BinLocationInfo {
  BinLocationInfo({required this.info, required this.markers});
  late List<Marker> markers;
  late List<Map<String, dynamic>> info;
}

class MapaddBinPage extends StatefulWidget {
  const MapaddBinPage({
    super.key,
  });

  @override
  State<MapaddBinPage> createState() => _MapaddBinPageState();
}

class _MapaddBinPageState extends State<MapaddBinPage> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MapController editMapController = MapController();
  BinLocationInfo markerInfo = BinLocationInfo(info: [], markers: []);

  List<dynamic> binData = [];

  Future<http.Response> getBinInfo() async {
    debugPrint("Getting");
    Uri url = Uri.parse("$api$pinTheBinGetBinRoute");
    http.Response res = await http.get(
      url,
      headers: {
        "Authorization": publicToken,
      },
    );
    print("res : ${res.statusCode}");
    if (res.statusCode == 403) {
      if (context.mounted) {
        await requestNewToken(context);
        return await getBinInfo();
      }
    }
    debugPrint(res.body);
    return res;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("Init Bin Page");
    getBinInfo().then((response) {
      // debugPrint("Response");
      // debugPrint(response.body);
      binData = jsonDecode(response.body);
      List.generate(
        binData.length,
        (index) {
          // print(index);
          double lattitude = binData[index]['latitude'].toDouble();
          double longtitude = binData[index]['longitude'].toDouble();
          // print(
          //     "$lattitude $longtitude ${(lattitude > 90 || lattitude < -90)}");
          if ((lattitude < 90 && lattitude > -90) &&
              (longtitude < 180 && longtitude > -180)) {
            markerInfo.info.add(binData[index]);
            markerInfo.markers.add(
              Marker(
                point: LatLng(lattitude, longtitude),
                width: 30,
                height: 30,
                rotate: true,
                child: Image.asset(
                  "assets/images/PinTheBin/pin.png",
                ),
              ),
            );
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          width: size.width * 0.25,
          height: size.height * 0.05,
          decoration: BoxDecoration(
              color: Color(0xFFF9957F),
              borderRadius: BorderRadius.circular(30)),
          child: Text(
            "Confirm",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        onTap: () {
          Navigator.pop(context, editMapController.camera.center);
        },
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: editMapController,
            options: const MapOptions(
              initialCenter: LatLng(13.825605, 100.514476),
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
                    ),
                  ),
                ),
              ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () => launchUrl(Uri.parse('')),
                  ),
                ],
              ),
            ],
          ),
          const Center(
            child: Icon(
              Icons.location_on,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
