import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';

class SearchBin extends StatefulWidget {
  const SearchBin({super.key, required this.binData, this.searchBarController});
  final List<dynamic> binData;
  final SearchController? searchBarController;
  @override
  State<SearchBin> createState() => _SearchBinState();
}

class _SearchBinState extends State<SearchBin> {
  FloatingSearchBarController floatingSearchBarController =
      FloatingSearchBarController();
  final search = TextEditingController();
  List<dynamic>? tempBinData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tempBinData = widget.binData;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeProvider themes = Provider.of<ThemeProvider>(context);
    ThemeData pinTheBinTheme = themes.themeFrom("PinTheBin")!.themeData;
    return Theme(
      data: pinTheBinTheme,
      child: FloatingSearchBar(
          backgroundColor: Colors.white,
          backdropColor: Colors.white,
          controller: floatingSearchBarController,
          borderRadius: BorderRadius.circular(10),
          onFocusChanged: (isFocused) {
            if (isFocused) {
              setState(() => tempBinData = widget.binData);
            }
          },
          onQueryChanged: (query) {
            tempBinData = [];
            for (var i = 0; i < widget.binData.length; i++) {
              if (widget.binData[i]['location'] != null) {
                // print(widget.binData[i]['location'].contains(query));
                if (widget.binData[i]['location'].contains(query)) {
                  tempBinData?.add(widget.binData[i]);
                } else if (query == "") {
                  print("Blank Query");
                  tempBinData = widget.binData;
                }
              }
            }
            setState(() {});
            // print(query);
            // widget.binData.where(
            //   (element) =>
            //       element['location'] ?? "".toLowerCase().contains(query),
            // );
            // tempBinData ??
            //     [].where(
            //       (element) {
            //         debugPrint(element['location']);
            //         return element['location'] ?? "".contains(query);
            //       },
            //     ).toList();
            // print(binDataTemp);
            // print(widget.binData[0]['location'].contains(query));
            // setState(() {});
            // widget.binData.forEach((eachBinData) {
            //   if (tempBinData?.isNotEmpty ?? true) {
            //     if (eachBinData['location']
            //         .toLowerCase()
            //         .contains(eachBinData)) {}
            //   }
            // });
            // if (query){

            // }
            // print("Query Change");
            // print(query);
          },
          onSubmitted: (query) {
            // print("Submitted");
            // print(query);
            // print(
            //   floatingSearchBarController.toString(),
            // );
            // floatingSearchBarController.close();
          },
          builder: (context, transition) {
            return Column(
              children: List.generate(tempBinData?.length ?? 0, (index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print(tempBinData?[index]);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: size.height * 0.08,
                        child: Row(
                          children: [
                            const Icon(Icons.location_on),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tempBinData?[index]["location"] ??
                                      "Not Provided",
                                  style: GoogleFonts.getFont(
                                    "K2D",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  tempBinData?[index]["description"] ??
                                      "Not Provided",
                                  style: GoogleFonts.getFont(
                                    "K2D",
                                    color:
                                        const Color.fromARGB(255, 63, 63, 63),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: const Color.fromARGB(255, 136, 136, 136),
                      height: 1,
                    ),
                  ],
                );
              }),
            );
          }),
    );
    // return SearchAnchor(
    //     // viewBackgroundColor: const Color(0xFF1E1E1E),
    //     // viewSurfaceTintColor: const Color(0xFF1E1E1E),
    //     // headerTextStyle: const TextStyle(color: Colors.white),
    //     // searchController: widget.searchBarController,
    //     isFullScreen: false,
    //     viewConstraints: const BoxConstraints(
    //       minHeight: 100,
    //       maxHeight: 400,
    //     ),
    //     builder: (context, searchController) {
    //       return SearchBar(
    //         onSubmitted: (value) {
    //           print("Submitted");

    //           print(value);
    //           // searchController.closeView(value);
    //         },
    //         hintText: "Search...",
    //         onTap: () {
    //           searchController.openView();
    //         },
    //         onChanged: (_) {
    //           searchController.openView();
    //         },
    //         trailing: [
    //           Icon(Icons.search, color: pinTheBinTheme.colorScheme.primary)
    //         ],
    //         controller: searchController,
    //       );
    //     },
    //     suggestionsBuilder: (context, suggestionController) {
    //       // if (widget.binData.isNotEmpty) {
    //       //   widget.binData.forEach((element) {
    //       //     if (element["location"]) {}
    //       //   });
    //       // }
    //       return List<ListTile>.generate(widget.binData.length, (int index) {
    //         final String item = widget.binData[index]["location"] ?? "";
    //         return ListTile(
    //           title: Text(item),
    //           onTap: () {
    //             setState(() {
    //               suggestionController.closeView(item);
    //             });
    //           },
    //         );
    //       });
    //     });

    // return TextFormField(
    //   controller: search, //สร้างไว้ก่อน
    //   keyboardType: TextInputType.text,
    //   style: const TextStyle(color: Colors.white),
    //   decoration: InputDecoration(
    //     fillColor: Colors.black.withOpacity(0.5),
    //     filled: true,
    //     hintStyle: TextStyle(
    //       color: Colors.white.withOpacity(0.69),
    //       fontSize: 16,
    //     ),
    //     contentPadding: const EdgeInsets.only(left: 15),
    //     hintText: "Search...",
    //     suffixIconColor: Colors.white.withOpacity(0.69),
    //     suffixIcon: const Icon(Icons.search),
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(10),
    //       borderSide: BorderSide.none,
    //     ),
    //   ),
    // );
  }
}
