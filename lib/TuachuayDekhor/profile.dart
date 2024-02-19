import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'package:flutter/services.dart';
import 'package:ruam_mitt/global_var.dart';
import "package:ruam_mitt/TuachuayDekhor/Component/blog_box.dart";
import "package:ruam_mitt/global_const.dart";

class TuachuayDekhorProfilePage extends StatefulWidget {
  const TuachuayDekhorProfilePage({Key? key}) : super(key: key);

  @override
  State<TuachuayDekhorProfilePage> createState() =>
      _TuachuayDekhorProfilePageState();
}

class _TuachuayDekhorProfilePageState extends State<TuachuayDekhorProfilePage> {
  bool user = true;
  String? description;
  bool isEditing = false;
  bool showMore = false;
  bool isPostSelected = true;
  bool isSaveSelected = false;

  @override
  void initState() {
    super.initState();
  }

  void updateDescription(String value) {
    setState(() {
      description = value;
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
                      margin: EdgeInsets.only(
                        top: size.width * 0.05,
                      ),
                      width: size.width * 0.85,
                      height: size.width * 0.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width * 0.25,
                            height: size.width * 0.25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color.fromRGBO(0, 48, 73, 1),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  profileData['profile'] ??
                                      "https://api.multiavatar.com/${profileData['fullname'] ?? "John Doe".replaceAll(" ", "+")}.png",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.04),
                            child: Text(
                              profileData['fullname'] ?? '',
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.3,
                          right: size.width * 0.1,
                          bottom: size.width * 0.05,
                          top: size.width * 0.005),
                      child: const Text('can\'t edit other\'s description'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.1,
                        right: size.width * 0.1,
                      ),
                      child: Container(
                          width: size.width * 0.8,
                          height: size.width * 0.03,
                          color: const Color.fromRGBO(0, 48, 73, 1)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.1,
                          right: size.width * 0.1,
                          bottom: size.width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isPostSelected = true;
                                isSaveSelected = false;
                              });
                            },
                            child: Container(
                              width: size.width * 0.4,
                              height: size.width * 0.1,
                              decoration: BoxDecoration(
                                color: isPostSelected
                                    ? const Color.fromRGBO(0, 48, 73, 1)
                                    : const Color.fromRGBO(217, 217, 217, 1),
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              child: Center(
                                child: Text(
                                  'Post',
                                  style: TextStyle(
                                    color: isPostSelected
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
                                isPostSelected = false;
                                isSaveSelected = true;
                              });
                            },
                            child: Container(
                              width: size.width * 0.4,
                              height: size.width * 0.1,
                              decoration: BoxDecoration(
                                color: isSaveSelected
                                    ? const Color.fromRGBO(0, 48, 73, 1)
                                    : const Color.fromRGBO(217, 217, 217, 1),
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              child: Center(
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    color: isSaveSelected
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
                      padding: EdgeInsets.only(bottom: size.width * 0.05),
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: List.generate(
                          14,
                          (index) {
                            if (isPostSelected) {
                              // สร้าง BlogBox สำหรับโพส
                              return BlogBox(
                                title: 'Post Title $index',
                                name: 'Post Name $index',
                                like: 'Post Like $index',
                                image: const AssetImage(
                                    "assets/images/Icon/TuachuayDekhor_Catagories_1.png"),
                                onPressed: () {
                                  Navigator.pushNamed(context,
                                      tuachuayDekhorPageRoute['blog']!);
                                },
                              );
                            } else if (isSaveSelected) {
                              // สร้าง BlogBox สำหรับการบันทึก
                              return BlogBox(
                                title: 'Saved Title $index',
                                name: 'Saved Name $index',
                                like: 'Saved Like $index',
                                image: const AssetImage(
                                    "assets/images/Icon/TuachuayDekhor_Catagories_1.png"),
                                onPressed: () {
                                  // ใส่โค้ดที่ต้องการเมื่อคลิก "blog box" สำหรับ Save ที่นี่
                                },
                              );
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
