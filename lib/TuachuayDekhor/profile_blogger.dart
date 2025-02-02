import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:convert';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import "package:ruam_mitt/TuachuayDekhor/Component/blog_box.dart";
import "package:ruam_mitt/global_const.dart";
import 'package:http/http.dart' as http;

class TuachuayDekhorBloggerProfilePage extends StatefulWidget {
  final String username;
  final String avatarUrl;

  const TuachuayDekhorBloggerProfilePage({
    super.key,
    required this.username,
    required this.avatarUrl,
  });

  @override
  State<TuachuayDekhorBloggerProfilePage> createState() => _TuachuayDekhorBloggerProfilePageState();
}

class _TuachuayDekhorBloggerProfilePageState extends State<TuachuayDekhorBloggerProfilePage> {
  bool isEditing = false;
  bool showMore = false;
  bool isPostSelected = true;
  bool isSavedSelected = false;
  var post = [];
  var saved = [];
  var description = [];
  late String username;
  late Uri posturl;
  late Uri savedurl;
  late Uri descriptionurl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    username = widget.username;
    posturl = Uri.parse("$api$dekhorPosttoprofilebloggerRoute/$username");
    savedurl = Uri.parse("$api$dekhorShowSavebloggerRoute/$username");
    descriptionurl = Uri.parse("$api$dekhorDescriptionRoute/$username");
    searchData();
    print("Username: $username");
    print("Post URL: $posturl");
    print("Save URL: $savedurl");
  }

  Future<void> descriptionblogger() async {
    var response = await http.get(descriptionurl);
    if (response.statusCode == 200) {
      setState(() {
        description = jsonDecode(response.body);
        print(description);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> posttoprofile() async {
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

  Future<void> savedpost() async {
    var response = await http.get(savedurl);
    if (response.statusCode == 200) {
      setState(() {
        saved = jsonDecode(response.body);
        print(saved);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> searchData() async {
    setState(() {
      isLoading = true;
    });
    await posttoprofile();
    await savedpost();
    await descriptionblogger();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final username = widget.username;
    Size size = MediaQuery.of(context).size;
    CustomThemes theme = ThemesPortal.appThemeFromContext(context, "TuachuayDekhor")!;
    Map<String, Color> customColors = theme.customColors;
    ThemeProvider themeProvider = ThemesPortal.getCurrent(context);
    Map<String, Color> lightColors = themeProvider
        .appThemes[themeProvider.themeForApp["TuachuayDekhor"]!]!["light"]!.customColors;

    return Scaffold(
      backgroundColor: customColors["background"],
      body: SafeArea(
        child: Stack(
          children: [
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: customColors["main"]!,
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
                                        widget.avatarUrl,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: size.width * 0.04),
                                  child: Text(
                                    username,
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
                            child: description.isNotEmpty && description[0]['description'] != null
                                ? Text(
                                    description[0]['description'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: customColors["onContainer"],
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.1,
                              right: size.width * 0.1,
                            ),
                            child: Container(
                              width: size.width * 0.8,
                              height: size.width * 0.03,
                              color: lightColors["main"]!,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.1,
                              right: size.width * 0.1,
                              bottom: size.width * 0.05,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isPostSelected = true;
                                      isSavedSelected = false;
                                    });
                                  },
                                  child: Container(
                                    width: size.width * 0.4,
                                    height: size.width * 0.1,
                                    decoration: BoxDecoration(
                                      color: isPostSelected
                                          ? lightColors["main"]!
                                          : customColors["backgroundEnd"]!,
                                      borderRadius: BorderRadius.circular(2.0),
                                      boxShadow: isPostSelected
                                          ? [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.2),
                                                blurRadius: 5,
                                                offset: const Offset(0, 3),
                                              ),
                                            ]
                                          : [],
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Post',
                                        style: TextStyle(
                                          color: isPostSelected
                                              ? lightColors["onMain"]!
                                              : customColors["onContainer"]!.withOpacity(0.6),
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
                                      isSavedSelected = true;
                                    });
                                  },
                                  child: Container(
                                    width: size.width * 0.4,
                                    height: size.width * 0.1,
                                    decoration: BoxDecoration(
                                      color: isSavedSelected
                                          ? lightColors["main"]!
                                          : customColors["backgroundEnd"]!,
                                      borderRadius: BorderRadius.circular(2.0),
                                      boxShadow: isSavedSelected
                                          ? [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.2),
                                                blurRadius: 5,
                                                offset: const Offset(0, 3),
                                              ),
                                            ]
                                          : [],
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Saved',
                                        style: TextStyle(
                                          color: isSavedSelected
                                              ? lightColors["onMain"]!
                                              : customColors["onContainer"]!.withOpacity(0.6),
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
                              left: size.width * 0.07,
                              right: size.width * 0.07,
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
                                    itemCount: saved.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    itemBuilder: (context, index) => BlogBox(
                                      title: saved[index]['post']['title'],
                                      name: saved[index]['fullname_blogger'],
                                      category: saved[index]['post']['category'],
                                      like: saved[index]['post']['save'] ?? "0",
                                      image: NetworkImage(
                                        saved[index]['post']['image_link'],
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          tuachuayDekhorPageRoute['blog']!,
                                          arguments: saved[index]['post']['id_post'],
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
