import "package:flutter/material.dart";
import 'package:flutter_map/flutter_map.dart';
import 'package:ruam_mitt/Restroom/Component/map.dart';
import "package:http/http.dart" as http;
import "package:ruam_mitt/global_const.dart";
import "package:ruam_mitt/global_var.dart";
import "dart:convert";

class RestroomRoverFindPosition extends StatefulWidget {
  const RestroomRoverFindPosition({
    super.key,
  });

  @override
  State<RestroomRoverFindPosition> createState() =>
      _RestroomRoverFindPositionState();
}

class _RestroomRoverFindPositionState extends State<RestroomRoverFindPosition> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MapController editMapController = MapController();
  List<dynamic> restroomData = [];
  Future<http.Response> getRestroomInfo() async {
    debugPrint("Getting");
    Uri url = Uri.parse("$api$restroomRoverRestroomRoute");
    http.Response res = await http.get(
      url,
      headers: {
        "Authorization": publicToken,
      },
    );
    debugPrint(res.body);
    return res;
  }

  @override
  void initState() {
    debugPrint("Init Restroom Page");
    getRestroomInfo().then((response) {
      restroomData = jsonDecode(response.body);
      Future.delayed(const Duration(milliseconds: 500))
          .then((value) => setState(() {}));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(
          bottom: size.height * 0.15,
          // left: size.width* 0.2 ,
        ), // ขยับปุ่มขึ้นจากด้านล่าง 25%
        width: size.width * 0.45,
        height: size.height * 0.06,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black), // เพิ่มเส้นขอบสีดำ
          borderRadius:
              BorderRadius.circular(13), // กำหนดรูปร่างของปุ่มเป็นวงกลม
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context, editMapController.camera.center);
          },
          backgroundColor: Color(0xFFE6E6E6),
          child: Text(
            "Confirm Location",
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF000000),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          MapRestroomRover(
              restroomData: restroomData, mapController: editMapController),
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
