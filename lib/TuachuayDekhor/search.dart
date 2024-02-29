import 'package:flutter/material.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
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

  @override
  void initState() {
    super.initState();
    searchblogger();
    searchblog();
    initial();
  }

  Future<void> searchblog() async {
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

  Future<void> searchblogger() async {
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

  void initial() async {
    savesearchtext = await SharedPreferences.getInstance();
    setState(() {
      savesearch = savesearchtext.getString("searchText") ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
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
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_back_outlined),
                            SizedBox(width: 5),
                            Text("Back")
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
                                    : const Color.fromRGBO(217, 217, 217, 1),
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              child: Center(
                                child: Text(
                                  'Blog',
                                  style: TextStyle(
                                    color: isblog
                                        ? const Color.fromRGBO(217, 217, 217, 1)
                                        : const Color.fromRGBO(0, 48, 73, 1),
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
                                    : const Color.fromRGBO(217, 217, 217, 1),
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              child: Center(
                                child: Text(
                                  'Blogger',
                                  style: TextStyle(
                                    color: isblogger
                                        ? const Color.fromRGBO(217, 217, 217, 1)
                                        : const Color.fromRGBO(0, 48, 73, 1),
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
                        left: size.width * 0.09,
                        right: size.width * 0.09,
                        bottom: size.width * 0.05,
                        top: size.width * 0.005,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // แสดงข้อมูลในคอลัมน์แรก
                          Wrap(
                            direction: Axis.vertical,
                            spacing: 5,
                            children: List.generate(
                              (isblog ? allblog.length : allblogger.length)~/ 2
                                  ,
                              (index) {
                                final actualIndex = index * 2 + 1;
                                if (actualIndex <
                                    (isblog
                                        ? allblog.length
                                        : allblogger.length)) {
                                  final blog =
                                      isblog ? allblog[actualIndex] : {};
                                  final blogger =
                                      isblogger ? allblogger[actualIndex] : {};
                                  final blogTitle =
                                      blog['title']?.toString().toLowerCase() ??
                                          '';
                                  final bloggerName = (blogger['user'] !=
                                              null &&
                                          blogger['user']['fullname'] != null)
                                      ? blogger['user']['fullname']
                                          .toString()
                                          .toLowerCase()
                                      : '';
                                  final searchQueryLowerCase =
                                      savesearch.toLowerCase();
                                  if (blogTitle
                                          .contains(searchQueryLowerCase) ||
                                      bloggerName
                                          .contains(searchQueryLowerCase)) {
                                    if (isblog) {
                                      return BlogBox(
                                        title: blog['title'] ?? '',
                                        name: blog['user']?['fullname'] ?? '',
                                        category: blog['category'] ?? '',
                                        like: blog['save'] ?? "0",
                                        image: NetworkImage(
                                          blog['image_link'] != "null"
                                              ? blog['image_link']
                                              : "https://cdn-icons-png.freepik.com/512/6114/6114045.png",
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            tuachuayDekhorPageRoute['blog']!,
                                            arguments: blog['id_post'],
                                          );
                                        },
                                      );
                                    } else if (isblogger) {
                                      print(blogger);
                                      return TuachuayDekhorAvatarViewer(
                                        username:
                                            blogger['user']['fullname'] ?? '',
                                        avatarUrl: blogger['profile']  ??
                                            "https://api.multiavatar.com/${(blogger['user']['fullname']).replaceAll(" ", "+")}.png",
                                      );
                                    }
                                  }
                                }
                                // ถ้าไม่มีข้อมูลที่ตรงกับเงื่อนไข ให้ return SizedBox.shrink() เพื่อไม่แสดงอะไรบนหน้าจอ
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                          // แสดงข้อมูลในคอลัมน์ที่สอง
                          Wrap(
                            direction: Axis.vertical,
                            spacing: 5,
                            children: List.generate(
                              ((isblog ? allblog.length : allblogger.length) /
                                      2)
                                  .ceil(),
                              (index) {
                                final actualIndex = index * 2 ;
                                if (actualIndex <
                                    (isblog
                                        ? allblog.length
                                        : allblogger.length)) {
                                  final blog =
                                      isblog ? allblog[actualIndex] : {};
                                  final blogger =
                                      isblogger ? allblogger[actualIndex] : {};
                                  final blogTitle =
                                      blog['title']?.toString().toLowerCase() ??
                                          '';
                                  final bloggerName = (blogger['user'] !=
                                              null &&
                                          blogger['user']['fullname'] != null)
                                      ? blogger['user']['fullname']
                                          .toString()
                                          .toLowerCase()
                                      : '';
                                  final searchQueryLowerCase =
                                      savesearch.toLowerCase();
                                  if (blogTitle
                                          .contains(searchQueryLowerCase) ||
                                      bloggerName
                                          .contains(searchQueryLowerCase)) {
                                    if (isblog) {
                                      return BlogBox(
                                        title: blog['title'] ?? '',
                                        name: blog['user']?['fullname'] ?? '',
                                        category: blog['category'] ?? '',
                                        like: blog['save'] ?? "0",
                                        image: NetworkImage(
                                          blog['image_link'] != "null"
                                              ? blog['image_link']
                                              : "https://cdn-icons-png.freepik.com/512/6114/6114045.png",
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              tuachuayDekhorPageRoute['blog']!,
                                              arguments: blog['id_post']);
                                        },
                                      );
                                    } else if (isblogger) {
                                      print(blogger);
                                      return TuachuayDekhorAvatarViewer(
                                        username:
                                            blogger['user']['fullname'] ?? '',
                                        avatarUrl:blogger['profile']  ??
                                            "https://api.multiavatar.com/${(blogger['user']['fullname']).replaceAll(" ", "+")}.png",
                                      );
                                    }
                                  }
                                }
                                // ถ้าไม่มีข้อมูลที่ตรงกับเงื่อนไข ให้ return SizedBox.shrink() เพื่อไม่แสดงอะไรบนหน้าจอ
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                        ],
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
