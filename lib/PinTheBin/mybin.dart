import "dart:convert";
import "package:clay_containers/widgets/clay_container.dart";
import "package:clay_containers/widgets/clay_text.dart";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:latlong2/latlong.dart";
import "package:ruam_mitt/PinTheBin/componant/loading.dart";
import "package:ruam_mitt/PinTheBin/bin_drawer.dart";
import "package:ruam_mitt/global_const.dart";
import 'package:ruam_mitt/PinTheBin/pin_the_bin_theme.dart';
import 'package:ruam_mitt/global_var.dart';

class MyBinPage extends StatefulWidget {
  const MyBinPage({super.key});

  @override
  State<MyBinPage> createState() => _MyBinState();
}

class _MyBinState extends State<MyBinPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic binData = [];
  dynamic binShow = [];
  bool isLoading = true;
  SearchController searchBinController = SearchController();
  FocusNode focusNode = FocusNode();
  LatLng? centerMark;

  void myBinInfo() async {
    setState((){
      isLoading = true;
    });
    Uri url = Uri.parse("$api$pinTheBinMyBinRoute");
    var res = await http.get(url, headers: {"Authorization": "Bearer $publicToken"});
    print(res.body);
    if (res.statusCode == 200) {
      setState(() {
        binData = jsonDecode(res.body);
        binShow = binData;
        print(binShow);
      });
    } else {
      print("Error");
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<http.Response> delBin(int id) async {
    Uri url = Uri.parse("$api$pinTheBinDeleteBinRoute/$id");
    return await http.delete(url,
        headers: {"Authorization": "Bearer $publicToken"}).timeout(const Duration(seconds: 10));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Init Bin Page");
    myBinInfo();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scrollbar(
      // thumbVisibility: true,
      thickness: 10,
      trackVisibility: true,
      radius: const Radius.circular(10),
      child: Theme(
        data: pinTheBinThemeData,
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
            isLoading ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ) :
            Column(
              children: binShow.isEmpty
                  ? [
                      Center(
                          heightFactor: size.height * 0.015,
                          child: Text(
                            'No Bin Found!',
                            style: TextStyle(
                              fontSize: Theme.of(context).textTheme.displayMedium!.fontSize,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF77F00),
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
                            children: binShow.map<Widget>((data) {
                              return Container(
                                  width: size.width * 0.9,
                                  height: size.height * 0.27,
                                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(255, 255, 255, 0.6),
                                    borderRadius: BorderRadius.circular(25.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(126, 120, 120, 0.247),
                                        offset: Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.baseline,
                                            textBaseline: TextBaseline.alphabetic,
                                            children: [
                                              const Text(
                                                'Name: ',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  height: 1.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(0, 30, 49, 67),
                                                ),
                                              ),
                                              Text(
                                                '${data["location"]}',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    height: 1.0,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color.fromRGBO(0, 30, 49, 67)),
                                              ),
                                            ],
                                          ),
                                          Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Type: ',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color.fromRGBO(0, 30, 49, 67),
                                                  ),
                                                ),
                                                Text(
                                                  '${data["bintype"]["redbin"] ? "Danger\n" : ""}${data["bintype"]["greenbin"] ? "Waste\n" : ""}${data["bintype"]["yellowbin"] ? "Recycle\n" : ""}${data["bintype"]["bluebin"] ? "General" : ""}',
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color.fromRGBO(0, 30, 49, 67),
                                                  ),
                                                ),
                                              ]),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.bottomLeft,
                                        padding: EdgeInsets.only(top: size.height * 0.18),
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
                                                  pinthebinPageRoute["editbin"]!,
                                                  arguments: {
                                                    'Bininfo': data,
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
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                        'Confirm Delete',
                                                        style: TextStyle(
                                                          fontSize: 25,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius: BorderRadius.circular(10),
                                                          ),
                                                          child: TextButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: const Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.w400,
                                                                  color: Colors.white),
                                                            ),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            showLoadingScreen(context);
                                                            delBin(data["id"]).then((response) {
                                                              ScaffoldMessenger.of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: const Text(
                                                                    "Delete bin successful.",
                                                                    style: TextStyle(
                                                                      color: Colors.black,
                                                                    ),
                                                                  ),
                                                                  backgroundColor:
                                                                      Colors.green[300],
                                                                ),
                                                              );
                                                              Navigator.pushReplacementNamed(
                                                                  context,
                                                                  pinthebinPageRoute[
                                                                      "mybin"]!);
                                                            }).onError((error,
                                                                    stackTrace) {
                                                              Navigator.pushReplacementNamed(
                                                                  context,
                                                                  pinthebinPageRoute[
                                                                      "mybin"]!);
                                                              debugPrint(error
                                                                  .toString());
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                const SnackBar(
                                                                  content: Text(
                                                                    "Delete bin failed.",
                                                                    style: TextStyle(
                                                                      color: Colors.black,
                                                                    ),
                                                                  ),
                                                                  backgroundColor: Colors.red,
                                                                ),
                                                              );
                                                              Navigator.pop(context);
                                                            });
                                                          },
                                                          child: const Text(
                                                            'Delete',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w400,
                                                                color: Colors.black54),
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
                                        width: size.width,
                                        height: size.height,
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.05, left: size.width * 0.4),
                                        child: data["picture"] == null
                                            ? Image.asset(
                                                "assets/images/PinTheBin/bin_null.png",
                                                width: size.width * 0.4,
                                                height: size.width * 0.4,
                                              )
                                            : Image.network(
                                                data["picture"],
                                                width: size.width * 0.4,
                                                height: size.width * 0.4,
                                              ),
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
            MyBinSearchBar(
              size: size,
              searchAnchorController: searchBinController,
              binDataList: binData,
              focusNode: focusNode,
              parentKey: widget.key,
              onSelected: (selectedValue) {
                binData.forEach((eachBin) {
                  if (eachBin['location'] == selectedValue) {
                    binShow = [eachBin];
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
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 130,
      decoration: const BoxDecoration(
        borderRadius:
            BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
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
                              'MY BIN',
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
                                color: const Color(0xFF003049).withOpacity(0.45),
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

class MyBinSearchBar extends StatefulWidget {
  const MyBinSearchBar({
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
  State<MyBinSearchBar> createState() => _MyBinSearchBarState();
}

class _MyBinSearchBarState extends State<MyBinSearchBar> with TickerProviderStateMixin {
  List<dynamic> tempBinData = [];
  late Animation<double> animation;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) => tempBinData = widget.binDataList);
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
              textStyle: MaterialStatePropertyAll(
                TextStyle(
                  fontFamily: Theme.of(context).textTheme.headlineMedium!.fontFamily,
                  fontSize: 18,
                  fontWeight: Theme.of(context).textTheme.displayMedium!.fontWeight,
                ),
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
                    child: Image.asset("assets/images/PinTheBin/search_icon.png"),
                  ),
                  onTap: () {
                    widget.focusNode.unfocus();
                    debugPrint(searchBarController.text);
                  },
                )
              ],
              backgroundColor: const MaterialStatePropertyAll(Color(0xFFECECEC)),
              onTap: () {
                searchBarController.openView();
              },
              onChanged: (query) {
                searchBarController.openView();
              },
              onSubmitted: (value) {
                widget.focusNode.unfocus();
                searchBarController.clear();
              },
            );
          },
          suggestionsBuilder: (context, suggestionController) {
            tempBinData = [];
            String queryText = suggestionController.text;
            for (var i = 0; i < widget.binDataList.length; i++) {
              if (widget.binDataList[i]['location'] != null) {
                if (widget.binDataList[i]['location']
                    .toLowerCase()
                    .contains(queryText.toLowerCase())) {
                  tempBinData.add(widget.binDataList[i]);
                  // print(tempBinData);
                } else if (queryText == "") {
                  debugPrint("Blank Query");
                  tempBinData = widget.binDataList;
                  // print('3');
                }
              }
            }
            return List<GestureDetector>.generate(
              tempBinData.length,
              (int index) {
                return GestureDetector(
                  onTap: () {
                    widget.onSelected(tempBinData[index]['location']);
                    Future.delayed(const Duration(milliseconds: 500)).then((value) {
                      widget.focusNode.unfocus();
                      // suggestionController.clear();
                    });
                    suggestionController.closeView(tempBinData[index]['location']);
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
                                      Theme.of(context).textTheme.headlineMedium!.fontFamily,
                                  fontSize: 16,
                                  fontWeight: Theme.of(context).textTheme.displayMedium!.fontWeight,
                                ),
                              ),
                              Text(
                                tempBinData[index]['description'],
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily:
                                      Theme.of(context).textTheme.headlineMedium!.fontFamily,
                                  fontSize: 16,
                                  fontWeight: Theme.of(context).textTheme.displayMedium!.fontWeight,
                                ),
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
