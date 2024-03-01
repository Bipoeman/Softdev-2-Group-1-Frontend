import "package:flutter/material.dart";
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";
import "package:ruam_mitt/TuachuayDekhor/Component/avatar.dart";
import "package:ruam_mitt/TuachuayDekhor/Component/blog_box.dart";
import "package:ruam_mitt/TuachuayDekhor/Component/navbar.dart";
import "dart:math";
import "package:ruam_mitt/global_const.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

import "package:ruam_mitt/global_var.dart";

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
          Navigator.pushNamed(context, tuachuayDekhorPageRoute[page]!);
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
  var blogger = [];
  var blog = [];
  final bloggerurl = Uri.parse("$api$dekhorSearchBloggerRoute");
  final randomurl = Uri.parse("$api$dekhorRandomPostRoute");

  @override
  void initState() {
    super.initState();
    showblogger();
    randompost();
  }

  Future<void> showblogger() async {
    var response = await http.get(
      bloggerurl,
    );
    if (response.statusCode == 200) {
      setState(() {
        blogger = jsonDecode(response.body);
        print(blogger);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> randompost() async {
    var response = await http.get(
      randomurl,
    );
    debugPrint("Status Returned for randompost() ${response.statusCode}");
    if (response.statusCode == 200) {
      setState(() {
        blog = jsonDecode(response.body);
        debugPrint("body Returned for randompost() ${response.body}");
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
            RefreshIndicator(
              displacement: 100,
              color: const Color.fromRGBO(0, 48, 73, 1),
              onRefresh: randompost,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  nodeCatagories(
                                      context, "Decoration", "decoration", "1"),
                                  nodeCatagories(
                                      context, "Cleaning", "cleaning", "2"),
                                  nodeCatagories(
                                      context, "Cooking", "cooking", "3"),
                                  nodeCatagories(
                                      context, "Story", "story", "4"),
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            profileData['role'] == "User"
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: RawMaterialButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context,
                                                tuachuayDekhorPageRoute[
                                                    "writeblog"]!);
                                          },
                                          fillColor: const Color.fromRGBO(
                                              217, 192, 41, 1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                  )
                                : const SizedBox(
                                    height: 10,
                                  ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...List.generate(
                                    blogger.length > 6 ? 6 : blogger.length,
                                    (index) => TuachuayDekhorAvatarViewer(
                                      username: blogger[index]['user']
                                          ['fullname'],
                                      avatarUrl: blogger[index]['profile'] ??
                                          "https://api.multiavatar.com/${blogger[index]['user']['fullname'].replaceAll(" ", "+")}.png",
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        tuachuayDekhorPageRoute["blogger"]!,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      backgroundColor: Colors.grey[300],
                                      surfaceTintColor: Colors.white,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: Color.fromRGBO(0, 48, 73, 1),
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: MasonryGridView.builder(
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                itemCount: blog.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: ((context, index) => BlogBox(
                                      title: blog[index]['title'],
                                      name: blog[index]['user']['fullname'],
                                      category: blog[index]['category'],
                                      like: blog[index]['save'] ?? "0",
                                      image: NetworkImage(
                                        blog[index]['image_link'],
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          tuachuayDekhorPageRoute['blog']!,
                                          arguments: blog[index]['id_post'],
                                        );
                                      },
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
