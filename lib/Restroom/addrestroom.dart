import 'dart:io';

import 'package:clay_containers/widgets/clay_container.dart';
import "package:flutter/material.dart" hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ruam_mitt/PinTheBin/pin_the_bin_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ruam_mitt/PinTheBin/bin_drawer.dart';
import 'package:neumorphic_button/neumorphic_button.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:latlong2/latlong.dart';
import 'package:ruam_mitt/PinTheBin/map_add_bin.dart';
import 'package:ruam_mitt/Restroom/Component/navbar.dart';
import 'package:ruam_mitt/Restroom/Component/theme.dart';
import 'package:ruam_mitt/Restroom/findposition.dart';

class RestroomRoverAddrestroom extends StatefulWidget {
  const RestroomRoverAddrestroom({super.key});

  @override
  State<RestroomRoverAddrestroom> createState() =>
      _RestroomRoverAddrestroomState();
}

class _RestroomRoverAddrestroomState extends State<RestroomRoverAddrestroom> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _NametextController = TextEditingController();
  final TextEditingController _DescriptiontextController =
      TextEditingController();
  int remainingCharacters = 0;
  File? _image;
  final backgroundColor = const Color(0xFFFFFFFF);
  bool isPressed = true;
  bool isPressedHandicapped = false;
  bool isPressedKid = false;

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

  final Map<String, bool> _isPressedrestroomtype = {
    'isPressedKid': true,
    'isPressedHandicapped': true,
  };

  final Map<String, bool> _restroomtype = {
    'Kid': false,
    'Handicapped': false,
  };

  LatLng? _position;

  @override
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

  // void updateRemainingCharacters() {
  //   setState(() {
  //     remainingCharacters = _DescriptiontextController.text.length;
  //   });
  // }

  @override
  void dispose() {
    _DescriptiontextController.removeListener(updateRemainingCharacters);
    _DescriptiontextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Offset distance = isPressed
        ? Offset(5, 5)
        : Offset(size.width * 0.008, size.height * 0.005);
    double blur = isPressed ? 5.0 : 5;

    Offset distanceWarning = isPressedKid
        ? Offset(5, 5)
        : Offset(size.width * 0.008, size.height * 0.005);
    double blurWarning = isPressed ? 5.0 : 5;

    Offset distanceRecycling = isPressedHandicapped
        ? Offset(5, 5)
        : Offset(size.width * 0.008, size.height * 0.005);
    double blurRecycling = isPressedHandicapped ? 5.0 : 5;

    return Theme(
      data: RestroomThemeData,
      child: Builder(
        builder: (context) {
          return Scaffold(
            key: _scaffoldKey,
            body: SingleChildScrollView(
                child: Column(
              children: [
                RestroomAppBar(scaffoldKey: _scaffoldKey),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Text(
                            'Name',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(top: size.height * 0.035),
                      child: ClayContainer(
                        width: size.width * 0.65,
                        height: size.height * 0.032,
                        color: Color.fromRGBO(239, 239, 239, 1),
                        borderRadius: 30,
                        depth: -20,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            maxLength: 20,
                            textAlign: TextAlign.left,
                            controller: _NametextController,
                            onChanged: (text) {
                              print('Typed text: $text');
                            },
                            decoration: InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Position',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            setState(() => isPressed = !isPressed);
                            LatLng getPosResult = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RestroomRoverFindPosition()),
                            );
                            print("Result $getPosResult");
                            setState(() {
                              _position = getPosResult;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 30),
                            width: size.width * 0.165,
                            height: size.height * 0.038,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color.fromARGB(255, 255, 255, 255),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: blur,
                                  offset: distance,
                                  color: Color(0xFFA7A9AF),
                                  inset: isPressed,
                                ),
                                BoxShadow(
                                  blurRadius: blur,
                                  offset: -distance,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  inset: isPressed,
                                ),
                              ],
                            ),
                            child: Text(
                              'select',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Column(
                          children: [
                            ClayContainer(
                              width: size.width * 0.6,
                              height: size.height * 0.032,
                              color: Color.fromRGBO(239, 239, 239, 1),
                              borderRadius: 30,
                              depth: -20,
                              child: Text(
                                'Lat: ${_position?.latitude ?? ()}',
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            ClayContainer(
                              width: size.width * 0.6,
                              height: size.height * 0.032,
                              color: Color.fromRGBO(239, 239, 239, 1),
                              borderRadius: 30,
                              depth: -20,
                              child: Text(
                                'Lng: ${_position?.longitude ?? ()}',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.02, ),
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
                        : Padding(
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
                SizedBox(
                  height: size.height * 0.03,
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: 40),
                        child: Text(
                          'Description',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.02),
                      child: ClayContainer(
                        width: size.width * 0.78,
                        height: size.height * 0.2,
                        color: Color(0xFFEAEAEA),
                        borderRadius: 30,
                        depth: -20,
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            TextField(
                              maxLength: 150,
                              maxLines: 5,
                              controller: _DescriptiontextController,
                              // inputFormatters: [
                              //   LengthLimitingTextInputFormatter(80),
                              // ],
                              decoration: InputDecoration(
                                counterText: "",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 16, right: 16, top: 0),
                                hintText: 'Write a description...',
                              ),
                            ),
                            Positioned(
                              top: 1,
                              right: 16.0,
                              child: Text(
                                '$remainingCharacters/150',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: size.height * 0.03, left: size.width * 0.1),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _restroomtype['Kid'] = !_restroomtype['Kid']!;
                                isPressedKid = _restroomtype['Kid']!;
                              });
                              print(_restroomtype['Kid']);
                            },
                            child: Container(
                              width: size.width * 0.2,
                              height: size.height * 0.1,
                              //color: Colors.black,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color.fromARGB(9, 0, 47, 73),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: blurWarning,
                                    offset: distanceWarning,
                                    color: Color(0xFFA7A9AF),
                                    inset: isPressedKid,
                                  ),
                                  BoxShadow(
                                    blurRadius: blurWarning,
                                    offset: -distanceWarning,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    inset: isPressedKid,
                                  ),
                                ],
                              ),
                              // child: Align(
                              //   alignment: Alignment.center,
                              //   child: Image.asset(
                              //     "assets/images/PinTheBin/warning.png",
                              //     width: size.width * 0.1,
                              //     height: size.height * 0.1,
                              //   ),
                              // ),
                              child:
                                  Icon(Icons.baby_changing_station, size: 50),
                            ),
                          ),
                        ),
                        Container(
                          // padding: EdgeInsets.only(left: 38),
                          margin: EdgeInsets.only(
                              top: size.height * 0.01, left: size.width * 0.1),
                          child: Text(
                            'Kid',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: size.height * 0.03,
                              right: size.width * 0.05),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _restroomtype['Handicapped'] =
                                    !_restroomtype['Handicapped']!;
                                isPressedHandicapped =
                                    _restroomtype['Handicapped']!;
                              });
                              print(_restroomtype['Handicapped']);
                            },
                            // onDoubleTap: () {
                            //   setState(() => isPressedRecycling = false);
                            //   if (_bintype['yellowbin'] == true) {
                            //     setState(() {
                            //       _bintype['yellowbin'] = false;
                            //     });
                            //     print(_bintype['yellowbin']);
                            //   } else {
                            //     _bintype['yellowbin'] = true;
                            //   }
                            // },
                            child: Container(
                              width: size.width * 0.2,
                              height: size.height * 0.1,
                              //color: Colors.black,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color.fromARGB(9, 0, 47, 73),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: blurRecycling,
                                    offset: distanceRecycling,
                                    color: Color(0xFFA7A9AF),
                                    inset: isPressedHandicapped,
                                  ),
                                  BoxShadow(
                                    blurRadius: blurRecycling,
                                    offset: -distanceRecycling,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    inset: isPressedHandicapped,
                                  ),
                                ],
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                // child: Image.asset(
                                //   "assets/images/PinTheBin/recycling-symbol-2.png",
                                //   width: size.width * 0.1,
                                //   height: size.height * 0.1,
                                // ),
                                child: Icon(Icons.accessible_sharp, size: 50),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: size.height * 0.01,
                              right: size.width * 0.05),
                          //padding: EdgeInsets.only(left: 0),
                          child: Text(
                            'Handicapped',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
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
                          style: Theme.of(context).textTheme.displayLarge,
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
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: size.height * 0.035)),
              ],
            )),
            drawerScrimColor: Colors.transparent,
            drawer: RestroomRoverNavbar(),
          );
        },
      ),
    );
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
                "Pin Restroom",
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
