import 'package:clay_containers/widgets/clay_container.dart';
import "package:flutter/material.dart" hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
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
  int remainingCharacters = 80;
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
    _DescriptiontextController.addListener(updateRemainingCharacters);
  }

  void updateRemainingCharacters() {
    setState(() {
      remainingCharacters = _DescriptiontextController.text.length;
    });
  }

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
                  height: size.height * 0.03,
                ),
                Container(
                  alignment: Alignment.center,
                  // margin: EdgeInsets.only(left: 30),
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
                        padding: EdgeInsets.only(right: size.width * 0.77),
                        child: Container(
                          margin: EdgeInsets.only(bottom: size.height * 0.05),
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
                          margin: EdgeInsets.only(bottom: size.height * 0.05),
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
                            right: size.width * 0.77, top: size.height * 0.05),

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
                          margin: EdgeInsets.only(top: size.height * 0.05),
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
                            top: size.height * 0.055, left: size.width * 0.23),
                        child: Opacity(
                          opacity: 0.4,
                          child: Text(
                            "Upload picture",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      )
                      // itemSelection(title: 'upload', image: Image.asset("assets/images/PinTheBin/upload.png"), onTap: , context: context)
                    ],
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
                              controller: _DescriptiontextController,
                              // inputFormatters: [
                              //   LengthLimitingTextInputFormatter(80),
                              // ],
                              decoration: InputDecoration(
                                counterText: "",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 16,right: 16,bottom: 25 ),
                                hintText: 'Write a description...',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: size.height * 0.03,left: size.width*0.1),
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
                                      inset: isPressedWarning,
                                    ),
                                    BoxShadow(
                                      blurRadius: blurWarning,
                                      offset: -distanceWarning,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      inset: isPressedWarning,
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
                                child : Icon(Icons.baby_changing_station, size: 50),
                              ),
                            ),
                        ),
                        
                        Container(
                          // padding: EdgeInsets.only(left: 38),
                          margin: EdgeInsets.only(top: size.height * 0.01,left: size.width*0.1),
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
                          margin: EdgeInsets.only(top: size.height * 0.03,right: size.width*0.05),
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
                                      inset: isPressedRecycling,
                                    ),
                                    BoxShadow(
                                      blurRadius: blurRecycling,
                                      offset: -distanceRecycling,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      inset: isPressedRecycling,
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
                                  child : Icon(Icons.accessible_sharp, size: 50),
                                ),
                              ),
                            ),
                        ),
                        
                        Container(
                          margin: EdgeInsets.only(top: size.height * 0.01,right: size.width*0.05),
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
                            ElevatedButton(
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
                            ElevatedButton(
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
                          ],
                        ),
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
