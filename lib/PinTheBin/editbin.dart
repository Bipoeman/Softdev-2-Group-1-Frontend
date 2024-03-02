import 'package:clay_containers/widgets/clay_container.dart';
import "package:flutter/material.dart" hide BoxDecoration, BoxShadow;
import 'package:ruam_mitt/PinTheBin/pin_the_bin_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ruam_mitt/PinTheBin/bin_drawer.dart';
import 'package:neumorphic_button/neumorphic_button.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:latlong2/latlong.dart';
import 'package:ruam_mitt/PinTheBin/map_add_bin.dart';
import 'package:http/http.dart' as http;
import 'package:ruam_mitt/global_const.dart';

Color colorbackground = const Color(0x00000000);

class EditbinPage extends StatefulWidget {
  const EditbinPage({super.key, required this.binData});
  final Map<String, dynamic> binData;

  @override
  State<EditbinPage> createState() => _EditbinPageState();
}

class _EditbinPageState extends State<EditbinPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _LocationstextController = TextEditingController();
  TextEditingController _DescriptiontextController = TextEditingController();
  final Map<String, bool> _bintype = {
    'redbin': false,
    'greenbin': false,
    'yellowbin': false,
    'bluebin': false
  };

  @override
  void initState() {
    super.initState();
    _LocationstextController =
        TextEditingController(text: widget.binData['Bininfo']['location']);
    print(widget.binData['Bininfo']);
    _DescriptiontextController =
        TextEditingController(text: widget.binData['Bininfo']['description']);

    _bintype['redbin'] =
        widget.binData['Bininfo']['bintype']['redbin'] ?? false;
    _bintype['yellowbin'] =
        widget.binData['Bininfo']['bintype']['yellowbin'] ?? false;
    _bintype['greenbin'] =
        widget.binData['Bininfo']['bintype']['greenbin'] ?? false;
    _bintype['bluebin'] =
        widget.binData['Bininfo']['bintype']['bluebin'] ?? false;
  }

  final url = Uri.parse("$api/pinthebin/bin");
  void _presstosend() async {
    await http.post(url, body: {
      "location": _LocationstextController.text,
      "description": _DescriptiontextController.text,
      "bintype": _bintype,
      "id": widget.binData['Bininfo']['id']
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Offset distanceWarning = _bintype['redbin']!
        ? Offset(5, 5)
        : Offset(size.width * 0.008, size.height * 0.005);
    double blurWarning = _bintype['redbin']! ? 5.0 : 5;

    Offset distanceRecycling = _bintype['yellowbin']!
        ? Offset(5, 5)
        : Offset(size.width * 0.008, size.height * 0.005);
    double blurRecycling = _bintype['yellowbin']! ? 5.0 : 5;

    Offset distanceWaste = _bintype['greenbin']!
        ? Offset(5, 5)
        : Offset(size.width * 0.008, size.height * 0.005);
    double blurWaste = _bintype['greenbin']! ? 5.0 : 5;

    Offset distanceGeneral = _bintype['bluebin']!
        ? Offset(5, 5)
        : Offset(size.width * 0.008, size.height * 0.005);
    double blurGeneral = _bintype['bluebin']! ? 5.0 : 5;

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
            fontSize: 20,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.w300,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          bodySmall: TextStyle(
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
                        "EDIT",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
                body: SingleChildScrollView(
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
                                controller: _LocationstextController,
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
                      // Column(
                      //   children: [
                      //     Align(
                      //       alignment: Alignment.topLeft,
                      //       child: Container(
                      //         padding: EdgeInsets.only(left: 20),
                      //         child: Padding(
                      //           padding: const EdgeInsets.only(top: 67),
                      //           child: Text(
                      //             'Position',
                      //             style:
                      //                 Theme.of(context).textTheme.displayMedium,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(height: size.height * 0.02),
                      //     Column(
                      //       children: [
                      //         ClayContainer(
                      //           width: size.width * 0.75,
                      //           height: size.height * 0.032,
                      //           color: Color.fromRGBO(239, 239, 239, 1),
                      //           borderRadius: 30,
                      //           depth: -20,
                      //           child: Text(
                      //             'Latitude : ${widget.binData['Bininfo']['latitude']}',
                      //           ),
                      //         ),
                      //         SizedBox(
                      //           height: size.height * 0.015,
                      //         ),
                      //         ClayContainer(
                      //           width: size.width * 0.75,
                      //           height: size.height * 0.032,
                      //           color: Color.fromRGBO(239, 239, 239, 1),
                      //           borderRadius: 30,
                      //           depth: -20,
                      //           child: Text(
                      //             'Longitude : ${widget.binData['Bininfo']['longitude']}',
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.16, top: size.height * 0.085),
                        child: Container(
                          width: size.width * 0.7,
                          height: size.height * 0.25,
                          //color: Colors.black,
                          child: widget.binData['Bininfo']['picture'] == null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    fit: BoxFit.contain,
                                    "assets/images/PinTheBin/bin_null.png",
                                    //fit: BoxFit.fill,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    fit: BoxFit.contain,
                                    widget.binData['Bininfo']['picture'],
                                  ),
                                ),
                        ),
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.05,
                                  top: size.height * 0.36),

                              // padding: const EdgeInsets.only(
                              //     top: size.height * 0.1),
                              child: Text(
                                'Description',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.015,
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
                                color: Colors.black,
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
                                padding: EdgeInsets.only(
                                    left: size.width * 0.05,
                                    top: size.height * 0.57),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _bintype['redbin'] = !_bintype['redbin']!;
                                      _bintype['redbin'] = _bintype['redbin']!;
                                    });
                                    print("After: ${_bintype['redbin']}");
                                  },
                                  child: Container(
                                    width: size.width * 0.2,
                                    height: size.height * 0.13,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color.fromARGB(9, 0, 47, 73),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: blurWarning,
                                          offset: distanceWarning,
                                          color: Color(0xFFA7A9AF),
                                          inset: _bintype['redbin']!,
                                        ),
                                        BoxShadow(
                                          blurRadius: blurWarning,
                                          offset: -distanceWarning,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          inset: _bintype['redbin']!,
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
                                padding: EdgeInsets.only(
                                    left: size.width * 0.03,
                                    top: size.height * 0.01),
                                child: Align(
                                  //padding: const EdgeInsets.only(top: size.height * 0.0),
                                  child: Text(
                                    'DANGER',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
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
                                padding:
                                    EdgeInsets.only(top: size.height * 0.57),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _bintype['yellowbin'] =
                                          !_bintype['yellowbin']!;
                                      _bintype['yellowbin'] =
                                          _bintype['yellowbin']!;
                                    });
                                    print(_bintype['yellowbin']);
                                  },
                                  child: Container(
                                    width: size.width * 0.2,
                                    height: size.height * 0.13,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color.fromARGB(9, 0, 47, 73),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: blurRecycling,
                                          offset: distanceRecycling,
                                          color: Color(0xFFA7A9AF),
                                          inset: _bintype['yellowbin']!,
                                        ),
                                        BoxShadow(
                                          blurRadius: blurRecycling,
                                          offset: -distanceRecycling,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          inset: _bintype['yellowbin']!,
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
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.01),
                                  child: Text(
                                    'RECYCLE',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
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
                                padding:
                                    EdgeInsets.only(top: size.height * 0.57),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _bintype['greenbin'] =
                                          !_bintype['greenbin']!;
                                      _bintype['greenbin'] =
                                          _bintype['greenbin']!;
                                    });
                                    print(_bintype['greenbin']);
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
                                          inset: _bintype['greenbin']!,
                                        ),
                                        BoxShadow(
                                          blurRadius: blurWaste,
                                          offset: -distanceWaste,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          inset: _bintype['greenbin']!,
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
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.01),
                                  child: Text(
                                    'WASTE',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
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
                                padding:
                                    EdgeInsets.only(top: size.height * 0.57),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _bintype['bluebin'] =
                                          !_bintype['bluebin']!;
                                      _bintype['bluebin'] =
                                          _bintype['bluebin']!;
                                    });
                                    print(_bintype['bluebin']);
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
                                          inset: _bintype['bluebin']!,
                                        ),
                                        BoxShadow(
                                          blurRadius: blurGeneral,
                                          offset: -distanceGeneral,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          inset: _bintype['bluebin']!,
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
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.01),
                                  child: Text(
                                    'GENERAL',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.17,
                                top: size.height * 0.76),
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: size.width * 0.025,
                                    top: size.height * 0.009),
                                width: size.width * 0.25,
                                height: size.height * 0.055,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF9957F),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      //offset: ,
                                      color: Color(0xFFA7A9AF),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'CANCEL',
                                  style: GoogleFonts.getFont(
                                    "Sen",
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, pinthebinPageRoute['home']!);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.175,
                                top: size.height * 0.76),
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: size.width * 0.018,
                                    top: size.height * 0.008),
                                width: size.width * 0.25,
                                height: size.height * 0.055,
                                decoration: BoxDecoration(
                                  color: Color(0xFF547485),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      //offset: ,
                                      color: Color(0xFFA7A9AF),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'CHANGE',
                                  style: GoogleFonts.getFont(
                                    "Sen",
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Confirm change',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ),
                                        content: Text(
                                            'Would you like to confirm the modifications to your trash bin information?'),
                                        actions: [
                                          MaterialButton(
                                            onPressed: () {
                                              _presstosend();
                                            },
                                            child: Text('Confirm'),
                                          ),
                                          MaterialButton(
                                            color: Colors.red,
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: size.height * 0.007,
                                                  left: size.width * 0.02),
                                              width: size.width * 0.2,
                                              height: size.height * 0.05,
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      0, 244, 67, 54),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Text(
                                                'cancel',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                drawerScrimColor: Colors.transparent,
                drawer: const BinDrawer(),
              ),
            ],
          );
        },
      ),
    );
  }
}
