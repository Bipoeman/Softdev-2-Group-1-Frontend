import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/blog_box.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TuachuayDekhorCleaningPage extends StatefulWidget {
  const TuachuayDekhorCleaningPage({super.key});

  @override
  State<TuachuayDekhorCleaningPage> createState() => _TuachuayDekhorCleaningPageState();
}

class _TuachuayDekhorCleaningPageState extends State<TuachuayDekhorCleaningPage> {
  final cleaningurl = Uri.parse("$api$dekhorPosttocleaningRoute");
  var blog_clean = [];

  @override
  void initState() {
    super.initState();
    posttocleaning();
  }

  Future<void> posttocleaning() async {
    var response = await http.get(
      cleaningurl,
    );
    if (response.statusCode == 200) {
      setState(() {
        blog_clean = jsonDecode(response.body);
        print(blog_clean);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CustomThemes theme = ThemesPortal.appThemeFromContext(context, "TuachuayDekhor")!;
    Map<String, Color> customColors = theme.customColors;

    return Scaffold(
      backgroundColor: customColors["background"]!,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: size.height -
                        [size.width * 0.4, 100.0].reduce(min) -
                        MediaQuery.of(context).padding.top),
                child: Column(
                  children: [
                    Container(
                      height: 235,
                      width: size.width,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          opacity: 0.3,
                          image: AssetImage(
                            "assets/images/Background/TuachuayDekhor_Cleaning.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 120,
                          ),
                          Text(
                            "CLEANING",
                            style: TextStyle(
                              fontSize: 30,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: customColors["onContainer"]!.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: customColors["main"]!,
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
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
                              style: TextStyle(color: customColors["main"]!),
                            ),
                          ],
                        ),
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: size.width * 0.05,
                          left: size.width * 0.04,
                          right: size.width * 0.04,
                          top: size.width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            direction: Axis.vertical,
                            spacing: 5,
                            children: List.generate(
                              (blog_clean.length / 2).ceil(),
                              (index) {
                                final actualIndex = index * 2;
                                if (actualIndex < blog_clean.length) {
                                  return BlogBox(
                                    title: blog_clean[actualIndex]['title'],
                                    name: blog_clean[actualIndex]['user']['fullname'],
                                    category: blog_clean[actualIndex]['category'],
                                    like: blog_clean[actualIndex]['save'] ?? "0",
                                    image: NetworkImage(
                                      blog_clean[actualIndex]['image_link'] != "null"
                                          ? blog_clean[actualIndex]['image_link']
                                          : "https://cdn-icons-png.freepik.com/512/6114/6114045.png",
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        tuachuayDekhorPageRoute['blog']!,
                                        arguments: blog_clean[actualIndex]['id_post'],
                                      );
                                    },
                                  );
                                } else {
                                  return const SizedBox(); // แสดง SizedBox ถ้าข้อมูลไม่เพียงพอ
                                }
                              },
                            ),
                          ),
                          Wrap(
                            direction: Axis.vertical,
                            spacing: 5,
                            children: List.generate(
                              (blog_clean.length) ~/ 2,
                              (index) {
                                final actualIndex = index * 2 + 1;
                                if (actualIndex < blog_clean.length) {
                                  return BlogBox(
                                    title: blog_clean[actualIndex]['title'],
                                    name: blog_clean[actualIndex]['user']['fullname'],
                                    category: blog_clean[actualIndex]['category'],
                                    like: blog_clean[actualIndex]['save'] ?? "0",
                                    image: NetworkImage(
                                      blog_clean[actualIndex]['image_link'] != "null"
                                          ? blog_clean[actualIndex]['image_link']
                                          : "https://cdn-icons-png.freepik.com/512/6114/6114045.png",
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        tuachuayDekhorPageRoute['blog']!,
                                        arguments: blog_clean[actualIndex]['id_post'],
                                      );
                                    },
                                  );
                                } else {
                                  return const SizedBox(); // แสดง SizedBox ถ้าข้อมูลไม่เพียงพอ
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    )
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
