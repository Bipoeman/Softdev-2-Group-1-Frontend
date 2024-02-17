import "dart:convert";
import "dart:math";

import "package:flutter/material.dart";
import 'package:latlong2/latlong.dart';
import "package:ruam_mitt/PinTheBin/componant/search.dart";
import "package:ruam_mitt/PinTheBin/navbar.dart";
import "package:ruam_mitt/PinTheBin/componant/map.dart";
import "package:http/http.dart" as http;
import "package:ruam_mitt/global_const.dart";

class BinPage extends StatefulWidget {
  const BinPage({super.key});

  @override
  State<BinPage> createState() => _BinPageState();
}

class _BinPageState extends State<BinPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic binData = {};
  Future<http.Response> getBinInfo() async {
    print("Getting");
    Uri url = Uri.parse("$api$pinTheBinGetBinRoute");
    http.Response res = await http.get(url, headers: {"Authorization": ""});
    print(res.body);
    return res;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Init Bin Page");
    getBinInfo().then((response) {
      // print("Response");
      // print(response.body);
      setState(() {
        binData = jsonDecode(response.body);
      });
      // print(binData);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: binData.isEmpty
              ? [
                  const Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text("Bin map loading...")
                    ],
                  ))
                ]
              : [
                  MapPinTheBin(
                    // binPos: [
                    //   LatLng(13.825605, 100.514476),
                    //   LatLng(13.826, 100.514476),
                    // ],
                    binPos: List.generate(binData.length, (index) {
                      print(
                          "${binData[index]["latitude"]},${binData[index]["latitude"]}");
                      return LatLng(binData[index]["latitude"],
                          binData[index]["longitude"]);
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        width: [300.0, size.width * 0.65].reduce(min),
                        child: const SearchBin(),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF77F00),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(Icons.menu),
                        ),
                      ),
                    ),
                  ),
                ],
        ),
      ),
      drawerScrimColor: Colors.transparent,
      drawer: const NavBar(),
    );
  }
}
