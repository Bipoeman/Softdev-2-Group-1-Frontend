import 'package:flutter/material.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'dart:math';
import "package:ruam_mitt/TuachuayDekhor/Component/avatar.dart";

class TuachuayDekhorBloggerPage extends StatefulWidget {
  const TuachuayDekhorBloggerPage({super.key});

  @override
  State<TuachuayDekhorBloggerPage> createState() =>
      _TuachuayDekhorBloggerPageState();
}

class _TuachuayDekhorBloggerPageState extends State<TuachuayDekhorBloggerPage> {
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
                      height: size.width * 0.45,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Blogger',
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
                        top: size.width * 0.03,
                      ),
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: List.generate(
                          20,
                          (index) {
                            return TuachuayDekhorAvatarViewer(
                                username: 'pumxni');
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
