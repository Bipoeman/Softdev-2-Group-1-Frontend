//import 'dart:ffi';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:ruam_mitt/PinTheBin/map_add_bin.dart';
//import 'package:ruam_mitt/PinTheBin/navbar.dart';
import 'package:latlong2/latlong.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:http/http.dart' as http;

class AddbinPage extends StatefulWidget {
  const AddbinPage({super.key});

  @override
  State<AddbinPage> createState() => _AddbinPageState();
}

class _AddbinPageState extends State<AddbinPage> {
  final Map<String, bool> _bintype = {
    'redbin': false,
    'greenbin': false,
    'yellowbin': false,
    'bluebin': false
  };
  LatLng? _position;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final url = Uri.parse("$api/pinthebin/bin");
  final TextEditingController _LocationstextController = TextEditingController();
  final TextEditingController _DescriptiontextController = TextEditingController();
  void _presstosend(LatLng position) async {
    await http.post(url, body: {
      "location": _LocationstextController.text,
      "description": _DescriptiontextController.text,
      "bintype": _bintype,
      "latitude": position.latitude,
      "longitude": position.longitude,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: const Color(0xFFF77F00),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Icon(Icons.menu),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              //padding: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(top: 50),
              child: Text('Add Bin',
                  style: GoogleFonts.getFont(
                    "Sen",
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Text(
                      'Name',
                      style: GoogleFonts.getFont(
                        'Sen',
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            
              Container(
                width: 300,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFF77F00).withOpacity(0.45),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  scrollPadding: const EdgeInsets.all(5),
                  controller: _LocationstextController,
                  onChanged: (text) {
                    print('Typed text: $text');
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
          Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 175),
                    child: Text(
                      'Description',
                      style: GoogleFonts.getFont(
                        'Sen',
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 300,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFF77F00).withOpacity(0.45),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  maxLength: 80,
                  maxLines: 3,
                  controller: _DescriptiontextController,
                  onChanged: (text) {
                    print('Typed text: $text');
                    int remainningCharacters =
                        80 - _DescriptiontextController.text.length;
                    print('Remaining characters: $remainningCharacters');
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 325),
                    child: Text(
                      'Position',
                      style: GoogleFonts.getFont(
                        'Sen',
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(children: [
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 50),
                    width: size.width * 0.20,
                    height: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: Text(
                      "edit",
                      style: GoogleFonts.getFont(
                        'Sen',
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  onTap: () async {
                    LatLng getPosResult = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MapaddBinPage()),
                    );
                    print("Result $getPosResult");
                    setState(() {
                      _position = getPosResult;
                    });
                  },
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(left: 10),
                      width: 200,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: const Color(0xFFF77F00).withOpacity(0.45),
                      ),
                      child: Text(
                        'Lat: ${_position?.latitude ?? ()}',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(left: 10),
                      width: 200,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: const Color(0xFFF77F00).withOpacity(0.45),
                      ),
                      child: Text('Lng: ${_position?.longitude ?? ()}'),
                    ),
                  ],
                ),
              ]),
            ],
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 425),
                    child: Text(
                      'Picture',
                      style: GoogleFonts.getFont(
                        'Sen',
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(left: 50),
                      width: 80,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        "Choose",
                        style: GoogleFonts.getFont(
                          'Sen',
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 210,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF77F00).withOpacity(0.45),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 510),
                    child: Text(
                      'Type',
                      style: GoogleFonts.getFont(
                        'Sen',
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: _bintype['redbin'] != null ? 1.0 : 0.5,
                      child: Container(
                        margin: const EdgeInsets.only(left: 50),
                        alignment: Alignment.bottomLeft,
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color:
                              const Color.fromARGB(255, 255, 0, 0).withOpacity(0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (_bintype['greenbin'] == false &&
                          _bintype['yellowbin'] == false &&
                          _bintype['bluebin'] == false) {
                        setState(() {
                          _bintype['redbin'] = true;
                        });
                        print(_bintype['redbin']);
                      } else {
                        _bintype['redbin'] = false;
                      }
                    },
                    onDoubleTap: () {
                      if (_bintype['redbin'] == true) {
                        setState(() {
                          _bintype['redbin'] = false;
                        });
                        print(_bintype['redbin']);
                      } else {
                        _bintype['redbin'] = true;
                      }
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      alignment: Alignment.bottomLeft,
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color:
                            const Color.fromARGB(255, 255, 251, 0).withOpacity(0.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onTap: () {
                      if (_bintype['greenbin'] == false &&
                          _bintype['redbin'] == false &&
                          _bintype['bluebin'] == false) {
                        setState(() {
                          _bintype['yellowbin'] = true;
                        });
                        print(_bintype['yellowbin']);
                      } else {
                        _bintype['yellowbin'] = false;
                      }
                    },
                    onDoubleTap: () {
                      if (_bintype['yellowbin'] == true) {
                        setState(() {
                          _bintype['yellowbin'] = false;
                        });
                        print(_bintype['yellowbin']);
                      } else {
                        _bintype['yellowbin'] = true;
                      }
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      alignment: Alignment.bottomLeft,
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 255, 21).withOpacity(0.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onTap: () {
                      if (_bintype['redbin'] == false &&
                          _bintype['yellowbin'] == false &&
                          _bintype['bluebin'] == false) {
                        setState(() {
                          _bintype['greenbin'] = true;
                        });
                        print(_bintype['greenbin']);
                      } else {
                        _bintype['greenbin'] = false;
                      }
                    },
                    onDoubleTap: () {
                      if (_bintype['greenbin'] == true) {
                        setState(() {
                          _bintype['greenbin'] = false;
                        });
                        print(_bintype['greenbin']);
                      } else {
                        _bintype['greenbin'] = true;
                      }
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      alignment: Alignment.bottomLeft,
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color:
                            const Color.fromARGB(255, 0, 119, 255).withOpacity(0.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onTap: () {
                      if (_bintype['greenbin'] == false &&
                          _bintype['yellowbin'] == false &&
                          _bintype['redbin'] == false) {
                        setState(() {
                          _bintype['bluebin'] = true;
                        });
                        print(_bintype['bluebin']);
                      } else {
                        _bintype['bluebin'] = false;
                      }
                    },
                    onDoubleTap: () {
                      if (_bintype['bluebin'] == true) {
                        setState(() {
                          _bintype['bluebin'] = false;
                        });
                        print(_bintype['bluebin']);
                      } else {
                        _bintype['bluebin'] = true;
                      }
                    },
                  ),
                ],
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: size.width * 0.20,
                height: 40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Text(
                  "ADD",
                  style: GoogleFonts.getFont(
                    'Sen',
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              onTap: () {
                if (_position != null) {
                  _presstosend(_position!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Please pin the position.",
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                  );
                }
              },
            ),
          )
        ]),
      ),
      //drawer: const NavBar(),
      backgroundColor: Colors.black,
    );
  }
}
