import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:ruam_mitt/PinTheBin/map_add_bin.dart';
import 'package:ruam_mitt/PinTheBin/navbar.dart';
import 'package:latlong2/latlong.dart';

class AddbinPage extends StatefulWidget {
  const AddbinPage({super.key});

  @override
  State<AddbinPage> createState() => _AddbinPageState();
}

class _AddbinPageState extends State<AddbinPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _LocationstextController = TextEditingController();
  TextEditingController _DescriptiontextController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    width: size.width * 0.20,
                    height: 40,
                    color: Colors.white,
                    child: const Text(
                      "edit",
                      style: TextStyle(
                        color: Colors.black,
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
                  },
                ),
                //Container(
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  width: size.width * 0.20,
                  height: 40,
                  color: Colors.white,
                  child: const Text(
                    "edit",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                //)
              ]),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              child: Container(
                width: size.width * 0.20,
                height: 40,
                color: Colors.white,
                child: const Text(
                  "add",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              onTap: () {},
            ),
          )
        ]),
      ),
      drawer: const NavBar(),
      backgroundColor: Colors.black,
    );
  }
}
