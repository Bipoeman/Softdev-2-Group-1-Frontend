import "dart:convert";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_map_marker_popup/flutter_map_marker_popup.dart";
import "package:latlong2/latlong.dart";
import "package:ruam_mitt/Restroom/Component/Navbar.dart";
import "package:ruam_mitt/Restroom/Component/loading_screen.dart";
import 'package:ruam_mitt/Restroom/Component/map.dart';
import "package:http/http.dart" as http;
import "package:ruam_mitt/Restroom/Component/theme.dart";
import "package:ruam_mitt/global_const.dart";
import "package:ruam_mitt/global_var.dart";

class RestroomRover extends StatefulWidget {
  const RestroomRover({super.key});

  @override
  State<RestroomRover> createState() => _RestroomRoverState();
}

class _RestroomRoverState extends State<RestroomRover> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final MapController _mapController = MapController();
  final PopupController _popupController = PopupController();
  SearchController searchRestroomController = SearchController();
  List<dynamic> restroomData = [];
  List<Marker> markers = [];
  FocusNode focusNode = FocusNode();
  Future<http.Response> getRestroomInfo() async {
    debugPrint("Getting Info");
    Uri url = Uri.parse("$api$restroomRoverRestroomRoute");
    http.Response res = await http.get(
      url,
      headers: {
        "Authorization": publicToken,
      },
    );
    if (res.statusCode != 200) {
      return Future.error(
          res.reasonPhrase ?? "Failed to get restroom information.");
    }
    return res;
  }

  Future<http.Response> getRestroomReview() async {
    debugPrint("Getting Review");
    Uri url = Uri.parse("$api$restroomRoverReviewRoute");
    http.Response res = await http.get(
      url,
      headers: {
        "Authorization": publicToken,
      },
    );
    if (res.statusCode != 200) {
      return Future.error(
          res.reasonPhrase ?? "Failed to get review information.");
    }
    return res;
  }

  @override
  void initState() {
    debugPrint("Init Restroom Page");
    showRestroomLoadingScreen(context);
    Future.wait([getRestroomInfo(), getRestroomReview()])
        .timeout(const Duration(seconds: 10))
        .then((res) {
      var decoded = res
          .map<List<dynamic>>((response) => jsonDecode(response.body))
          .toList();

      // Combine datas
      setState(() {
        restroomData = decoded[0].map((info) {
          var founded = decoded[1].singleWhere(
              (review) => review["id"] == info["id"],
              orElse: () => null);
          if (founded != null) {
            info.addEntries(founded.entries);
          }
          return info;
        }).toList();
        markers = restroomData.map((restroom) {
          return Marker(
            point: LatLng(
              restroom["latitude"].toDouble(),
              restroom["longitude"].toDouble(),
            ),
            width: 50,
            height: 50,
            rotate: true,
            child: RestroomMarker(restroomData: restroom),
          );
        }).toList();
      });
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      ThemeData theme = Theme.of(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Failed to fetch data",
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
          ),
        ),
        backgroundColor: theme.colorScheme.primary,
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Theme(
      data: RestroomThemeData,
      child: Builder(builder: (context) {
        return Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: [
              Stack(
                children: [
                  MapRestroomRover(
                    restroomData: restroomData,
                    mapController: _mapController,
                    popupController: _popupController,
                    markers: markers,
                  ),
                  RestroomAppBar(scaffoldKey: _scaffoldKey),
                ],
              ),
              RestroomRoverSearchBar(
                size: size,
                searchAnchorController: searchRestroomController,
                restroomDataList: restroomData,
                focusNode: focusNode,
                parentKey: widget.key,
                onSelected: (selectedValue) {
                  for (Marker restroom in markers) {
                    debugPrint("Selected Value : $selectedValue");
                    Map<String, dynamic> data =
                        (restroom.child as RestroomMarker).restroomData;
                    if (data['name'] == selectedValue) {
                      setState(() {
                        LatLng centerMark = restroom.point;
                        _mapController.move(centerMark, 15);
                        _popupController.showPopupsOnlyFor([restroom]);
                      });
                    }
                  }
                },
              ),
            ],
          ),
          drawerScrimColor: Colors.transparent,
          drawer: const RestroomRoverNavbar(),
        );
      }),
    );
  }
}

class RestroomRoverSearchBar extends StatefulWidget {
  const RestroomRoverSearchBar({
    super.key,
    required this.size,
    required this.searchAnchorController,
    required this.restroomDataList,
    required this.focusNode,
    required this.onSelected,
    this.parentKey,
  });

  final Size size;
  final SearchController searchAnchorController;
  final List<dynamic> restroomDataList;
  final FocusNode focusNode;
  final Function(dynamic selectedValue) onSelected;
  final Key? parentKey;

  @override
  State<RestroomRoverSearchBar> createState() => _RestroomRoverSearchBarState();
}

class _RestroomRoverSearchBarState extends State<RestroomRoverSearchBar> {
  List<dynamic> tempRestroomData = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      tempRestroomData = widget.restroomDataList;
    });
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
              hintText: "Search restroom...",
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
                      color: const Color(0xFFFFB330),
                      shape: BoxShape.circle,
                    ),
                    child:
                        Image.asset("assets/images/PinTheBin/search_icon.png"),
                  ),
                  onTap: () {
                    widget.onSelected(searchBarController.text);
                  },
                )
              ],
              backgroundColor:
                  const MaterialStatePropertyAll(Color(0xFFECECEC)),
              onTap: () {
                searchBarController.openView();
              },
              onChanged: (query) {
                searchBarController.openView();
              },
            );
          },
          suggestionsBuilder: (context, suggestionController) {
            debugPrint("Suggestion query : ${suggestionController.text}");
            tempRestroomData = [];
            String queryText = suggestionController.text;
            for (var i = 0; i < widget.restroomDataList.length; i++) {
              if (widget.restroomDataList[i]['name'] != null) {
                if (widget.restroomDataList[i]['name']
                    .toLowerCase()
                    .contains(queryText.toLowerCase())) {
                  tempRestroomData.add(widget.restroomDataList[i]);
                  debugPrint(tempRestroomData.toString());
                } else if (queryText == "") {
                  debugPrint("Blank Query");
                  tempRestroomData = widget.restroomDataList;
                }
              }
            }
            return List<GestureDetector>.generate(
              tempRestroomData.length,
              (int index) {
                return GestureDetector(
                  onTap: () {
                    widget.onSelected(tempRestroomData[index]['name']);
                    suggestionController
                        .closeView(tempRestroomData[index]['name']);
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
                                tempRestroomData[index]['name'],
                                style: TextStyle(
                                    fontFamily: tempRestroomData[index]['name']
                                            .contains(
                                      RegExp("[ก-๛]"),
                                    )
                                        ? "THSarabunPSK"
                                        : Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .fontFamily,
                                    fontSize: tempRestroomData[index]['name']
                                            .contains(
                                      RegExp("[ก-๛]"),
                                    )
                                        ? 24
                                        : 16,
                                    fontWeight: tempRestroomData[index]['name']
                                            .contains(
                                      RegExp("[ก-๛]"),
                                    )
                                        ? FontWeight.w700
                                        : FontWeight.normal),
                              ),
                              Text(
                                tempRestroomData[index]['address'],
                                style: TextStyle(
                                    fontFamily: tempRestroomData[index]
                                                ['address']
                                            .contains(
                                      RegExp("[ก-๛]"),
                                    )
                                        ? "THSarabunPSK"
                                        : Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .fontFamily,
                                    fontSize: tempRestroomData[index]['address']
                                            .contains(
                                      RegExp("[ก-๛]"),
                                    )
                                        ? 22
                                        : 16,
                                    color: Colors.black.withOpacity(0.6),
                                    fontWeight: tempRestroomData[index]
                                                ['address']
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

class RestroomAppBar extends StatelessWidget {
  const RestroomAppBar({
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
            Color(0xFFFFB330),
            Color(0xFFFFE9A6),
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

class RestroomMarker extends StatelessWidget {
  const RestroomMarker({super.key, required this.restroomData});
  final dynamic restroomData;

  @override
  Widget build(BuildContext context) {
    String type = restroomData["type"];
    return type == "Must Paid"
        ? Image.asset(
            restroomPinImg[type]!,
          )
        : Image.asset(
            restroomPinImg[type]!,
            width: type == "Toilet In Stores" ? 50 : 50,
            height: type == "Toilet In Stores" ? 50 : 50,
            scale: type == "Toilet In Stores"
                ? 5.0
                : 5.15, // ปรับ scale สำหรับ "Free" ให้มีขนาดเท่ากับ "Toilet In Stores"
          );
  }
}
