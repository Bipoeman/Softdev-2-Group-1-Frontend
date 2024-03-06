import "package:comment_box/comment/comment.dart";
import "package:flutter/material.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:ruam_mitt/TuachuayDekhor/Component/navbar.dart";
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
  var post = [];
  late Uri detailurl;
  late Uri showcommenturl;
  late Uri saveposturl;
  late Uri unsaveurl;
  late Uri countsaveurl;
  late Uri numsaveurl;
  late Uri deleteposturl;
  bool isLoading = false;
  bool isLoadingComment = false;
  final commenturl = Uri.parse("$api$dekhorCommentPostRoute");
  final posturl = Uri.parse("$api$dekhorPosttoprofileRoute");
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
    deleteposturl = Uri.parse("$api$dekhorDeletePostRoute/$id_post");
    _loadDetail();
    Future.delayed(const Duration(seconds: 1), () {
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

  Future<void> posttoprofile() async {
    var response = await http
        .get(posturl, headers: {"Authorization": "Bearer $publicToken"});
    if (response.statusCode == 200) {
      setState(() {
        post = jsonDecode(response.body);
        // print(post);
      });
    } else {
      throw Exception('Failed to load data');
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

  Future<void> deletepost() async {
    await http.delete(deleteposturl);
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
      showcomment();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _loadDetail() async {
    setState(() {
      isLoading = true;
    });
    await posttoprofile();
    await detail();
    setState(() {
      isLoading = false;
    });
    checkuser();
    print(detailpost);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<dynamic> popUpAlertDialog(Widget icon, String title, Color color,
      String button, void Function()? onPressed) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        CustomThemes theme =
            ThemesPortal.appThemeFromContext(context, "TuachuayDekhor")!;
        Map<String, Color> customColors = theme.customColors;
        return AlertDialog(
          surfaceTintColor: customColors["container"],
          backgroundColor: customColors["container"],
          iconColor: customColors["main"],
          icon: icon,
          title: Text(
            title,
            style: TextStyle(
              color: customColors["onContainer"]!,
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color,
              ),
              child: TextButton(
                onPressed: onPressed,
                child: Text(
                  button,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CustomThemes theme =
        ThemesPortal.appThemeFromContext(context, "TuachuayDekhor")!;
    Map<String, Color> customColors = theme.customColors;
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
                : CommentBox(
                    userImage: NetworkImage(profileData['imgPath']),
                    labelText: 'Write a comment...',
                    errorText: 'Comment cannot be blank',
                    withBorder: false,
                    formKey: formkey,
                    commentController: commentTextController,
                    backgroundColor: customColors["main"],
                    textColor: customColors["onMain"],
                    sendWidget: IconButton(
                      icon: Icon(
                        Icons.send_sharp,
                        size: 25,
                        color: customColors["onMain"],
                      ),
                      onPressed: () {
                        if (commentTextController.text.isNotEmpty) {
                          FocusScope.of(context).unfocus();
                          comment();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: customColors["main"],
                              content: Text(
                                "Comment cannot be blank",
                                style: TextStyle(
                                  color: customColors["onMain"]!,
                                ),
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
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
                                        style: TextStyle(
                                            color: customColors["main"]!),
                                      ),
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
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              tuachuayDekhorPageRoute[
                                                  "profileblogger"]!,
                                              arguments: {
                                                'username': detailpost[0]
                                                    ['user']['fullname'],
                                                'avatarUrl': detailpost[0]
                                                        ['user']['profile'] ??
                                                    "https://api.multiavatar.com/${detailpost[0]['user']['fullname']}.png",
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      detailpost[0]['user']
                                                              ['profile'] ??
                                                          "https://api.multiavatar.com/${detailpost[0]['user']['fullname']}.png",
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  width: size.width * 0.04),
                                              Text(
                                                detailpost.isNotEmpty
                                                    ? detailpost[0]['user']
                                                        ['fullname']
                                                    : '',
                                                style: TextStyle(
                                                  color: customColors[
                                                      "onContainer"],
                                                ),
                                              ),
                                            ],
                                          ),
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
                                                        popUpAlertDialog(
                                                          const Icon(Icons.edit,
                                                              size: 50),
                                                          "Edit post?",
                                                          Colors.blue,
                                                          "Edit",
                                                          () {
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pushNamed(
                                                              context,
                                                              tuachuayDekhorPageRoute[
                                                                  "editpost"]!,
                                                              arguments:
                                                                  id_post,
                                                            );
                                                          },
                                                        );
                                                        print("edit the blog");
                                                      },
                                                      child: Icon(
                                                        Icons.edit_outlined,
                                                        color: customColors[
                                                            "onMain"],
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                            SizedBox(width: size.width * 0.02),
                                            (!isOwner &&
                                                    profileData['role'] !=
                                                        "Admin")
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
                                                        popUpAlertDialog(
                                                            Icon(
                                                              Icons.report,
                                                              size: 50,
                                                              color: customColors[
                                                                  "onContainer"],
                                                            ),
                                                            "Report post?",
                                                            const Color
                                                                .fromRGBO(217,
                                                                192, 41, 1),
                                                            "Report", () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pushNamed(
                                                              context,
                                                              tuachuayDekhorPageRoute[
                                                                  "report"]!,
                                                              arguments: {
                                                                'id_post':
                                                                    id_post,
                                                                'id_blogger':
                                                                    detailpost[
                                                                            0][
                                                                        'id_user'],
                                                              });
                                                          print(
                                                              "report the blog");
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.report_outlined,
                                                        color: Colors.black,
                                                      ),
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
                                                        popUpAlertDialog(
                                                          Icon(
                                                            Icons.delete,
                                                            size: 50,
                                                            color: customColors[
                                                                "onContainer"],
                                                          ),
                                                          "Delete post?",
                                                          Colors.red,
                                                          "Delete",
                                                          () {
                                                            deletepost();
                                                            print(
                                                                "delete the blog");
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pushNamed(
                                                                context,
                                                                tuachuayDekhorPageRoute[
                                                                    "profile"]!);
                                                          },
                                                        );
                                                      },
                                                      child: const Icon(
                                                        Icons.delete_outlined,
                                                        color: Colors.white,
                                                      ),
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
                                            child: InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Stack(
                                                      children: [
                                                        Center(
                                                          child: SizedBox(
                                                            width: size.width,
                                                            height: size.height,
                                                            child:
                                                                InteractiveViewer(
                                                              maxScale: 10,
                                                              child:
                                                                  Image.network(
                                                                detailpost[0][
                                                                    'image_link'],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          bottom: 30,
                                                          right: 30,
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                customColors[
                                                                    "icon2"]!,
                                                            child: IconButton(
                                                              icon: Icon(
                                                                Icons.close,
                                                                color: customColors[
                                                                    "container"]!,
                                                              ),
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: Image(
                                                image: NetworkImage(
                                                    detailpost[0]
                                                        ['image_link']),
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
                                                    child: Icon(
                                                      Icons.bookmark,
                                                      color:
                                                          customColors["icon1"],
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      onPressedSaveButton();
                                                      numsave();
                                                    },
                                                    child: Icon(
                                                      Icons.bookmark_outline,
                                                      color: customColors[
                                                          "onContainer"],
                                                    ),
                                                  ),
                                            SizedBox(width: size.width * 0.01),
                                            Text(
                                              "${countsavepost.length}",
                                              style: TextStyle(
                                                color:
                                                    customColors["onContainer"],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 16, 16, 0),
                                      child: Text(
                                        detailpost.isNotEmpty
                                            ? detailpost[0]['title']
                                            : '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color:
                                                customColors["onContainer"]!),
                                      ),
                                    ),
                                    Divider(
                                      color: customColors["label"]!,
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
                                        Icon(
                                          Icons.insert_comment_outlined,
                                          color: customColors["onContainer"],
                                        ),
                                        SizedBox(width: size.width * 0.02),
                                        Text(
                                          "${commentpost.length} Comments",
                                          style: TextStyle(
                                            color: customColors["onContainer"],
                                          ),
                                        ),
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
                                                commentpost[index]['user']
                                                        ['profile'] ??
                                                    "https://api.multiavatar.com/${commentpost[index]['user']['fullname']}.png",
                                              ),
                                            ),
                                            title: Text(
                                              commentpost[index]['user']
                                                  ['fullname'],
                                              style: TextStyle(
                                                color: customColors["main"],
                                              ),
                                            ),
                                            dense: true,
                                            subtitle: Text(
                                              commentpost[index]['comment'],
                                              style: TextStyle(
                                                color:
                                                    customColors["onContainer"],
                                              ),
                                            ),
                                            visualDensity: const VisualDensity(
                                                vertical: -3),
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
