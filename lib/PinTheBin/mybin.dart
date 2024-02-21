import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:provider/provider.dart";
import "package:ruam_mitt/PinTheBin/navbar.dart";
import "package:ruam_mitt/RuamMitr/Component/theme.dart";
import "package:ruam_mitt/global_const.dart";
import 'package:google_fonts/google_fonts.dart';

class MyBinPage extends StatefulWidget {
  const MyBinPage({super.key});

  @override
  State<MyBinPage> createState() => _MyBinState();
}

class _MyBinState extends State<MyBinPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic binData = {
    [
      {"latitude": 13.825605, "longitude": 100.514476, "description": "test"},
      {"latitude": 13.8256, "longitude": 100.5144, "description": "test"},
      {"latitude": 13.82, "longitude": 100.51, "description": "test"},
      {"latitude": 13, "longitude": 100, "description": "test"},
    ]
  };
  // Future<http.Response> myBinInfo() async {
  //   Uri url = Uri.parse("$api$pinTheBinGetBinRoute");
  //   http.Response res = await http.get(url, headers: {"Authorization": ""});
  //   print(res.body);
  //   return res;
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   print("Init Bin Page");
  //   myBinInfo().then((response) {
  //     // print("Response");
  //     // print(response.body);
  //     setState(() {
  //       binData = jsonDecode(response.body);
  //     });
  //     // print(binData);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    ThemeProvider themes = Provider.of<ThemeProvider>(context);
    ThemeData pinTheBinTheme = themes.themeFrom("PinTheBin")!.themeData;
    return Theme(
      data: pinTheBinTheme,
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Stack(children: [
            Positioned(
              top: size.height * 0.01,
              left: size.width * 0.025,
              child: GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                child: Container(
                  width: size.width * 0.1,
                  height: size.height * 0.05,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF77F00),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.menu),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  size.width * 0.36, size.height * 0.01, 0, 0),
              child: Text(
                "My Bin",
                style: GoogleFonts.getFont(
                  'Sen',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: binData.isEmpty
                  ? [
                      Center(
                          heightFactor: size.height * 0.02,
                          child: Text(
                            'No Bin Found!',
                            style: GoogleFonts.getFont(
                              'Sen',
                              color: Color(0xFFF77F00),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                    ]
                  : [
                      Center(
                          heightFactor: size.height * 0.01,
                          child: Text(
                            'No Bin Found!',
                            style: GoogleFonts.getFont(
                              'Sen',
                              color: Color(0xFFF77F00),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                    ],
            )
          ]),
        ),
        drawerScrimColor: Colors.transparent,
        drawer: const NavBar(),
      ),
    );
  }
}
