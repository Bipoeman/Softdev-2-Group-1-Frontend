import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/global_var.dart';
import "package:ruam_mitt/TuachuayDekhor/Component/blog_box.dart";
import "package:ruam_mitt/global_const.dart";
import 'package:http/http.dart' as http;

class TuachuayDekhorProfilePage extends StatefulWidget {
  const TuachuayDekhorProfilePage({super.key});

  @override
  State<TuachuayDekhorProfilePage> createState() => _TuachuayDekhorProfilePageState();
}

class _TuachuayDekhorProfilePageState extends State<TuachuayDekhorProfilePage> {
  bool user = true;
  String? description;
  bool isEditing = false;
  bool showMore = false;
  bool isPostSelected = true;
  bool isSaveSelected = false;
  var post = [];
  var save = [];
  final posturl = Uri.parse("$api$dekhorPosttoprofileRoute");
  final saveurl = Uri.parse("$api$dekhorShowSaveRoute");
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDetail();
    savepost();
  }

  void updateDescription(String value) {
    setState(() {
      description = value;
    });
  }

  Future<void> posttoprofile() async {
    var response = await http.get(posturl, headers: {"Authorization": "Bearer $publicToken"});
    if (response.statusCode == 200) {
      setState(() {
        post = jsonDecode(response.body);
        // print(post);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> savepost() async {
    var response = await http.get(saveurl, headers: {"Authorization": "Bearer $publicToken"});
    if (response.statusCode == 200) {
      setState(() {
        save = jsonDecode(response.body);
        print(save);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _loadDetail() async {
    setState(() {
      isLoading = true;
    });

    await posttoprofile();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CustomThemes theme = ThemesPortal.appThemeFromContext(context, "TuachuayDekhor")!;
    Map<String, Color> customColors = theme.customColors;

    return Scaffold(
      backgroundColor: customColors["background"],
      body: SafeArea(
        child: Stack(
          children: [
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(0, 48, 73, 1),
                    ),
                  )
                : SingleChildScrollView(
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
                                    color: customColors["main"],
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
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: customColors["main"],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(
                                left: size.width * 0.37,
                                right: size.width * 0.1,
                                bottom: size.width * 0.05,
                                top: size.width * 0.005),
                            child: Text(
                              profileData['description'] ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: customColors["onContainer"],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.1,
                              right: size.width * 0.1,
                            ),
                            child: Container(
                              width: size.width * 0.8,
                              height: size.width * 0.03,
                              color: customColors["main"],
                            ),
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
                                          name: post[index]['user']['fullname'],
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
                                    itemBuilder: (context, index) => BlogBox(
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
                                          arguments: save[index]['post']['id_post'],
                                        );
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
