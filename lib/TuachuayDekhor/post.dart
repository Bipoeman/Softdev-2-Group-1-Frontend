import 'package:bottom_bar_matu/components/colors.dart';
import "package:comment_box/comment/comment.dart";
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:ruam_mitt/TuachuayDekhor/Component/navbar.dart";
import 'package:ruam_mitt/global_var.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import "package:ruam_mitt/global_const.dart";

class TuachuayDekhorBlogPage extends StatefulWidget {
  final int id_post;
  const TuachuayDekhorBlogPage({super.key, required this.id_post});

  @override
  State<TuachuayDekhorBlogPage> createState() => _TuachuayDekhorBlogPageState();
}

class _TuachuayDekhorBlogPageState extends State<TuachuayDekhorBlogPage> {
  bool isOwner = false;
  TextEditingController commentTextController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  late int id_post;
  var detailpost = [];
  var commentpost = [];
  var countsavepost = [];
  late Uri detailurl;
  late Uri showcommenturl;
  late Uri saveposturl;
  late Uri unsaveurl;
  late Uri countsaveurl;
  late Uri numsaveurl;
  bool isLoading = false;
  final commenturl = Uri.parse("$api$dekhorCommentPostRoute");
  late bool isSave;

  @override
  void initState() {
    super.initState();
    id_post = widget.id_post;
    detailurl = Uri.parse("$api$dekhorDetailPostRoute/$id_post");
    showcommenturl = Uri.parse("$api$dekhorShowcommentPostRoute/$id_post");
    saveposturl = Uri.parse("$api$dekhorSavePostRoute/$id_post");
    unsaveurl = Uri.parse("$api$dekhorUnsavePostRoute/$id_post");
    countsaveurl = Uri.parse("$api$dekhorCountsavePostRoute/$id_post");
    numsaveurl = Uri.parse("$api$dekhorNumsavePostRoute/$id_post");
    _loadDetail();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        showcomment();
      });
    });
    countsave();
    checkSaveStatus();
  }

  void checkSaveStatus() {
    setState(() {
      isSave = countsavepost
          .any((element) => element['id_user'] == profileData['id']);
    });
  }

  void checkuser() {
    if (profileData['fullname'] == detailpost[0]['user']['fullname']) {
      setState(() {
        isOwner = true;
      });
    }
  }

  Future<void> numsave() async {
    var response = await http.patch(numsaveurl,
        body: {'save': (countsavepost.length + 1).toString()});
    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> delnumsave() async {
    var response = await http.patch(numsaveurl,
        body: {'save': (countsavepost.length - 1).toString()});
    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> countsave() async {
    var response = await http.get(countsaveurl);
    if (response.statusCode == 200) {
      setState(() {
        countsavepost = jsonDecode(response.body);
        print("contsave: $countsavepost");
        checkSaveStatus();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> onPressedSaveButton() async {
    if (isSave) {
      await unsave();
    } else {
      await savepost();
    }
    await countsave();
    checkSaveStatus();
  }

  Future<void> savepost() async {
    await http.post(saveposturl, headers: {
      "Authorization": "Bearer $publicToken"
    }, body: {
      'fullname': profileData['fullname'],
      'fullname_blogger': detailpost[0]['user']['fullname']
    });
  }

  Future<void> unsave() async {
    await http
        .delete(unsaveurl, headers: {"Authorization": "Bearer $publicToken"});
  }

  Future<void> showcomment() async {
    var response = await http.get(showcommenturl);
    if (response.statusCode == 200) {
      setState(() {
        commentpost = jsonDecode(response.body);
        print(detailpost);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> detail() async {
    var response = await http.get(detailurl);
    if (response.statusCode == 200) {
      setState(() {
        detailpost = jsonDecode(response.body);
        print(detailpost);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> comment() async {
    var response = await http.post(commenturl, headers: {
      "Authorization": "Bearer $publicToken"
    }, body: {
      "id_post": id_post.toString(),
      "comment": commentTextController.text,
    });
    if (response.statusCode == 200) {
      commentTextController.clear();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _loadDetail() async {
    setState(() {
      isLoading = true;
    });

    await detail();
    setState(() {
      isLoading = false;
    });
    checkuser();
    print(detailpost);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CommentBox(
                    userImage: NetworkImage(
                      profileData['profile'] ??
                          "https://api.multiavatar.com/${profileData['fullname']}.png",
                    ),
                    labelText: 'Write a comment...',
                    errorText: 'Comment cannot be blank',
                    withBorder: false,
                    formKey: formkey,
                    commentController: commentTextController,
                    backgroundColor: const Color.fromRGBO(0, 48, 73, 1),
                    textColor: Colors.white,
                    sendWidget: IconButton(
                      icon:
                          Icon(Icons.send_sharp, size: 25, color: Colors.white),
                      onPressed: () {
                        comment();
                        showcomment();
                      },
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: size.width * 0.04,
                            right: size.width * 0.04,
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
                              SizedBox(height: size.height * 0.02),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: size.width * 0.05,
                                  right: size.width * 0.05,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    "https://api.multiavatar.com/${detailpost[0]['user']['fullname']}.png",
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: size.width * 0.04),
                                            Text(detailpost.isNotEmpty
                                                ? detailpost[0]['user']
                                                    ['fullname']
                                                : ''),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            isOwner
                                                ? SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child: RawMaterialButton(
                                                      fillColor: Colors.blue,
                                                      constraints:
                                                          const BoxConstraints(
                                                        minHeight: 30,
                                                        minWidth: 30,
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      onPressed: () {
                                                        print("edit the blog");
                                                      },
                                                      child: const Icon(
                                                          Icons.edit_outlined,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                : Container(),
                                            SizedBox(width: size.width * 0.02),
                                            !isOwner
                                                ? SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child: RawMaterialButton(
                                                      fillColor:
                                                          const Color.fromRGBO(
                                                              217, 192, 41, 1),
                                                      constraints:
                                                          const BoxConstraints(
                                                        minHeight: 30,
                                                        minWidth: 30,
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      onPressed: () {
                                                        print(
                                                            "report the blog");
                                                      },
                                                      child: const Icon(
                                                          Icons.report_outlined,
                                                          color: Colors.black),
                                                    ),
                                                  )
                                                : SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child: RawMaterialButton(
                                                      fillColor: Colors.red,
                                                      constraints:
                                                          const BoxConstraints(
                                                        minHeight: 30,
                                                        minWidth: 30,
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      onPressed: () {
                                                        print(
                                                            "delete the blog");
                                                      },
                                                      child: const Icon(
                                                          Icons.delete_outlined,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          constraints: const BoxConstraints(
                                              maxHeight: 200),
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(),
                                          child: IntrinsicHeight(
                                            child: ClipRRect(
                                              child: Image(
                                                image: NetworkImage(
                                                  detailpost.isNotEmpty &&
                                                          detailpost[0][
                                                                  'image_link'] !=
                                                              "null"
                                                      ? detailpost[0]
                                                          ['image_link']
                                                      : "https://cdn-icons-png.freepik.com/512/6114/6114045.png",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.02,
                                        ),
                                        Row(
                                          children: [
                                            isSave
                                                ? GestureDetector(
                                                    onTap: () {
                                                      onPressedSaveButton();
                                                      delnumsave();
                                                    },
                                                    child: const Icon(
                                                        Icons.bookmark,
                                                        color: colorYellow),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      onPressedSaveButton();
                                                      numsave();
                                                    },
                                                    child: const Icon(
                                                        Icons.bookmark_outline),
                                                  ),
                                            SizedBox(width: size.width * 0.01),
                                            Text("${countsavepost.length}")
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      child: Markdown(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        data: detailpost.isNotEmpty
                                            ? detailpost[0]['content']
                                            : '',
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.02),
                                    Row(
                                      children: [
                                        const Icon(
                                            Icons.insert_comment_outlined),
                                        SizedBox(width: size.width * 0.02),
                                        Text("${commentpost.length} Comments")
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: size.height * 0.02,
                                        bottom: size.height * 0.02,
                                      ),
                                      child: Column(
                                        children: List.generate(
                                            commentpost.length, (index) {
                                          return ListTile(
                                            onTap: () {},
                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                "https://api.multiavatar.com/${commentpost[index]['user']['fullname']}.png",
                                              ),
                                            ),
                                            title: Text(commentpost[index]
                                                ['user']['fullname']),
                                            dense: true,
                                            subtitle: Text(
                                                commentpost[index]['comment']),
                                            visualDensity:
                                                VisualDensity(vertical: -3),
                                          );
                                        }),
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
                  ),
            const NavbarTuachuayDekhor(),
          ],
        ),
      ),
    );
  }
}
