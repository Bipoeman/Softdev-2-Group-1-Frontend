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
      binData = jsonDecode(response.body);
      Future.delayed(const Duration(milliseconds: 500))
          .then((value) => setState(() {}));
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
        return Stack(
          children: [
            Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                leading: GestureDetector(
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.menu_rounded), SizedBox(height: 30)],
                  ),
                  onTap: () => _scaffoldKey.currentState?.openDrawer(),
                ),
                toolbarHeight: 120,
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
                    const SizedBox(height: 30)
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
                          Positioned(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              alignment: Alignment.center,
                              width: size.width,
                              height: 60,
                              child: SearchBar(
                                controller: searchBarController,
                                hintText: "Search bin...",
                                padding: const MaterialStatePropertyAll(
                                  EdgeInsets.only(left: 15, right: 6),
                                ),
                                trailing: [
                                  Container(
                                    width: 45,
                                    height: 45,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 4),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: Colors.black.withOpacity(0.3),
                                          offset: const Offset(0, 2),
                                        )
                                      ],
                                      color: const Color(0xFFF9957F),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                        "assets/images/PinTheBin/search_icon.png"),
                                  )
                                ],
                                backgroundColor:
                                    MaterialStatePropertyAll(Color(0xFFECECEC)),
                                onChanged: (value) {
                                  debugPrint("Bin Search Change to $value");
                                },
                              ),
                            ),
                          ),
                          // MapPinTheBin(binInfo: binData),
                          // Positioned(
                          //   child: SearchBin(
                          //     binData: binData,
                          //     searchBarController: searchBarController,
                          //   ),
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
                          //
                          // height: 40,
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
            ),
          ],
        );
      }),
    );
  }
}
