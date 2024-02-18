//import 'dart:ffi';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:ruam_mitt/PinTheBin/map_add_bin.dart';
import 'package:ruam_mitt/PinTheBin/navbar.dart';
import 'package:latlong2/latlong.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:http/http.dart' as http;

class AddbinPage extends StatefulWidget {
  const AddbinPage({super.key});

  @override
  State<AddbinPage> createState() => _AddbinPageState();
}

class _AddbinPageState extends State<AddbinPage> {
  Map<String, bool> _bintype = {};
  LatLng? _position;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final url = Uri.parse("$api/pinthebin/bin");
  TextEditingController _LocationstextController = TextEditingController();
  TextEditingController _DescriptiontextController = TextEditingController();
  void _presstosend(LatLng position) async {
    var response = await http.post(url, body: {
      "location": _LocationstextController.text,
      "description": _DescriptiontextController.text,
      "bintype": '',
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
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 20),
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
              const SizedBox(height: 10),
              Container(
                width: 300,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFF77F00).withOpacity(0.45),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  scrollPadding: EdgeInsets.all(5),
                  controller: _LocationstextController,
                  onChanged: (text) {
                    print('Typed text: $text');
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
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
                  padding: EdgeInsets.only(left: 20),
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
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
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
                  padding: EdgeInsets.only(left: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 320),
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
                    margin: EdgeInsets.only(left: 50),
                    width: size.width * 0.20,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: Text(
                      "edit",
                      style: GoogleFonts.getFont(
                        'Sen',
                        color: Color.fromARGB(255, 0, 0, 0),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: size.width * 0.20,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: Text(
                  "ADD",
                  style: GoogleFonts.getFont(
                    'Sen',
                    color: Color.fromARGB(255, 0, 0, 0),
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
      drawer: const NavBar(),
      backgroundColor: Colors.black,
    );
  }
}
