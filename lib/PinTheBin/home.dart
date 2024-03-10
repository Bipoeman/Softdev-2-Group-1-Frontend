import "dart:convert";
import "dart:developer";
import "package:clay_containers/widgets/clay_container.dart";
import "package:clay_containers/widgets/clay_text.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import 'package:ruam_mitt/PinTheBin/bin_drawer.dart';
import "package:ruam_mitt/PinTheBin/componant/map.dart";
import "package:http/http.dart" as http;
import "package:ruam_mitt/PinTheBin/pin_the_bin_theme.dart";
import "package:ruam_mitt/global_const.dart";
import "package:ruam_mitt/global_func.dart";
import "package:ruam_mitt/global_var.dart";

class BinLocationInfo {
  BinLocationInfo({required this.info, required this.markers});
  late List<Marker> markers;
  late List<Map<String, dynamic>> info;
}

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
  BinLocationInfo markerInfo = BinLocationInfo(info: [], markers: []);

  Future<http.Response> getBinInfo() async {
    debugPrint("Getting");
    Uri url = Uri.parse("$api$pinTheBinGetBinRoute");
    http.Response res = await http.get(
      url,
      headers: {
        "Authorization": publicToken,
      },
    );
    if (res.statusCode == 403) {
      if (context.mounted) {
        await requestNewToken(context);
        return await getBinInfo();
      }
    }
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
      List.generate(
        binData.length,
        (index) {
          // print(index);
          double lattitude = binData[index]['latitude'].toDouble();
          double longtitude = binData[index]['longitude'].toDouble();
          // print(
          //     "$lattitude $longtitude ${(lattitude > 90 || lattitude < -90)}");
          if ((lattitude < 90 && lattitude > -90) &&
              (longtitude < 180 && longtitude > -180)) {
            markerInfo.info.add(binData[index]);
          }
        },
      );
      print("Array Len : ${markerInfo.info.length}");

      Future.delayed(const Duration(milliseconds: 500))
          .then((value) => setState(() {}));
      searchBinController.addListener(searchBinListener);
      // debugPrint(markerInfo.info);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ThemeProvider themes = Provider.of<ThemeProvider>(context);
    // ThemeData pinTheBinTheme = themes.themeFrom("PinTheBin")!.themeData;
    return Theme(
      data: pinTheBinThemeData,
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
                      child: markerInfo.info.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(),
                                SizedBox(height: size.height * 0.01),
                                const Text("Bin map loading...")
                              ],
                            )
                          :
                          //  MapPinTheBin(
                          //     restroomData: restroomData,
                          //     mapController: mapController,
                          //     popupController: _popupController,
                          //     markers: markers,
                          //   ),

                          MapPinTheBin(
                              mapController: mapController,
                              binInfo: markerInfo.info,
                            ),
                    ),
                  ),
                  PinTheBinAppBar(scaffoldKey: _scaffoldKey),
                ],
              ),
              PinTheBinSearchBar(
                size: size,
                searchAnchorController: searchBinController,
                binDataList: markerInfo.info,
                focusNode: focusNode,
                parentKey: widget.key,
                onSelected: (selectedValue) {
                  log("Selected $selectedValue");
                  for (var eachBin in markerInfo.info) {
                    if (eachBin['location'] == selectedValue) {
                      log("Pin the bin");
                      setState(
                        () {
                          log("Has focus : ${focusNode.hasFocus}");
                          mapController.move(
                              LatLng(eachBin['latitude'], eachBin['longitude']),
                              16);
                        },
                      );
                    }
                  }
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

class _PinTheBinSearchBarState extends State<PinTheBinSearchBar>
    with TickerProviderStateMixin {
  List<dynamic> tempBinData = [];
  late Animation<double> animation;
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
          // viewBackgroundColor: Colors.white,
          searchController: widget.searchAnchorController,
          viewHintText: "Enter bin name...",
          viewBackgroundColor: Colors.white,
          viewLeading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          viewBuilder: (suggestions) {
            return SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: suggestions.toList(),
                ),
              ),
            );
          },
          builder: (context, searchBarController) {
            return SearchBar(
              focusNode: widget.focusNode,
              controller: searchBarController,
              hintText: "Search bin...",
              textStyle: const MaterialStatePropertyAll(
                TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
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
                  onTap: () {
                    log("Submitted by search icon focus ? ${widget.focusNode.hasFocus}");
                    widget.focusNode.unfocus();
                    debugPrint(searchBarController.text);
                  },
                )
              ],
              backgroundColor:
                  const MaterialStatePropertyAll(Color(0xFFECECEC)),
              onTap: () {
                // searchBarController.clear();

                searchBarController.openView();
              },
              onChanged: (query) {
                log("Searchbox change");
                searchBarController.openView();
              },
              onSubmitted: (value) {
                log("Submitted focus ? ${widget.focusNode.hasFocus}");
                widget.focusNode.unfocus();
                // debugPrint(searchBarController.text);
                searchBarController.clear();
                // searchBarController.closeView();
              },
            );
          },

          suggestionsBuilder: (context, suggestionController) {
            log("Suggestion query : ${suggestionController.text.length}");
            tempBinData = [];
            String queryText = suggestionController.text;
            for (var i = 0; i < widget.binDataList.length; i++) {
              if (widget.binDataList[i]['location'] != null) {
                print(widget.binDataList[i]);
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
                    log("Select some places : ${tempBinData[index]['location']} ${widget.focusNode.hasFocus}");
                    widget.onSelected(tempBinData[index]['location']);
                    Future.delayed(const Duration(milliseconds: 500))
                        .then((value) {
                      log("Selected focus ? ${widget.focusNode.hasFocus}");
                      widget.focusNode.unfocus();
                      suggestionController.clear();
                    });
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
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                tempBinData[index]['description'],
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.6),
                                    fontWeight: FontWeight.normal),
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
    Size size = MediaQuery.of(context).size;
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
              Stack(
                children: [
                  ClayContainer(
                      width: size.width * 0.7,
                      height: size.height * 0.08,
                      borderRadius: 30,
                      depth: -20,
                      color: Color(0xFFF99680),
                      surfaceColor: Color.fromARGB(116, 109, 68, 58),
                      child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.topCenter,
                            child: const ClayText(
                              'HOME',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                              emboss: true,
                              color: Color(0xFFF8A88F),
                              textColor: Color(0xFF003049),
                              depth: -100,
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: ClayText(
                              'P  I  N  T  H  E  B  I  N',
                              style: TextStyle(
                                fontSize: 13.5,
                                overflow: TextOverflow.fade,
                                fontWeight: FontWeight.normal,
                                color:
                                    const Color(0xFF003049).withOpacity(0.45),
                              ),
                              color: Color(0xFF003049),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
