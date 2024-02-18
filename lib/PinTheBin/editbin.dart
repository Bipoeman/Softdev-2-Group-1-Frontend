import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:ruam_mitt/PinTheBin/NavBar.dart';

Color colorbackground = const Color(000000);

class EditbinPage extends StatefulWidget {
  const EditbinPage({super.key});

  @override
  State<EditbinPage> createState() => _EditbinPageState();
}

class _EditbinPageState extends State<EditbinPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _LocationstextController = TextEditingController();
  TextEditingController _DescriptiontextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    _LocationstextController =
        TextEditingController(text: arguments['Bininfo']['location']);
    _DescriptiontextController =
        TextEditingController(text: arguments['Bininfo']['description']);
    print(arguments['Bininfo']);
    print(_LocationstextController);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Center(
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
                padding: const EdgeInsets.only(top: 50),
                child: Text('Edit Bin',
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
          ],
        ),
      ),
      drawer: const NavBar(),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
    );
  }
}
