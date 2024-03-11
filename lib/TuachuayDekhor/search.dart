import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import "package:ruam_mitt/TuachuayDekhor/Component/blog_box.dart";
import "package:ruam_mitt/global_const.dart";
import "package:ruam_mitt/TuachuayDekhor/Component/avatar.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class TuachuayDekhorSearchPage extends StatefulWidget {
  const TuachuayDekhorSearchPage({super.key});

  @override
  State<TuachuayDekhorSearchPage> createState() =>
      _TuachuayDekhorSearchPageState();
}

class _TuachuayDekhorSearchPageState extends State<TuachuayDekhorSearchPage> {
  late SharedPreferences savesearchtext;
  String savesearch = '';
  bool isblog = true;
  bool isblogger = false;
  final blogurl = Uri.parse("$api$dekhorSearchBlogRoute");
  final bloggerurl = Uri.parse("$api$dekhorSearchBloggerRoute");
  var allblog = [];
  var allblogger = [];
  var blogSearch = [];
  var bloggerSearch = [];
  String searchQueryLowerCase = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    searchAllBlogger();
    searchAllBlog();
    initial();
    Future.delayed(const Duration(seconds: 1), () {
      searchData();
    });
  }

  Future<void> searchAllBlog() async {
    var response = await http.get(
      blogurl,
    );
    if (response.statusCode == 200) {
      setState(() {
        allblog = jsonDecode(response.body);
        // print(allblog);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> searchAllBlogger() async {
    var response = await http.get(
      bloggerurl,
    );
    if (response.statusCode == 200) {
      setState(() {
        allblogger = jsonDecode(response.body);
        print(allblogger);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void searchBlog(String search) {
    setState(() {
      blogSearch = allblog
          .where(
              (blog) => blog['title'].toString().toLowerCase().contains(search))
          .toList();
    });
  }

  void searchBlogger(String search) {
    setState(() {
      bloggerSearch = allblogger
          .where((blogger) => blogger['user']['fullname']
              .toString()
              .toLowerCase()
              .contains(search))
          .toList();
    });
  }

  Future<void> searchData() async {
    setState(() {
      isLoading = true;
    });
    searchBlog(searchQueryLowerCase);
    searchBlogger(searchQueryLowerCase);
    setState(() {
      isLoading = false;
    });
  }

  void initial() async {
    savesearchtext = await SharedPreferences.getInstance();
    setState(() {
      savesearch = savesearchtext.getString("searchText") ?? '';
      searchQueryLowerCase = savesearch.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CustomThemes customThemes =
        ThemesPortal.appThemeFromContext(context, "TuachuayDekhor")!;
    Map<String, Color> customColors = customThemes.customColors;

    return Scaffold(
      backgroundColor: customColors["background"],
      body: SafeArea(
        child: Stack(
          children: [
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: customColors["main"],
                    ),
                  )
                : SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: size.height -
                            [size.width * 0.4, 100.0].reduce(min) -
                            MediaQuery.of(context).padding.top,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.12,
                              left: size.width * 0.04,
                            ),
                            child: GestureDetector(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back_outlined,
                                    color: customColors["main"]!,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Back",
                                    style:
                                        TextStyle(color: customColors["main"]!),
                                  ),
                                ],
                              ),
                              onTap: () => Navigator.pop(context),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: size.width * 0.1,
                              right: size.width * 0.1,
                              top: size.width * 0.03,
                              bottom: size.width * 0.01,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Search Results',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: size.width * 0.1,
                              right: size.width * 0.1,
                              bottom: size.width * 0.05,
                            ),
                            width: size.width * 0.9,
                            height: size.width * 0.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  savesearch.isNotEmpty ? '"$savesearch"' : ' ',
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width * 0.8,
                            height: size.width * 0.03,
                            color: const Color.fromRGBO(0, 48, 73, 1),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.1,
                              right: size.width * 0.1,
                              bottom: size.width * 0.05,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isblog = true;
                                      isblogger = false;
                                    });
                                  },
                                  child: Container(
                                    width: size.width * 0.4,
                                    height: size.width * 0.1,
                                    decoration: BoxDecoration(
                                      color: isblog
                                          ? const Color.fromRGBO(0, 48, 73, 1)
                                          : const Color.fromRGBO(
                                              217, 217, 217, 1),
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Blog',
                                        style: TextStyle(
                                          color: isblog
                                              ? const Color.fromRGBO(
                                                  217, 217, 217, 1)
                                              : const Color.fromRGBO(
                                                  0, 48, 73, 1),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isblog = false;
                                      isblogger = true;
                                    });
                                  },
                                  child: Container(
                                    width: size.width * 0.4,
                                    height: size.width * 0.1,
                                    decoration: BoxDecoration(
                                      color: isblogger
                                          ? const Color.fromRGBO(0, 48, 73, 1)
                                          : const Color.fromRGBO(
                                              217, 217, 217, 1),
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Blogger',
                                        style: TextStyle(
                                          color: isblogger
                                              ? const Color.fromRGBO(
                                                  217, 217, 217, 1)
                                              : const Color.fromRGBO(
                                                  0, 48, 73, 1),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.07,
                              right: size.width * 0.07,
                              bottom: size.width * 0.05,
                              top: size.width * 0.005,
                            ),
                            child: isblog
                                ? blogSearch.isEmpty
                                    ? Center(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            top: size.width * 0.05,
                                          ),
                                          child:
                                              const Text("No results found."),
                                        ),
                                      )
                                    : MasonryGridView.builder(
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        itemCount: blogSearch.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2),
                                        itemBuilder: ((context, index) =>
                                            BlogBox(
                                              title: blogSearch[index]
                                                      ['title'] ??
                                                  '',
                                              name: blogSearch[index]['user']
                                                      ?['fullname'] ??
                                                  '',
                                              category: blogSearch[index]
                                                      ['category'] ??
                                                  '',
                                              like: blogSearch[index]['save'] ??
                                                  "0",
                                              image: NetworkImage(
                                                blogSearch[index]
                                                            ['image_link'] !=
                                                        "null"
                                                    ? blogSearch[index]
                                                        ['image_link']
                                                    : "https://cdn-icons-png.freepik.com/512/6114/6114045.png",
                                              ),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context,
                                                    tuachuayDekhorPageRoute[
                                                        'blog']!,
                                                    arguments: blogSearch[index]
                                                        ['id_post']);
                                              },
                                            )),
                                      )
                                : bloggerSearch.isEmpty
                                    ? Center(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            top: size.width * 0.05,
                                          ),
                                          child:
                                              const Text("No results found."),
                                        ),
                                      )
                                    : MasonryGridView.builder(
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        itemCount: bloggerSearch.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3),
                                        itemBuilder: ((context, index) =>
                                            TuachuayDekhorAvatarViewer(
                                              username: bloggerSearch[index]
                                                      ['user']['fullname'] ??
                                                  '',
                                              avatarUrl: bloggerSearch[index]
                                                      ['profile'] ??
                                                  "https://api.multiavatar.com/${(bloggerSearch[index]['user']['fullname']).replaceAll(" ", "+")}.png",
                                            )),
                                      ),
                          ),
                        ],
                      ),
                    ),
                  ),
            const NavbarTuachuayDekhor(),
          ],
        ),
      ),
    );
  }
}
