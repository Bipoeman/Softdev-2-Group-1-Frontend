import 'package:flutter/material.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import "package:ruam_mitt/TuachuayDekhor/Component/blog_box.dart";
import "package:ruam_mitt/global_const.dart";
import "package:ruam_mitt/TuachuayDekhor/Component/avatar.dart";

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

  @override
  void initState() {
    super.initState();
    initial();
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
                    Container(
                      padding: EdgeInsets.only(
                        left: size.width * 0.1,
                        right: size.width * 0.1,
                        top: size.width * 0.25,
                        bottom: size.width * 0.01,
                      ),
                      height: size.width * 0.35,
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
                          bottom: size.width * 0.1),
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
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: List.generate(
                          10,
                          (index) {
                            if (isblog) {
                              // สร้าง BlogBox สำหรับโพส
                              return BlogBox(
                                title: 't $index',
                                name: 't $index',
                                like: 't $index',
                                image: const AssetImage(
                                    "assets/images/Icon/TuachuayDekhor_Catagories_1.png"),
                                onPressed: () {
                                  Navigator.pushNamed(context,
                                      tuachuayDekhorPageRoute['blog']!);
                                },
                              );
                            } else if (isblogger) {
                              // สร้าง BlogBox สำหรับการบันทึก
                              return TuachuayDekhorAvatarViewer(
                                  username: 'pumxni');
                            } else {
                              // ในกรณีที่ทั้งสองตัวแปรนี้เป็น `false` ไม่มี BlogBox ไหนแสดงผล
                              return SizedBox.shrink();
                            }
                          },
                        ),
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
