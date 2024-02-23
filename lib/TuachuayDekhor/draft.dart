import 'package:flutter/material.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/blog_box.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'dart:math';

import 'package:ruam_mitt/global_const.dart';

class TuachuayDekhorDraftPage extends StatefulWidget {
  const TuachuayDekhorDraftPage({super.key});

  @override
  State<TuachuayDekhorDraftPage> createState() =>
      _TuachuayDekhorDraftPageState();
}

class _TuachuayDekhorDraftPageState extends State<TuachuayDekhorDraftPage> {
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
                    Container(
                      padding: EdgeInsets.only(top: size.width * 0.05),
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: List.generate(
                          8,
                          (index) => BlogBox(
                            title: "Title",
                            name: "Name",
                            category: "Category",
                            like: "Like",
                            image: const AssetImage(
                                "assets/images/Icon/TuachuayDekhor_Catagories_1.png"),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, tuachuayDekhorPageRoute['blog']!);
                            },
                          ),
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
