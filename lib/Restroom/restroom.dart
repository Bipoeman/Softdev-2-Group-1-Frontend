import "dart:convert";
import "dart:developer";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:ruam_mitt/Restroom/Component/Navbar.dart";
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
  SearchController searchRestroomController = SearchController();
  MapController mapController = MapController();
  List<dynamic> restroomData = [];
  FocusNode focusNode = FocusNode();
  LatLng? centerMark;
  Future<http.Response> getRestroomInfo() async {
    debugPrint("Getting Info");
    Uri url = Uri.parse("$api$restroomRoverGetRestroomRoute");
    http.Response res = await http.get(
      url,
      headers: {
        "Authorization": publicToken,
      },
    );
    return res;
  }

  Future<http.Response> getRestroomReview() async {
    debugPrint("Getting Review");
    Uri url = Uri.parse("$api$restroomRoverGetReviewRoute");
    http.Response res = await http.get(
      url,
      headers: {
        "Authorization": publicToken,
      },
    );
    return res;
  }

  @override
  void initState() {
    debugPrint("Init Restroom Page");
    Future.wait([getRestroomInfo(), getRestroomReview()]).then((res) {
      var decoded = res
          .map<List<dynamic>>((response) => jsonDecode(response.body))
          .toList();

      // Combine datas
      restroomData = decoded[0].map((info) {
        var founded = decoded[1].singleWhere(
            (review) => review["id"] == info["id"],
            orElse: () => null);
        if (founded != null) {
          info.addEntries(founded.entries);
        }
        return info;
      }).toList();

      print(restroomData);
      setState(() {});
    }).onError((error, stackTrace) {
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
    ;
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
                      restroomData: restroomData, mapController: mapController),
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
                  // print("Selected $selectedValue");
                  restroomData.forEach((eachRestroom) {
                    if (eachRestroom['name'] == selectedValue) {
                      setState(() {
                        focusNode.unfocus();
                        centerMark = LatLng(eachRestroom['latitude'],
                            eachRestroom['longitude']);
                        mapController.move(centerMark!, 15);
                      });
                    }
                  });
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
  List<dynamic> tempBinData = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1))
        .then((value) => tempBinData = widget.restroomDataList);
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
            for (var i = 0; i < widget.restroomDataList.length; i++) {
              if (widget.restroomDataList[i]['name'] != null) {
                // print(tempBinData[i]['location'].contains(query));
                if (widget.restroomDataList[i]['name']
                    .toLowerCase()
                    .contains(queryText.toLowerCase())) {
                  tempBinData.add(widget.restroomDataList[i]);
                  print(tempBinData);
                } else if (queryText == "") {
                  debugPrint("Blank Query");
                  tempBinData = widget.restroomDataList;
                }
              }
            }
            return List<GestureDetector>.generate(
              tempBinData.length,
              (int index) {
                return GestureDetector(
                  onTap: () {
                    widget.onSelected(suggestionController.text);
                    suggestionController.closeView(tempBinData[index]['name']);
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
                                tempBinData[index]['name'],
                                style: TextStyle(
                                    fontFamily:
                                        tempBinData[index]['name'].contains(
                                      RegExp("[ก-๛]"),
                                    )
                                            ? "THSarabunPSK"
                                            : Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .fontFamily,
                                    fontSize:
                                        tempBinData[index]['name'].contains(
                                      RegExp("[ก-๛]"),
                                    )
                                            ? 24
                                            : 16,
                                    fontWeight:
                                        tempBinData[index]['name'].contains(
                                      RegExp("[ก-๛]"),
                                    )
                                            ? FontWeight.w700
                                            : FontWeight.normal),
                              ),
                              Text(
                                tempBinData[index]['address'],
                                style: TextStyle(
                                    fontFamily:
                                        tempBinData[index]['address'].contains(
                                      RegExp("[ก-๛]"),
                                    )
                                            ? "THSarabunPSK"
                                            : Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .fontFamily,
                                    fontSize:
                                        tempBinData[index]['address'].contains(
                                      RegExp("[ก-๛]"),
                                    )
                                            ? 22
                                            : 16,
                                    color: Colors.black.withOpacity(0.6),
                                    fontWeight:
                                        tempBinData[index]['address'].contains(
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
