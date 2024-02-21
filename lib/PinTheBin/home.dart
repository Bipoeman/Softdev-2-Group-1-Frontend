import "dart:convert";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:ruam_mitt/PinTheBin/pin_the_bin_theme.dart';
import "package:ruam_mitt/PinTheBin/componant/search.dart";
import 'package:ruam_mitt/PinTheBin/bin_drawer.dart';
import "package:ruam_mitt/PinTheBin/componant/map.dart";
import "package:http/http.dart" as http;

import "package:ruam_mitt/global_const.dart";
import "package:ruam_mitt/global_var.dart";

class BinPage extends StatefulWidget {
  const BinPage({super.key});

  @override
  State<BinPage> createState() => _BinPageState();
}

class _BinPageState extends State<BinPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic binData = {};
  Future<http.Response> getBinInfo() async {
    debugPrint("Getting");
    Uri url = Uri.parse("$api$pinTheBinGetBinRoute");
    http.Response res = await http.get(
      url,
      headers: {
        "Authorization": publicToken,
      },
    );
    debugPrint(res.body);
    return res;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("Init Bin Page");
    getBinInfo().then((response) {
      // debugPrint("Response");
      // debugPrint(response.body);
      setState(() {
        binData = jsonDecode(response.body);
      });
      // debugPrint(binData);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ThemeProvider themes = Provider.of<ThemeProvider>(context);
    // ThemeData pinTheBinTheme = themes.themeFrom("PinTheBin")!.themeData;
    SearchController searchBarController = SearchController();
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
          headlineSmall: const TextStyle(
            fontSize: 30,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.w800,
            color: Color(0xFF003049),
          ),
          displayMedium: TextStyle(
            fontSize: 20,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF003049).withOpacity(0.67),
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
      child: Builder(builder: (context) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: GestureDetector(
              child: const Icon(Icons.menu_rounded),
              onTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            toolbarHeight: 100,
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
                  "Home",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: Stack(
              children: binData.isEmpty
                  ? [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            SizedBox(height: size.height * 0.01),
                            const Text("Bin map loading...")
                          ],
                        ),
                      )
                    ]
                  : [
                      // MapPinTheBin(binInfo: binData),
                      // SearchBin(
                      //   binData: binData,
                      //   searchBarController: searchBarController,
                      // ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       padding: const EdgeInsets.all(5),
                      //       width: [300.0, size.width * 0.65].reduce(min),
                      //       child: SearchBin(
                      //           binData: binData,
                      //           searchBarController: searchBarController),
                      //     ),
                      //   ],
                      // ),
                      // Positioned(
                      //   top: 10,
                      //   left: 10,
                      //   child: Center(
                      //     child: GestureDetector(
                      //       onTap: () {
                      //         _scaffoldKey.currentState?.openDrawer();
                      //       },
                      //       child: Container(
                      //         width: 40,
                      //         height: 40,
                      //         decoration: BoxDecoration(
                      //           color: const Color(0xFFF77F00),
                      //           borderRadius: BorderRadius.circular(15),
                      //         ),
                      //         child: const Icon(Icons.menu),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
            ),
          ),
          drawerScrimColor: Colors.transparent,
          drawer: const BinDrawer(),
        );
      }),
    );
  }
}
