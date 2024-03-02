import "dart:io";

import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:ruam_mitt/PinTheBin/bin_drawer.dart";
import "package:ruam_mitt/PinTheBin/pin_the_bin_theme.dart";
import 'package:clay_containers/widgets/clay_container.dart';
import "package:ruam_mitt/Restroom/Component/navbar.dart";
import "package:ruam_mitt/Restroom/Component/theme.dart";
import "package:ruam_mitt/global_const.dart";

class RestroomRoverReportPin extends StatefulWidget {
  const RestroomRoverReportPin({super.key, required this.restroomData});
  final Map<String, dynamic> restroomData;
  @override
  State<RestroomRoverReportPin> createState() => _RestroomRoverReportPinState();
}

class _RestroomRoverReportPinState extends State<RestroomRoverReportPin> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _ReporttextController = TextEditingController();
  int remainingCharacters = 0;
  File? _image;
  @override
  Widget build(BuildContext context) {
    final data = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    Size size = MediaQuery.of(context).size;

   
  void updateRemainingCharacters() {
    setState(() {
      remainingCharacters = _ReporttextController.text.length;
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    print("init");
    _ReporttextController.addListener(updateRemainingCharacters);
  }

  
  void dispose() {
    _ReporttextController.removeListener(updateRemainingCharacters);
    _ReporttextController.dispose();
    super.dispose();
  }

    Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

    
    return Theme(
        data: RestroomThemeData,
        child: Builder(builder: (context) {
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Stack(children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.2, left: size.width * 0.1),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              bottom: size.height * 0.01,
                            ),
                            height: size.height * 0.03,
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Name",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(0, 30, 49, 67),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.05),
                            child: ClayContainer(
                              height: size.height * 0.04,
                              width: size.width * 0.6,
                              color: Color.fromRGBO(239, 239, 239, 1),
                              borderRadius: 30,
                              depth: -20,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.03,top: size.height * 0.003),
                                child: Text(
                                  widget.restroomData["name"],
                                  style: TextStyle(
                                      fontFamily:
                                          widget.restroomData["name"].contains(
                                        RegExp("[ก-๛]"),
                                      )
                                              ? "THSarabunPSK"
                                              : "Sen",
                                      fontSize:
                                          widget.restroomData["name"].contains(
                                        RegExp("[ก-๛]"),
                                      )
                                              ? 22
                                              : 16,
                                      fontWeight:
                                          widget.restroomData["name"].contains(
                                        RegExp("[ก-๛]"),
                                      )
                                              ? FontWeight.w700
                                              : FontWeight.normal,
                                      color: Color.fromRGBO(0, 30, 49, 67)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.02),
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Position",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(0, 30, 49, 67),
                              ),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                             right: size.width * 0.1),
                        child: Column(
                          children: [
                            
                            Padding(
                              padding: EdgeInsets.only(top: size.height * 0.01),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: AspectRatio(
                                aspectRatio:
                                    30 / 30, // สามารถเปลี่ยนสัดส่วนตามรูปภาพได้
                                child: widget.restroomData["picture"] == null
                                    ? Image.asset(
                                        "assets/images/PinTheBin/bin_null.png",
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        widget.restroomData["picture"],
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Container(
                              // padding: EdgeInsets.only(left: 40),
                              child: Text(
                                'Report',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: size.height * 0.02,right: size.width * 0.1),
                            child: ClayContainer(
                              width: size.width * 0.82,
                              height: size.height * 0.17,
                              color: Color(0xFFEAEAEA),
                              borderRadius: 30,
                              depth: -20,
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  TextField(
                                    maxLength: 80,
                                    maxLines: 3,
                                    controller: _ReporttextController,
                                    // inputFormatters: [
                                    //   LengthLimitingTextInputFormatter(80),
                                    // ],
                                    decoration: InputDecoration(
                                      counterText: "",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 16, right: 16, bottom: 25),
                                      hintText: 'Write a report...',
                                    ),
                                  ),
                                  Positioned(
                                    top: 1,
                                    right: 16.0,
                                    child: Text(
                                      '$remainingCharacters/80',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.02, right: size.width * 0.1),
                        child: InkWell(
                          onTap: () {
                            _getImage();
                          },
                          child: _image == null
                          ? Container(
                            width: size.width * 0.8,
                            height: size.height * 0.125,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Color(0xFFFFB432).withOpacity(0.9),
                                  Color(0xFFFFFCCE).withOpacity(1),
                                ],
                              ),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.005,
                                    left: size.width * 0.01,
                                  ),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Opacity(
                                      opacity: 0.5,
                                      child: Image.asset(
                                          "assets/images/PinTheBin/corner.png"),
                                    ),
                                    width: size.width * 0.035,
                                    height: size.height * 0.035,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.005,
                                    left: size.width * 0.75,
                                  ),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Transform.rotate(
                                      angle: 90 * 3.141592653589793 / 180,
                                      child: Opacity(
                                        opacity: 0.5,
                                        child: Image.asset(
                                            "assets/images/PinTheBin/corner.png"),
                                      ),
                                    ),
                                    width: size.width * 0.035,
                                    height: size.height * 0.035,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.085,
                                    left: size.width * 0.01,
                                  ),
                                  child: Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Transform.rotate(
                                      angle: 270 * 3.141592653589793 / 180,
                                      child: Opacity(
                                        opacity: 0.5,
                                        child: Image.asset(
                                            "assets/images/PinTheBin/corner.png"),
                                      ),
                                    ),
                                    width: size.width * 0.035,
                                    height: size.height * 0.035,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.085,
                                    left: size.width * 0.75,
                                  ),
                                  child: Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Transform.rotate(
                                      angle: 180 * 3.141592653589793 / 180,
                                      child: Opacity(
                                        opacity: 0.5,
                                        child: Image.asset(
                                            "assets/images/PinTheBin/corner.png"),
                                      ),
                                    ),
                                    width: size.width * 0.035,
                                    height: size.height * 0.035,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.075),
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    child: Opacity(
                                      opacity: 0.4,
                                      child: Text(
                                        "Upload picture",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.03,
                                    left: size.width * 0.35,
                                  ),
                                  child: Image.asset(
                                    "assets/images/PinTheBin/upload.png",
                                    height: size.height * 0.05,
                                    color: Color.fromRGBO(255, 255, 255, 0.67),
                                  ),
                                ),
                              ],
                            ),
                          )
                          :  Padding(
                                    padding: const EdgeInsets.only(right: 0.5),
                                    child: Expanded(
                                      // ใช้ Expanded เพื่อให้รูปภาพขยายตามพื้นที่
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.file(
                                          _image!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.03, right: size.width * 0.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: ElevatedButton(
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
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 55.0),
                              child: ElevatedButton(
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
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: size.height * 0.035)),
                    ],
                  ),
                ),
                RestroomAppBar(scaffoldKey: _scaffoldKey),
              ]),
            ),
            drawerScrimColor: Colors.transparent,
            drawer: RestroomRoverNavbar(),
          );
        }));
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
                "Report Pin",
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
