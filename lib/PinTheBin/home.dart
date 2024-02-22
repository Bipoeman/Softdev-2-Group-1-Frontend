import "dart:convert";
import "dart:developer";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:google_fonts/google_fonts.dart";
import "package:latlong2/latlong.dart";
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
  SearchController searchBinController = SearchController();
  MapController mapController = MapController();
  List<dynamic> binData = [];
  FocusNode focusNode = FocusNode();
  LatLng? centerMark;
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

  void searchBinListener() {
    debugPrint("Sonething chagne in search field ${searchBinController.text}");
    // debugPrint();

    setState(() {});
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
      searchBinController.addListener(searchBinListener);
      // debugPrint(binData);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ThemeProvider themes = Provider.of<ThemeProvider>(context);
    // ThemeData pinTheBinTheme = themes.themeFrom("PinTheBin")!.themeData;
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
      child: Builder(builder: (context) {
        return Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 100),
                    child: Center(
                      child: binData.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(),
                                SizedBox(height: size.height * 0.01),
                                const Text("Bin map loading...")
                              ],
                            )
                          : MapPinTheBin(
                              mapController: mapController,
                              binInfo: binData,
                              centerMark: centerMark,
                            ),
                    ),
                  ),
                  PinTheBinAppBar(scaffoldKey: _scaffoldKey),
                ],
              ),
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
                        centerMark =
                            LatLng(eachBin['latitude'], eachBin['longitude']);
                        mapController.move(centerMark!, 15);
                      });
                    }
                  });
                },
              ),
            ],
          ),
          drawerScrimColor: Colors.transparent,
          drawer: const BinDrawer(),
        );
      }),
    );
  }
}

class PinTheBinSearchBar extends StatefulWidget {
  const PinTheBinSearchBar({
    super.key,
    required this.size,
    required this.searchAnchorController,
    required this.binDataList,
    required this.focusNode,
    required this.onSelected,
    this.parentKey,
  });

  final Size size;
  final SearchController searchAnchorController;
  final List<dynamic> binDataList;
  final FocusNode focusNode;
  final Function(dynamic selectedValue) onSelected;
  final Key? parentKey;

  @override
  State<PinTheBinSearchBar> createState() => _PinTheBinSearchBarState();
}

class _PinTheBinSearchBarState extends State<PinTheBinSearchBar> {
  List<dynamic> tempBinData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 1))
        .then((value) => tempBinData = widget.binDataList);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.center,
        width: widget.size.width,
        height: 60,
        child: SearchAnchor(
          viewBackgroundColor: Theme.of(context).colorScheme.background,
          searchController: widget.searchAnchorController,
          builder: (context, searchBarController) {
            return SearchBar(
              focusNode: widget.focusNode,
              controller: searchBarController,
              hintText: "Search bin...",
              textStyle: MaterialStatePropertyAll(
                TextStyle(
                    fontFamily: searchBarController.text.contains(
                      RegExp("[ก-๛]"),
                    )
                        ? "THSarabunPSK"
                        : Theme.of(context).textTheme.labelMedium!.fontFamily,
                    fontSize: searchBarController.text.contains(
                      RegExp("[ก-๛]"),
                    )
                        ? 22
                        : 18,
                    fontWeight: searchBarController.text.contains(
                      RegExp("[ก-๛]"),
                    )
                        ? FontWeight.w700
                        : FontWeight.normal),
              ),
              padding: const MaterialStatePropertyAll(
                EdgeInsets.only(left: 15, right: 6),
              ),
              trailing: [
                GestureDetector(
                  child: Container(
                    width: 45,
                    height: 45,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
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
                    child:
                        Image.asset("assets/images/PinTheBin/search_icon.png"),
                  ),
                  onTap: () {},
                )
              ],
              backgroundColor:
                  const MaterialStatePropertyAll(Color(0xFFECECEC)),
              onTap: () {
                searchBarController.openView();
              },
              onChanged: (query) {
                debugPrint("Searchbox change");
                searchBarController.openView();
              },
              onSubmitted: (value) {
                log("Submitted");
                debugPrint(searchBarController.text);
                // searchBarController.closeView();
              },
            );
          },
          suggestionsBuilder: (context, suggestionController) {
            debugPrint("Suggestion query : ${suggestionController.text}");
            tempBinData = [];
            String queryText = suggestionController.text;
            for (var i = 0; i < widget.binDataList.length; i++) {
              if (widget.binDataList[i]['location'] != null) {
                // print(tempBinData[i]['location'].contains(query));
                if (widget.binDataList[i]['location']
                    .toLowerCase()
                    .contains(queryText.toLowerCase())) {
                  tempBinData.add(widget.binDataList[i]);
                  print(tempBinData);
                } else if (queryText == "") {
                  debugPrint("Blank Query");
                  tempBinData = widget.binDataList;
                }
              }
            }
            return List<GestureDetector>.generate(
              tempBinData.length,
              (int index) {
                return GestureDetector(
                  onTap: () {
                    widget.onSelected(suggestionController.text);
                    suggestionController
                        .closeView(tempBinData[index]['location']);
                  },
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    width: widget.size.width,
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, size: 30),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tempBinData[index]['location'],
                                style: TextStyle(
                                    fontFamily:
                                        tempBinData[index]['location'].contains(
                                      RegExp("[ก-๛]"),
                                    )
                                            ? "THSarabunPSK"
                                            : Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .fontFamily,
                                    fontSize: tempBinData[index]['description']
                                            .contains(
                                      RegExp("[ก-๛]"),
                                    )
                                        ? 24
                                        : 16,
                                    fontWeight: tempBinData[index]
                                                ['description']
                                            .contains(
                                      RegExp("[ก-๛]"),
                                    )
                                        ? FontWeight.w700
                                        : FontWeight.normal),
                              ),
                              Text(
                                tempBinData[index]['description'],
                                style: TextStyle(
                                    fontFamily: tempBinData[index]
                                                ['description']
                                            .contains(
                                      RegExp("[ก-๛]"),
                                    )
                                        ? "THSarabunPSK"
                                        : Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .fontFamily,
                                    fontSize: tempBinData[index]['description']
                                            .contains(
                                      RegExp("[ก-๛]"),
                                    )
                                        ? 22
                                        : 16,
                                    color: Colors.black.withOpacity(0.6),
                                    fontWeight: tempBinData[index]
                                                ['description']
                                            .contains(
                                      RegExp("[ก-๛]"),
                                    )
                                        ? FontWeight.w700
                                        : FontWeight.normal),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                color: Colors.black.withOpacity(0.5),
                                height: 1,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class PinTheBinAppBar extends StatelessWidget {
  const PinTheBinAppBar({
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
                "Home",
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
