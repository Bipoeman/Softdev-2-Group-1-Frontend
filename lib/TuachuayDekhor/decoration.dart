import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/blog_box.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TuachuayDekhorDecorationPage extends StatefulWidget {
  const TuachuayDekhorDecorationPage({super.key});

  @override
  State<TuachuayDekhorDecorationPage> createState() =>
      _TuachuayDekhorDecorationPageState();
}

class _TuachuayDekhorDecorationPageState
    extends State<TuachuayDekhorDecorationPage> {
  final decurl = Uri.parse("$api$dekhorPosttodecorationRoute");
  var blog_dec = [];
  @override
  void initState() {
    super.initState();
    posttodecoration();
  }

  Future<void> posttodecoration() async {
    var response = await http.get(
      decurl,
    );
    if (response.statusCode == 200) {
      setState(() {
        blog_dec = jsonDecode(response.body);
        print(blog_dec);
      });
    } else {
      throw Exception('Failed to load data');
    }
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
                              "assets/images/Background/TuachuayDekhor_Decoration.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 120,
                          ),
                          Text(
                            "DECORATION",
                            style: TextStyle(
                              fontSize: 30,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: const Color.fromRGBO(0, 48, 73, 1),
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
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
                              (blog_dec.length / 2).ceil(),
                              (index) {
                                final actualIndex = index * 2;
                                if (actualIndex < blog_dec.length) {
                                  return BlogBox(
                                    title: blog_dec[actualIndex]['title'],
                                    name: blog_dec[actualIndex]['user']
                                        ['fullname'],
                                    category: blog_dec[actualIndex]['category'],
                                    like: 'null',
                                    image: NetworkImage(
                                      blog_dec[actualIndex]['image_link'] !=
                                              "null"
                                          ? blog_dec[actualIndex]['image_link']
                                          : "https://cdn-icons-png.freepik.com/512/6114/6114045.png",
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        tuachuayDekhorPageRoute['blog']!,
                                        arguments: blog_dec[actualIndex]['id_post'],
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
                              (blog_dec.length) ~/ 2,
                              (index) {
                                final actualIndex = index * 2 + 1;
                                if (actualIndex < blog_dec.length) {
                                  return BlogBox(
                                    title: blog_dec[actualIndex]['title'],
                                    name: blog_dec[actualIndex]['user']
                                        ['fullname'],
                                    category: blog_dec[actualIndex]['category'],
                                    like: 'null',
                                    image: NetworkImage(
                                      blog_dec[actualIndex]['image_link'] !=
                                              "null"
                                          ? blog_dec[actualIndex]['image_link']
                                          : "https://cdn-icons-png.freepik.com/512/6114/6114045.png",
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        tuachuayDekhorPageRoute['blog']!,
                                        arguments: blog_dec[actualIndex]['id_post'],
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
