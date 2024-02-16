import "package:flutter/material.dart";
import "package:ruam_mitt/TuachuayDekhor/Component/avatar.dart";
import "package:ruam_mitt/TuachuayDekhor/Component/blog_box.dart";
import "package:ruam_mitt/TuachuayDekhor/Component/navbar.dart";
import "dart:math";
import "package:ruam_mitt/global_const.dart";

class TuachuayDekhorHomePage extends StatefulWidget {
  const TuachuayDekhorHomePage({super.key});

  @override
  State<TuachuayDekhorHomePage> createState() => _TuachuayDekhorHomePageState();
}

Widget nodeCatagories(
    BuildContext context, String title, String page, String number) {
  return IntrinsicHeight(
    child: IntrinsicWidth(
      child: RawMaterialButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        constraints: const BoxConstraints(),
        onPressed: () {
          Navigator.pushNamed(context, ruamMitrPageRoute[page]!);
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                height: 55,
                width: 55,
                fit: BoxFit.cover,
                image: AssetImage(
                    "assets/images/Icon/TuachuayDekhor_Catagories_$number.png"),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _TuachuayDekhorHomePageState extends State<TuachuayDekhorHomePage> {
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
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          opacity: 0.3,
                          image: AssetImage(
                              "assets/images/Background/TuachuayDekhor_Home.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: 10,
                                height: 20,
                                color: const Color.fromRGBO(0, 48, 73, 1),
                              ),
                              const Text(
                                "Catagories",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                nodeCatagories(
                                    context, "Decoration", "profile", "1"),
                                nodeCatagories(
                                    context, "Cleaning", "profile", "2"),
                                nodeCatagories(
                                    context, "Cooking", "profile", "3"),
                                nodeCatagories(
                                    context, "Story", "profile", "4"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: 10,
                                height: 20,
                                color: const Color.fromRGBO(0, 48, 73, 1),
                              ),
                              const Text(
                                "Blogger",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 30),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Start sharing your experiences",
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: RawMaterialButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context,
                                        tuachuayDekhorPageRoute["writeblog"]!);
                                  },
                                  fillColor:
                                      const Color.fromRGBO(217, 192, 41, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                  child: const Text("GET START"),
                                ),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                const TuachuayDekhorAvatarViewer(),
                                const TuachuayDekhorAvatarViewer(),
                                const TuachuayDekhorAvatarViewer(),
                                const TuachuayDekhorAvatarViewer(),
                                const TuachuayDekhorAvatarViewer(),
                                const TuachuayDekhorAvatarViewer(),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, tuachuayDekhorPageRoute["blogger"]!);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: 10,
                                height: 20,
                                color: const Color.fromRGBO(0, 48, 73, 1),
                              ),
                              const Text(
                                "DekHor Recommended",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              children: List.generate(
                                4,
                                (index) => BlogBox(
                                  title: "Title",
                                  name: "Name",
                                  like: "Like",
                                  image: const AssetImage(
                                      "assets/images/Icon/TuachuayDekhor_Catagories_1.png"),
                                  onPressed: () {
                                    Navigator.pushNamed(context,
                                        tuachuayDekhorPageRoute['blog']!);
                                  },
                                ),
                              ),
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
