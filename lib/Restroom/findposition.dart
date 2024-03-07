import "package:flutter/material.dart";
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart";
import "package:ruam_mitt/Restroom/Component/font.dart";
import "package:ruam_mitt/Restroom/Component/loading_screen.dart";
import 'package:ruam_mitt/Restroom/Component/map.dart';
import "package:http/http.dart" as http;
import "package:ruam_mitt/Restroom/restroom.dart";
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
  List<Marker> markers = [];
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

  Future<http.Response> getRestroomReview() async {
    debugPrint("Getting Review");
    Uri url = Uri.parse("$api$restroomRoverReviewRoute");
    http.Response res = await http.get(
      url,
      headers: {
        "Authorization": publicToken,
      },
    );
    if (res.statusCode != 200) {
      return Future.error(
          res.reasonPhrase ?? "Failed to get review information.");
    }
    return res;
  }

  @override
  void initState() {
    debugPrint("Init Restroom Page");
    showRestroomLoadingScreen(context);
    Future.wait([getRestroomInfo(), getRestroomReview()])
        .timeout(const Duration(seconds: 10))
        .then((res) {
      var decoded = res
          .map<List<dynamic>>((response) => jsonDecode(response.body))
          .toList();

      // Combine datas
      setState(() {
        restroomData = decoded[0].map((info) {
          var founded = decoded[1].singleWhere(
              (review) => review["id"] == info["id"],
              orElse: () => null);
          if (founded != null) {
            info.addEntries(founded.entries);
          }
          return info;
        }).toList();
        markers = restroomData.map((restroom) {
          return Marker(
            point: LatLng(
              restroom["latitude"].toDouble(),
              restroom["longitude"].toDouble(),
            ),
            width: 50,
            height: 50,
            rotate: true,
            child: RestroomMarker(restroomData: restroom),
          );
        }).toList();
      });
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      ThemeData theme = Theme.of(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Failed to fetch data",
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
          ),
        ),
        backgroundColor: theme.colorScheme.primary,
      ));
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
          backgroundColor: const Color(0xFFE6E6E6),
          child: Text(
            "Confirm Location",
            style: text_input("", context),
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
