import 'package:flutter/material.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/blog_box.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'dart:math';
import 'dart:convert';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:http/http.dart' as http;


import 'package:ruam_mitt/global_const.dart';

class TuachuayDekhorDraftPage extends StatefulWidget {
  const TuachuayDekhorDraftPage({super.key});

  @override
  State<TuachuayDekhorDraftPage> createState() =>
      _TuachuayDekhorDraftPageState();
}

class _TuachuayDekhorDraftPageState extends State<TuachuayDekhorDraftPage> {
  var draft = [];
  final draftposturl  = Uri.parse("$api$dekhorPosttoDraftRoute");

  @override
  void initState() {
    super.initState();
    posttodraft();
  }

  Future<void> posttodraft() async {
    var response = await http
        .get(draftposturl, headers: {"Authorization": "Bearer $publicToken"});
    if (response.statusCode == 200) {
      setState(() {
        draft = jsonDecode(response.body);
        print(draft);
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
                        top: size.width * 0.05,
                        bottom: size.width * 0.05,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Yours Draft',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width * 0.8,
                      height: size.width * 0.02,
                      color: const Color.fromRGBO(0, 48, 73, 1),
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
                              (draft.length / 2).ceil(),
                              (index) {
                                final actualIndex = index * 2;
                                if (actualIndex < draft.length) {
                                  return BlogBox(
                                    title: draft[actualIndex]['title'],
                                    name: draft[actualIndex]['user']
                                        ['fullname'],
                                    category: draft[actualIndex]['category'],
                                    like: "null",
                                    image: NetworkImage(
                                      draft[actualIndex]['image_link'] !=
                                              "null"
                                          ? draft[actualIndex]['image_link']
                                          : "https://cdn-icons-png.freepik.com/512/6114/6114045.png",
                                    ),
                                    onPressed: () {
                                     Navigator.pushNamed(
                                        context,
                                        tuachuayDekhorPageRoute["editdraft"]!,
                                        arguments: draft[actualIndex]['id_draft'],
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
                              (draft.length) ~/ 2,
                              (index) {
                                final actualIndex = index * 2 + 1;
                                if (actualIndex < draft.length) {
                                  return BlogBox(
                                    title: draft[actualIndex]['title'],
                                    name: draft[actualIndex]['user']
                                        ['fullname'],
                                    category: draft[actualIndex]['category'],
                                    like: "null",
                                    image: NetworkImage(
                                      draft[actualIndex]['image_link'] !=
                                              "null"
                                          ? draft[actualIndex]['image_link']
                                          : "https://cdn-icons-png.freepik.com/512/6114/6114045.png",
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        tuachuayDekhorPageRoute["editdraft"]!,
                                        arguments: draft[actualIndex]['id_draft'],
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
