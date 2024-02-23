import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:latlong2/latlong.dart";
import "package:ruam_mitt/PinTheBin/bin_drawer.dart";
import "package:ruam_mitt/global_const.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:ruam_mitt/PinTheBin/home.dart';

class MyBinPage extends StatefulWidget {
  const MyBinPage({super.key});

  @override
  State<MyBinPage> createState() => _MyBinState();
}

class _MyBinState extends State<MyBinPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic binData = [];
  SearchController searchBinController = SearchController();
  FocusNode focusNode = FocusNode();
  LatLng? centerMark;
  Future<http.Response> myBinInfo() async {
    Uri url = Uri.parse("$api$pinTheBinMyBinRoute");
    http.Response res =
        await http.get(url, headers: {"Authorization": "Bearer $publicToken"});
    print(res.body);
    return res;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Init Bin Page");
    myBinInfo().then((response) {
      print("Response");
      print(response.body);
      setState(() {
        binData = jsonDecode(response.body);
      });
      // print(binData);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ThemeProvider themes = Provider.of<ThemeProvider>(context);
    // ThemeData pinTheBinTheme = themes.themeFrom("PinTheBin")!.themeData;
    return Scrollbar(
      // thumbVisibility: true,
      thickness: 10,
      trackVisibility: true,
      radius: Radius.circular(10),
      child: Theme(
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
              color: const Color(0xFF003049).withOpacity(0.69),
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
          searchBarTheme: SearchBarThemeData(
            textStyle: MaterialStatePropertyAll(
              TextStyle(
                fontFamily: GoogleFonts.getFont("Inter").fontFamily,
                color: Colors.black,
              ),
            ),
          ),
        ),
        child: Scaffold(
          key: _scaffoldKey,
          body: Stack(children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xFFF9957F),
                    Color(0xFFE69FA1),
                    Color(0xFFF3F6D1),
                  ],
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
                      Expanded(
                          child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.23,
                            left: size.width * 0.05,
                            bottom: 20,
                          ),
                          child: Column(
                            children: binData.map<Widget>((data) {
                              return Container(
                                  width: size.width * 0.9,
                                  height: size.height * 0.27,
                                  margin: EdgeInsets.symmetric(vertical: 5.0),
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 0.6),
                                    borderRadius: BorderRadius.circular(25.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(
                                            126, 120, 120, 0.247),
                                        offset: Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Name: ${data["location"]}',
                                            style: GoogleFonts.getFont(
                                              'Sen',
                                              color:
                                                  Color.fromARGB(67, 0, 30, 49),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Type: ',
                                                  style: GoogleFonts.getFont(
                                                    'Sen',
                                                    color: Color.fromARGB(
                                                        67, 0, 30, 49),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  '${data["bintype"]["redbin"] ? "Danger\n" : ""}${data["bintype"]["greenbin"] ? "Waste\n" : ""}${data["bintype"]["yellow"] ? "Recycle\n" : ""}${data["bintype"]["bluebin"] ? "General" : ""}',
                                                  style: GoogleFonts.getFont(
                                                    'Sen',
                                                    color: Color.fromARGB(
                                                        67, 0, 30, 49),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ]),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.18),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: Image.asset(
                                                "assets/images/PinTheBin/edit_bin.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  pinthebinPageRoute[
                                                      "editbin"]!,
                                                  arguments: {
                                                    'Bininfo': '${data}',
                                                  },
                                                );
                                              },
                                            ),
                                            IconButton(
                                              iconSize: 10,
                                              icon: Image.asset(
                                                "assets/images/PinTheBin/delete_bin.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                              onPressed: () {
                                                print('Delete');
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: size.width,
                                        height: size.height,
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.05,
                                            left: size.width * 0.4),
                                        child: data["picture"] == null
                                            ? Image.asset(
                                                "assets/images/PinTheBin/test.png",
                                                // fit: BoxFit.cover,
                                                width: size.width * 0.4,
                                                // height: size.width * 0.4,
                                              )
                                            : Image.network(data["picture"]),
                                      )
                                    ],
                                  ));
                            }).toList(),
                          ),
                        ),
                      )),
                    ],
            ),
            MyPinTheBinAppBar(scaffoldKey: _scaffoldKey),
            PinTheBinSearchBar(
              size: size,
              searchAnchorController: searchBinController,
              binDataList: binData,
              focusNode: focusNode,
              parentKey: widget.key,
              onSelected: (selectedValue) {
                // print("Selected $selectedValue");
                binData.forEach((eachBin) {
                  if (eachBin['location'] == selectedValue) {
                    print("Pin the bin");

                    setState(() {
                      focusNode.unfocus();
                      // centerMark =
                      //     LatLng(eachBin['latitude'], eachBin['longitude']);
                      // mapController.move(centerMark!, 15);
                    });
                  }
                });
              },
            ),
          ]),
          drawerScrimColor: Colors.transparent,
          drawer: const BinDrawer(),
        ),
      ),
    );
  }
}

class MyPinTheBinAppBar extends StatelessWidget {
  const MyPinTheBinAppBar({
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
            Color(0xFFF99680),
            Color(0xFFF8A88F),
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
                "My Bin",
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
