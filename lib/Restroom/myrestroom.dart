import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:latlong2/latlong.dart";
import "package:ruam_mitt/Restroom/Component/Navbar.dart";
import "package:ruam_mitt/Restroom/Component/font.dart";
import "package:ruam_mitt/Restroom/Component/theme.dart";
import "package:ruam_mitt/global_const.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:ruam_mitt/global_var.dart';

class MyRestroomPage extends StatefulWidget {
  const MyRestroomPage({super.key});

  @override
  State<MyRestroomPage> createState() => _MyRestroomState();
}

class _MyRestroomState extends State<MyRestroomPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic restroomData = [];
  dynamic restroomShow = [];
  SearchController searchRestroomController = SearchController();
  FocusNode focusNode = FocusNode();
  LatLng? centerMark;
  Future<http.Response> myRestroomInfo() async {
    Uri url = Uri.parse("$api$restroomRoverMyRestroomRoute");
    http.Response res = await http.get(url, headers: {
      "Authorization": "Bearer $publicToken"
    }).timeout(const Duration(seconds: 10));
    debugPrint(res.body);
    if (res.statusCode != 200) {
      return Future.error(
          res.reasonPhrase ?? "Failed to get restroom information.");
    }
    return res;
  }

  Future<http.Response> delRestroom(int id) async {
    Uri url = Uri.parse("$api$restroomRoverRestroomRoute/$id");
    http.Response res = await http.delete(url, headers: {
      "Authorization": "Bearer $publicToken"
    }).timeout(const Duration(seconds: 10));
    debugPrint(res.body);
    if (res.statusCode != 200) {
      return Future.error(res.reasonPhrase ?? "Failed to delete restroom");
    }
    return res;
  }

  @override
  void initState() {
    super.initState();
    debugPrint("Init Restroom Page");
    myRestroomInfo().then((response) {
      debugPrint("Response");
      debugPrint(response.body);
      setState(() {
        restroomData = jsonDecode(response.body);
        restroomShow = restroomData;
      });
      // debugPrint(restroomData);
    }).onError((error, stackTrace) {
      ThemeData theme = Theme.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Failed to get restroom information.",
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
            ),
          ),
          backgroundColor: theme.colorScheme.primary,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Scrollbar(
      // thumbVisibility: true,
      thickness: 10,
      trackVisibility: true,
      radius: const Radius.circular(10),
      child: Theme(
        data: RestroomThemeData,
        child: Scaffold(
          key: _scaffoldKey,
          body: Stack(children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xFFFFE9A6),
                    Color.fromARGB(255, 251, 183, 65),
                    Color(0xFFECECEC),
                  ],
                ),
              ),
            ),
            Column(
              children: restroomShow.isEmpty
                  ? [
                      Center(
                          heightFactor: size.height * 0.02,
                          child: Text(
                            'No Restroom Found!',
                            style: GoogleFonts.getFont(
                              'Sen',
                              color: const Color(0xFFF77F00),
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
                            children: restroomShow.map<Widget>((data) {
                              return Container(
                                  width: size.width * 0.9,
                                  height: size.height * 0.27,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 0.6),
                                    borderRadius: BorderRadius.circular(25.0),
                                    boxShadow: const [
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
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.baseline,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                                
                                                children: [
                                                  Text(
                                                    'Name: ',
                                                    style: myrestroom(data["type"], context)
                                                  ),
                                                  Text(
                                                    '${data["name"]}',
                                                    style: myrestroom(data["name"], context)
                                                  ),
                                                ]),
                                            SizedBox(
                                              height: size.height * 0.01,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.baseline,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                                children: [
                                                  Text(
                                                    'Type: ',
                                                    style: myrestroom(data["type"], context)
                                                  ),
                                                  Text(
                                                    '${data["type"]}',
                                                    style: myrestroom(data["type"], context)
                                                  ),
                                                ]),
                                          ],
                                        ),
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
                                                  restroomPageRoute[
                                                      "editrestroom"]!,
                                                  arguments: data,
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
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                        'Confirm Delete',
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Sen',
                                                          color: Colors.black,
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            'Cancel',
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Sen',
                                                              color: const Color(
                                                                  0xFF98989A),
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: TextButton(
                                                            onPressed: () {
                                                              delRestroom(data[
                                                                      "id"])
                                                                  .then(
                                                                      (value) {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                myRestroomInfo()
                                                                    .then(
                                                                        (response) {
                                                                  debugPrint(
                                                                      "Response");
                                                                  debugPrint(
                                                                      response
                                                                          .body);
                                                                  setState(() {
                                                                    restroomData =
                                                                        jsonDecode(
                                                                            response.body);
                                                                    restroomShow =
                                                                        restroomData;
                                                                  });
                                                                });
                                                              }).onError((error,
                                                                      stackTrace) {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      "Failed to delete restroom.",
                                                                      style:
                                                                          TextStyle(
                                                                        color: theme
                                                                            .colorScheme
                                                                            .onPrimary,
                                                                      ),
                                                                    ),
                                                                    backgroundColor: theme
                                                                        .colorScheme
                                                                        .primary,
                                                                  ),
                                                                );
                                                              });
                                                            },
                                                            child: Text(
                                                              'Delete',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Sen',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                         width: null,
                                                  height: size.height * 0.4,
                                          padding: EdgeInsets.only(
                                              top: size.height * 0.1,
                                              left: size.width * 0.4),
                                          child: data["picture"] == null
                                              ? 
                                              Padding(
                                                padding: const EdgeInsets.only(left: 30.0),
                                                child: Image.network(
                                                                                         
                                                                              "https://media.discordapp.net/attachments/1033741246683942932/1213677182161920020/toilet_sign.png?ex=65f657f5&is=65e3e2f5&hm=69aa24e997ae288613645b0c45363aea72cdb7d9f0cbabacbfe7a3f04d6047ea&=&format=webp&quality=lossless&width=702&height=702"),
                                              )
                                              : Expanded(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10.0),
                                                child: Image.network(
                                                  data["picture"],
                                                  
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                     
                                          )
                                    ],
                                  ));
                            }).toList(),
                          ),
                        ),
                      )),
                    ],
            ),
            RestroomAppBar(scaffoldKey: _scaffoldKey),
            MyRestroomSearchBar(
              size: size,
              searchAnchorController: searchRestroomController,
              restroomDataList: restroomData,
              focusNode: focusNode,
              parentKey: widget.key,
              search: (suggestions) {
                setState(() {
                  restroomShow =
                      (restroomData as List<dynamic>).where((restroom) {
                    for (var suggestion in suggestions) {
                      // debugPrint(
                      //     "${suggestion["name"]} == ${restroom["name"]} => ${suggestion["name"] == restroom["name"]}");
                      if (restroom['name'] == suggestion["name"]) {
                        return true;
                      }
                    }
                    return false;
                  }).toList();
                  debugPrint("Restroom Show: $restroomShow");
                });
              },
            ),
          ]),
          drawerScrimColor: Colors.transparent,
          drawer: const RestroomRoverNavbar(),
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
                "My Restroom",
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

class MyRestroomSearchBar extends StatefulWidget {
  const MyRestroomSearchBar({
    super.key,
    required this.size,
    required this.searchAnchorController,
    required this.restroomDataList,
    required this.focusNode,
    required this.search,
    this.parentKey,
  });

  final Size size;
  final SearchController searchAnchorController;
  final List<dynamic> restroomDataList;
  final FocusNode focusNode;
  final Function(dynamic suggestions) search;
  final Key? parentKey;

  @override
  State<MyRestroomSearchBar> createState() => _MyRestroomSearchBarState();
}

class _MyRestroomSearchBarState extends State<MyRestroomSearchBar>
    with TickerProviderStateMixin {
  List<dynamic> tempRestroomData = [];
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    tempRestroomData = widget.restroomDataList;
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
                    widget.focusNode.unfocus();
                    widget.search(tempRestroomData);
                    debugPrint(searchBarController.text);
                  },
                )
              ],
              backgroundColor:
                  const MaterialStatePropertyAll(Color(0xFFECECEC)),
              onTap: () {
                searchBarController.openView();
              },
              onChanged: (value) {
                searchBarController.openView();
              },
            );
          },
          suggestionsBuilder: (context, suggestionController) {
            tempRestroomData = [];
            String queryText = suggestionController.text;
            debugPrint("Query Text: $queryText");
            for (var i = 0; i < widget.restroomDataList.length; i++) {
              if (widget.restroomDataList[i]['name'] != null) {
                if (widget.restroomDataList[i]['name']
                    .toLowerCase()
                    .contains(queryText.toLowerCase())) {
                  tempRestroomData.add(widget.restroomDataList[i]);
                  // debugPrint(tempRestroomData);
                } else if (queryText == "") {
                  debugPrint("Blank Query");
                  tempRestroomData = widget.restroomDataList;
                  // debugPrint('3');
                }
              }
            }

            return List<GestureDetector>.generate(
              tempRestroomData.length,
              (int index) {
                return GestureDetector(
                  onTap: () {
                    widget.search([tempRestroomData[index]]);
                    suggestionController
                        .closeView(tempRestroomData[index]['name']);
                    widget.focusNode.unfocus();
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
                                maxLines: 1,
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
