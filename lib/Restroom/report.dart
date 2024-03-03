import 'dart:io';

import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ruam_mitt/Restroom/Component/navbar.dart';
import 'package:ruam_mitt/Restroom/Component/theme.dart';
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
  File? _image;
  int remainingCharacters = 0;

  
  void updateRemainingCharacters() {
    setState(() {
      remainingCharacters = _DescriptiontextController.text.length;
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    print("init");
    _DescriptiontextController.addListener(updateRemainingCharacters);
  }

  
  void dispose() {
    _DescriptiontextController.removeListener(updateRemainingCharacters);
    _DescriptiontextController.dispose();
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var rating = 2.5;
    return Theme(
        data: RestroomThemeData,
        child: Builder(builder: (context) {
          return Scaffold(
            key: _scaffoldKey,
            body: Column(
              children: [
                RestroomAppBar(
                    scaffoldKey: _scaffoldKey), // วาง AppBar ไว้ด้านบน
                Expanded(
                  // ใช้ Expanded เพื่อให้ Row และเนื้อหาด้านล่างมีพื้นที่เท่ากัน
                  child: SingleChildScrollView(
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
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
                                color: Color(0xFFEAEAEA),
                                borderRadius: 30,
                                depth: -20,
                                child: TextField(
                                  maxLength: 17,
                                  controller: _TopictextController,
                                  onChanged: (text) {
                                    print('Typed text: $text');
                                  },
                                  decoration: InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 6.5),
                                    hintText: 'Write a topic...',
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
                          'Report',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.02),
                      child: ClayContainer(
                        width: size.width * 0.78,
                        height: size.height * 0.3,
                        color: Color(0xFFEAEAEA),
                        borderRadius: 30,
                        depth: -20,
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            TextField(
                              maxLength: 200,
                              maxLines: 9,
                              controller: _DescriptiontextController,
                              // inputFormatters: [
                              //   LengthLimitingTextInputFormatter(80),
                              // ],
                              decoration: InputDecoration(
                                
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 16, right: 16, top: 15),
                                hintText: 'Write a report...',
                              ),
                            ),
                            // Positioned(
                            //   top: 1,
                            //   right: 16.0,
                            //   child: Text(
                            //     '$remainingCharacters/250',
                            //     style: TextStyle(
                            //       color: Colors.grey,
                            //       fontSize: 12.0,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.05, right: size.width * 0.1),
                          child: InkWell(
                            onTap: () {
                              _getImage();
                            },
                            child: _image == null
                                ? Container(
                                    margin:
                                        EdgeInsets.only(left: size.width * 0.1),
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
                                              left: size.width * 0.01),
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            width: size.width * 0.035,
                                            height: size.height * 0.035,
                                            child: Opacity(
                                              opacity: 0.5,
                                              child: Image.asset(
                                                  "assets/images/PinTheBin/corner.png"),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: size.height * 0.005,
                                              left: size.width * 0.75),
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            width: size.width * 0.035,
                                            height: size.height * 0.035,
                                            child: Transform.rotate(
                                              angle:
                                                  90 * 3.141592653589793 / 180,
                                              child: Opacity(
                                                opacity: 0.5,
                                                child: Image.asset(
                                                    "assets/images/PinTheBin/corner.png"),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: size.height * 0.085,
                                              left: size.width * 0.01),
                                          child: Container(
                                            alignment: Alignment.bottomLeft,
                                            width: size.width * 0.035,
                                            height: size.height * 0.035,
                                            child: Transform.rotate(
                                              angle:
                                                  270 * 3.141592653589793 / 180,
                                              child: Opacity(
                                                opacity: 0.5,
                                                child: Image.asset(
                                                    "assets/images/PinTheBin/corner.png"),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: size.height * 0.085,
                                              left: size.width * 0.75),
                                          child: Container(
                                            alignment: Alignment.bottomLeft,
                                            width: size.width * 0.035,
                                            height: size.height * 0.035,
                                            child: Transform.rotate(
                                              angle:
                                                  180 * 3.141592653589793 / 180,
                                              child: Opacity(
                                                opacity: 0.5,
                                                child: Image.asset(
                                                    "assets/images/PinTheBin/corner.png"),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: size.height * 0.075),
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
                                              left: size.width * 0.35),
                                          child: Image.asset(
                                            "assets/images/PinTheBin/upload.png",
                                            height: size.height * 0.05,
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 0.67),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(left: 35),
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

                        SizedBox(
                            height: size.height *
                                0.05), // เพิ่มระยะห่างระหว่าง Row กับเนื้อหาด้านล่าง
                        Row(
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
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
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
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                              ),
                            ),
                            
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: size.height * 0.035)),
                      ],
                    ),
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
