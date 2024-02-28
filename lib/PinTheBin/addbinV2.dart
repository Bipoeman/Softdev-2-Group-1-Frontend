import 'package:clay_containers/widgets/clay_container.dart';
import "package:flutter/material.dart" hide BoxDecoration, BoxShadow;
import 'package:ruam_mitt/PinTheBin/pin_the_bin_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ruam_mitt/PinTheBin/bin_drawer.dart';
import 'package:neumorphic_button/neumorphic_button.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:latlong2/latlong.dart';
import 'package:ruam_mitt/PinTheBin/map_add_bin.dart';

class AddbinPageV2 extends StatefulWidget {
  const AddbinPageV2({super.key});

  @override
  State<AddbinPageV2> createState() => _AddbinPageV2State();
}

class _AddbinPageV2State extends State<AddbinPageV2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _NametextController = TextEditingController();
  TextEditingController _DescriptiontextController = TextEditingController();
  final backgroundColor = const Color(0xFFFFFFFF);
  bool isPressed = true;
  bool isPressedWarning = false;
  bool isPressedRecycling = false;
  bool isPressedWaste = false;
  bool isPressedGeneral = false;

  final Map<String, bool> _isPressedbintype = {
    'isPressedWarning': true,
    'isPressedRecycling': true,
    'isPressedwaste': true,
    'isPressedgeneral': true
  };

  final Map<String, bool> _bintype = {
    'redbin': false,
    'greenbin': false,
    'yellowbin': false,
    'bluebin': false
  };

  LatLng? _position;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Offset distance = isPressed
        ? Offset(5, 5)
        : Offset(size.width * 0.008, size.height * 0.005);
    double blur = isPressed ? 5.0 : 5;

    Offset distanceWarning = isPressedWarning
        ? Offset(5, 5)
        : Offset(size.width * 0.008, size.height * 0.005);
    double blurWarning = isPressed ? 5.0 : 5;

    Offset distanceRecycling = isPressedRecycling
        ? Offset(5, 5)
        : Offset(size.width * 0.008, size.height * 0.005);
    double blurRecycling = isPressedRecycling ? 5.0 : 5;

    Offset distanceWaste = isPressedWaste
        ? Offset(5, 5)
        : Offset(size.width * 0.008, size.height * 0.005);
    double blurWaste = isPressedWaste ? 5.0 : 5;

    Offset distanceGeneral = isPressedGeneral
        ? Offset(5, 5)
        : Offset(size.width * 0.008, size.height * 0.005);
    double blurGeneral = isPressedGeneral ? 5.0 : 5;
    return Theme(
      data: ThemeData(
        fontFamily: "Sen",
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF9957F),
          background: const Color(0xFFFFFFFF),
        ),
        textTheme: TextTheme(
          headlineMedium: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          headlineSmall: TextStyle(
            fontSize: 30,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF003049),
            shadows: [
              Shadow(
                blurRadius: 20,
                offset: const Offset(0, 3),
                color: const Color(0xFF003049).withOpacity(0.3),
              ),
            ],
          ),
          displayMedium: TextStyle(
            fontSize: 20,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF003049).withOpacity(0.67),
          ),
          displaySmall: TextStyle(
            fontSize: 13.5,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF003049).withOpacity(0.45),
          ),
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white,
            size: 35,
          ),
        ),
        drawerTheme: const DrawerThemeData(
          scrimColor: Colors.transparent,
          backgroundColor: Color(0xFFF9957F),
        ),
      ),
      child: Builder(
        builder: (context) {
          return Stack(
            children: [
              Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  leading: GestureDetector(
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.menu_rounded),
                        SizedBox(height: 15)
                      ],
                    ),
                    onTap: () => _scaffoldKey.currentState?.openDrawer(),
                  ),
                  toolbarHeight: 90,
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Color(0xFFF99680),
                          Color(0xFFF8A88F),
                        ],
                      ),
                    ),
                  ),
                  title: Column(
                    children: [
                      Text(
                        "ADD BIN",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
                body: SafeArea(
                    child: Stack(
                  children: [
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
                                style:
                                    Theme.of(context).textTheme.displayMedium,
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
                            child: TextField(
                              controller: _NametextController,
                              onChanged: (text) {
                                print('Typed text: $text');
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 67),
                              child: Text(
                                'Position',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
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
                                          const MapaddBinPage()),
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
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
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
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.25),
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 30),
                        width: size.width * 0.84,
                        height: size.height * 0.1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color(0xFF292643).withOpacity(0.46),
                              Color(0xFFF9A58D).withOpacity(0.72),
                            ],
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(right: size.width * 0.77),
                              child: Container(
                                margin:
                                    EdgeInsets.only(bottom: size.height * 0.05),
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
                            Container(
                              padding: EdgeInsets.only(left: size.width * 0.77),
                              child: Container(
                                margin:
                                    EdgeInsets.only(bottom: size.height * 0.05),
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
                            Container(
                              padding: EdgeInsets.only(
                                  right: size.width * 0.77,
                                  top: size.height * 0.05),

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
                                // decoration: BoxDecoration(
                                //     border: Border.all(
                                //         color: Colors.black, width: 10)),
                              ),
                              //),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: size.width * 0.77),
                              child: Container(
                                margin:
                                    EdgeInsets.only(top: size.height * 0.05),
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
                              padding: EdgeInsets.only(
                                  top: size.height * 0.055,
                                  left: size.width * 0.23),
                              child: Opacity(
                                opacity: 0.4,
                                child: Text(
                                  "Upload picture",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                            )
                            // itemSelection(title: 'upload', image: Image.asset("assets/images/PinTheBin/upload.png"), onTap: , context: context)
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 290),
                              child: Text(
                                'Description',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        ClayContainer(
                          width: size.width * 0.8,
                          height: size.height * 0.15,
                          color: Color.fromRGBO(239, 239, 239, 1),
                          borderRadius: 30,
                          depth: -20,
                          child: TextField(
                            maxLength: 80,
                            maxLines: 3,
                            controller: _DescriptiontextController,
                            onChanged: (text) {
                              print('Typed text: $text');
                              int remainningCharacters =
                                  80 - _DescriptiontextController.text.length;
                              print(
                                  'Remaining characters: $remainningCharacters');
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20, top: 460),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() => isPressedWarning = false);
                                  setState(() => _bintype['redbin'] = true);
                                  print(_bintype['redbin']);
                                  if (_bintype['redbin'] == true) {
                                    setState(() {
                                      isPressedWarning = !isPressedWarning;
                                    });
                                  } else {
                                    isPressedWarning = true;
                                  }
                                  // if (_bintype['greenbin'] == false &&
                                  //     _bintype['yellowbin'] == false &&
                                  //     _bintype['bluebin'] == false) {
                                  //   setState(() {
                                  //     _bintype['redbin'] = true;
                                  //   });
                                  //   setState(() {
                                  //     isPressedWarning = !isPressedWarning;
                                  //     isPressedRecycling = false;
                                  //   });

                                  //   //isPressedRecycling = false;
                                  //   print(_bintype['redbin']);
                                  // } else {
                                  //   _bintype['redbin'] = false;
                                  //   isPressedWarning = true;
                                  // }
                                },
                                onDoubleTap: () {
                                  setState(() => isPressedWarning = false);
                                  if (_bintype['redbin'] == true) {
                                    setState(() {
                                      _bintype['redbin'] = false;
                                    });
                                    print(_bintype['redbin']);
                                  } else {
                                    _bintype['redbin'] = true;
                                  }
                                },
                                child: Container(
                                  width: size.width * 0.2,
                                  height: size.height * 0.13,
                                  //color: Colors.black,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color.fromARGB(9, 0, 47, 73),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: blurWarning,
                                        offset: distanceWarning,
                                        color: Color(0xFFA7A9AF),
                                        inset: isPressedWarning,
                                      ),
                                      BoxShadow(
                                        blurRadius: blurWarning,
                                        offset: -distanceWarning,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        inset: isPressedWarning,
                                      ),
                                    ],
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/images/PinTheBin/warning.png",
                                      width: size.width * 0.1,
                                      height: size.height * 0.1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 38),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'DANGER',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 460),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() => isPressedRecycling = false);
                                  setState(() => _bintype['yellowbin'] = true);
                                  print(_bintype['yellowbin']);
                                  if (_bintype['yellowbin'] == true) {
                                    setState(() {
                                      isPressedRecycling = !isPressedRecycling;
                                    });
                                  } else {
                                    isPressedRecycling = true;
                                  }
                                  //   setState(() => isPressedRecycling = false);
                                  // },
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
                                },
                                onDoubleTap: () {
                                  setState(() => isPressedRecycling = false);
                                  if (_bintype['yellowbin'] == true) {
                                    setState(() {
                                      _bintype['yellowbin'] = false;
                                    });
                                    print(_bintype['yellowbin']);
                                  } else {
                                    _bintype['yellowbin'] = true;
                                  }
                                },
                                child: Container(
                                  width: size.width * 0.2,
                                  height: size.height * 0.13,
                                  //color: Colors.black,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color.fromARGB(9, 0, 47, 73),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: blurRecycling,
                                        offset: distanceRecycling,
                                        color: Color(0xFFA7A9AF),
                                        inset: isPressedRecycling,
                                      ),
                                      BoxShadow(
                                        blurRadius: blurRecycling,
                                        offset: -distanceRecycling,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        inset: isPressedRecycling,
                                      ),
                                    ],
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/images/PinTheBin/recycling-symbol-2.png",
                                      width: size.width * 0.1,
                                      height: size.height * 0.1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              //padding: EdgeInsets.only(left: 0),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'RECYCLE',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 460),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() => isPressedWaste = false);
                                  setState(() => _bintype['greenbin'] = true);
                                  print(_bintype['greenbin']);
                                  if (_bintype['greenbin'] == true) {
                                    setState(() {
                                      isPressedWaste = !isPressedWaste;
                                    });
                                  } else {
                                    isPressedWaste = true;
                                  }
                                  //   setState(() => isPressedRecycling = false);
                                  // },
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
                                },
                                onDoubleTap: () {
                                  setState(() => isPressedWaste = false);
                                  if (_bintype['greenbin'] == true) {
                                    setState(() {
                                      _bintype['greenbin'] = false;
                                    });
                                    print(_bintype['greenbin']);
                                  } else {
                                    _bintype['greenbin'] = true;
                                  }
                                },
                                child: Container(
                                  width: size.width * 0.2,
                                  height: size.height * 0.13,
                                  //color: Colors.black,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color.fromARGB(9, 0, 47, 73),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: blurWaste,
                                        offset: distanceWaste,
                                        color: Color(0xFFA7A9AF),
                                        inset: isPressedWaste,
                                      ),
                                      BoxShadow(
                                        blurRadius: blurWaste,
                                        offset: -distanceWaste,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        inset: isPressedWaste,
                                      ),
                                    ],
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/images/PinTheBin/compost.png",
                                      width: size.width * 0.1,
                                      height: size.height * 0.1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              //padding: EdgeInsets.only(left: 0),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'WASTE',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 460),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() => isPressedGeneral = false);
                                  setState(() => _bintype['bluebin'] = true);
                                  print(_bintype['bluebin']);
                                  if (_bintype['bluebin'] == true) {
                                    setState(() {
                                      isPressedGeneral = !isPressedGeneral;
                                    });
                                  } else {
                                    isPressedGeneral = true;
                                  }
                                  //   setState(() => isPressedRecycling = false);
                                  // },
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
                                },
                                onDoubleTap: () {
                                  setState(() => isPressedGeneral = false);
                                  if (_bintype['bluebin'] == true) {
                                    setState(() {
                                      _bintype['bluebin'] = false;
                                    });
                                    print(_bintype['bluebin']);
                                  } else {
                                    _bintype['bluebin'] = true;
                                  }
                                },
                                child: Container(
                                  width: size.width * 0.2,
                                  height: size.height * 0.13,
                                  //color: Colors.black,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color.fromARGB(9, 0, 47, 73),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: blurGeneral,
                                        offset: distanceGeneral,
                                        color: Color(0xFFA7A9AF),
                                        inset: isPressedGeneral,
                                      ),
                                      BoxShadow(
                                        blurRadius: blurGeneral,
                                        offset: -distanceGeneral,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        inset: isPressedGeneral,
                                      ),
                                    ],
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/images/PinTheBin/bin.png",
                                      width: size.width * 0.1,
                                      height: size.height * 0.1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              //padding: EdgeInsets.only(left: 0),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'GENERAL',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
                drawerScrimColor: Colors.transparent,
                drawer: const BinDrawer(),
              )
            ],
          );
        },
      ),
    );
  }
}
