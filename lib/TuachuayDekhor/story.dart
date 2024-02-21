import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/blog_box.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'package:ruam_mitt/global_const.dart';

class TuachuayDekhorStoryPage extends StatefulWidget {
  const TuachuayDekhorStoryPage({super.key});

  @override
  State<TuachuayDekhorStoryPage> createState() =>
      _TuachuayDekhorStoryPageState();
}

class _TuachuayDekhorStoryPageState
    extends State<TuachuayDekhorStoryPage> {
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
                              "assets/images/Background/TuachuayDekhor_Story.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 120,
                          ),
                          Text(
                            "STORY",
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
                        top: size.height * 0.02,
                        bottom: size.height * 0.025,
                      ),
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: List.generate(
                          8,
                          (index) => BlogBox(
                            title: "Title",
                            name: "Name",
                            like: "Like",
                            image: const AssetImage(
                                "assets/images/Icon/TuachuayDekhor_Catagories_4.png"),
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
