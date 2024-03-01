import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/blog_box.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TuachuayDekhorCookingPage extends StatefulWidget {
  const TuachuayDekhorCookingPage({super.key});

  @override
  State<TuachuayDekhorCookingPage> createState() => _TuachuayDekhorCookingPageState();
}

class _TuachuayDekhorCookingPageState extends State<TuachuayDekhorCookingPage> {
  final cookingurl = Uri.parse("$api$dekhorPosttocookingRoute");
  var blog_cooking = [];
  @override
  void initState() {
    super.initState();
    posttocooking();
  }

  Future<void> posttocooking() async {
    var response = await http.get(
      cookingurl,
    );
    if (response.statusCode == 200) {
      setState(() {
        blog_cooking = jsonDecode(response.body);
        print(blog_cooking);
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
                          image: AssetImage("assets/images/Background/TuachuayDekhor_Cooking.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 120,
                          ),
                          Text(
                            "COOKING",
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
                              (blog_cooking.length / 2).ceil(),
                              (index) {
                                final actualIndex = index * 2;
                                if (actualIndex < blog_cooking.length) {
                                  return BlogBox(
                                    title: blog_cooking[actualIndex]['title'],
                                    name: blog_cooking[actualIndex]['user']['fullname'],
                                    category: blog_cooking[actualIndex]['category'],
                                    like: blog_cooking[actualIndex]['save'] ?? "0",
                                    image: NetworkImage(
                                      blog_cooking[actualIndex]['image_link'] != "null"
                                          ? blog_cooking[actualIndex]['image_link']
                                          : "https://cdn-icons-png.freepik.com/512/6114/6114045.png",
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        tuachuayDekhorPageRoute['blog']!,
                                        arguments: blog_cooking[actualIndex]['id_post'],
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
                              (blog_cooking.length) ~/ 2,
                              (index) {
                                final actualIndex = index * 2 + 1;
                                if (actualIndex < blog_cooking.length) {
                                  return BlogBox(
                                    title: blog_cooking[actualIndex]['title'],
                                    name: blog_cooking[actualIndex]['user']['fullname'],
                                    category: blog_cooking[actualIndex]['category'],
                                    like: blog_cooking[actualIndex]['save'] ?? "0",
                                    image: NetworkImage(
                                      blog_cooking[actualIndex]['image_link'] != "null"
                                          ? blog_cooking[actualIndex]['image_link']
                                          : "https://cdn-icons-png.freepik.com/512/6114/6114045.png",
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        tuachuayDekhorPageRoute['blog']!,
                                        arguments: blog_cooking[actualIndex]['id_post'],
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
