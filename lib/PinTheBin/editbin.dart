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
    Size size = MediaQuery.of(context).size;

    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    _LocationstextController =
        TextEditingController(text: arguments['Bininfo']['location']);
    print(arguments['Bininfo']);
    _DescriptiontextController =
        TextEditingController(text: arguments['Bininfo']['description']);

    // _LatitudetextController =
    //     TextEditingController(text: arguments['Bininfo']['latitude']);
    final url = Uri.parse("$api/pinthebin/bin");
    void _presstosend() async {
      await http.post(url, body: {
        "location": _LocationstextController.text,
        "description": _DescriptiontextController.text,
        //"bintype": _bintype,
        "id": arguments['Bininfo']['id']
      });
    }

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
                      Column(
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
                          Column(
                            children: [
                              ClayContainer(
                                width: size.width * 0.75,
                                height: size.height * 0.032,
                                color: Color.fromRGBO(239, 239, 239, 1),
                                borderRadius: 30,
                                depth: -20,
                                child: Text(
                                  'Latitude : ${arguments['Bininfo']['latitude']}',
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              ClayContainer(
                                width: size.width * 0.75,
                                height: size.height * 0.032,
                                color: Color.fromRGBO(239, 239, 239, 1),
                                borderRadius: 30,
                                depth: -20,
                                child: Text(
                                  'Longitude : ${arguments['Bininfo']['longitude']}',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.16, top: size.height * 0.23),
                        child: Container(
                          width: size.width * 0.7,
                          height: size.height * 0.15,
                          child: arguments['Bininfo']['picture'] == null
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
                                    arguments['Bininfo']['picture'],
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
                                  top: size.height * 0.39),

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
                          Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.17,
                                top: size.height * 0.77),
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: size.width * 0.017,
                                    top: size.height * 0.01),
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
                          Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.175,
                                top: size.height * 0.77),
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: size.width * 0.024,
                                    top: size.height * 0.01),
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
