import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'package:flutter/services.dart';
import "package:ruam_mitt/TuachuayDekhor/Component/blog_box.dart";
import "package:ruam_mitt/global_const.dart";
import 'package:http/http.dart' as http;

class TuachuayDekhorBloggerProfilePage extends StatefulWidget {
  final String username;
  final String avatarUrl;

  const TuachuayDekhorBloggerProfilePage(
      {Key? key, required this.username, required this.avatarUrl})
      : super(key: key);

  @override
  State<TuachuayDekhorBloggerProfilePage> createState() =>
      _TuachuayDekhorBloggerProfilePageState();
}

class _TuachuayDekhorBloggerProfilePageState
    extends State<TuachuayDekhorBloggerProfilePage> {
  String? description;
  bool isEditing = false;
  bool showMore = false;
  bool isPostSelected = true;
  bool isSaveSelected = false;
  var post = [];
  var save = [];
  late String username;
  late Uri posturl;
  late Uri saveurl;

  @override
  void initState() {
    super.initState();
    username = widget.username;
    posturl = Uri.parse("$api$dekhorPosttoprofilebloggerRoute/$username");
    saveurl = Uri.parse("$api$dekhorShowSavebloggerRoute/$username");
    postoprofile();
    savepost();
    print("Username: $username");
    print("Post URL: $posturl");
    print("Save URL: $saveurl");
  }

  void updateDescription(String value) {
    setState(() {
      description = value;
    });
  }

  Future<void> postoprofile() async {
    var response = await http.get(posturl);
    if (response.statusCode == 200) {
      setState(() {
        post = jsonDecode(response.body);
        print(post);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> savepost() async {
    var response = await http.get(saveurl);
    if (response.statusCode == 200) {
      setState(() {
        save = jsonDecode(response.body);
        print(save);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final username = widget.username;

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
                                  widget.avatarUrl,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.04),
                            child: Text(
                              username,
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
                      padding: EdgeInsets.only(
                        bottom: size.width * 0.05,
                        left: size.width * 0.09,
                        right: size.width * 0.09,
                        top: size.width * 0.01,
                      ),
                      child: isPostSelected
                          ? MasonryGridView.builder(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              itemCount: post.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: ((context, index) => BlogBox(
                                    title: post[index]['title'],
                                    name: post[index]['fullname'],
                                    category: post[index]['category'],
                                    like: post[index]['save'] ?? "0",
                                    image: NetworkImage(
                                      post[index]['image_link'],
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        tuachuayDekhorPageRoute['blog']!,
                                        arguments: post[index]['id_post'],
                                      );
                                    },
                                  )),
                            )
                          : MasonryGridView.builder(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              itemCount: save.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: ((context, index) => BlogBox(
                                    title: save[index]['post']['title'],
                                    name: save[index]['fullname_blogger'],
                                    category: save[index]['post']['category'],
                                    like: save[index]['post']['save'] ?? "0",
                                    image: NetworkImage(
                                      save[index]['post']['image_link'],
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        tuachuayDekhorPageRoute['blog']!,
                                        arguments: save[index]['post']
                                            ['id_post'],
                                      );
                                    },
                                  )),
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
