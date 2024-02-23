import "package:comment_box/comment/comment.dart";
import "package:flutter/material.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:ruam_mitt/TuachuayDekhor/Component/navbar.dart";
import 'package:ruam_mitt/global_var.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:ruam_mitt/global_var.dart';
import "package:ruam_mitt/TuachuayDekhor/Component/blog_box.dart";
import "package:ruam_mitt/global_const.dart";
import 'package:http/http.dart' as http;

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
  late Uri detailurl;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    id_post = widget.id_post;
    detailurl = Uri.parse("$api$dekhorDetailPostRoute/$id_post");
    _loadDetail();
  }

  void checkuser(){
    if (profileData['fullname'] == detailpost[0]['user']['fullname']){
      setState(() {
        isOwner = true;
      });
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const NavbarTuachuayDekhor(),
      ),
      body: SafeArea(
        child: isLoading
            ? Center(
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
                  icon: Icon(Icons.send_sharp, size: 25, color: Colors.white),
                  onPressed: () {
                    print("send tapped");
                    print(commentTextController.text);
                  },
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: size.width * 0.04,
                          right: size.width * 0.04,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: size.height * 0.03),
                            GestureDetector(
                              child: const Row(children: [
                                Icon(Icons.arrow_back_outlined),
                                SizedBox(width: 5),
                                Text("Back")
                              ]),
                              onTap: () => Navigator.pop(context),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          Text(detailpost.isNotEmpty ? detailpost[0]['user']['fullname'] : ''),
                                          isOwner
                                              ? IconButton(
                                                  onPressed: () {
                                                    print("edit the blog");
                                                  },
                                                  icon: Icon(Icons.edit_rounded),
                                                  iconSize: 18,)
                                              : Divider()
                                        ],
                                      ),
                                      !isOwner
                                          ? IconButton(
                                              onPressed: () {
                                                print("report the blog");
                                              },
                                              icon: Icon(Icons.report_outlined))
                                          : IconButton(
                                              onPressed: () {
                                                print("delete the blog");
                                              },
                                              icon: Icon(Icons.delete_outlined))
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.025,
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        constraints: const BoxConstraints(maxHeight: 200),
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10),
                                          ),
                                        ),
                                        child: IntrinsicHeight(
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: Image(
                                              image: NetworkImage(
                                                detailpost.isNotEmpty && detailpost[0]['image_link'] != "null"
                                                    ? detailpost[0]['image_link']
                                                    : "https://cdn-icons-png.freepik.com/512/6114/6114045.png",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.015,
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            child: Icon(Icons.bookmark_outline),
                                            onTap: () {
                                              print("bookmark");
                                            },
                                          ),
                                          Text("100")
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.18,
                                    child: Scrollbar(
                                      child: Markdown(
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        data: detailpost.isNotEmpty ? detailpost[0]['content'] : '',
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                  Row(
                                    children: [
                                      const Icon(Icons.insert_comment_outlined),
                                      SizedBox(width: size.width * 0.02),
                                      Text("4 Comments")
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.2,
                                    child: Scrollbar(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: List.generate(4, (index) {
                                            return ListTile(
                                              onTap: () {},
                                              leading: Container(
                                                width: 25,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey),
                                              ),
                                              title: Text("Username"),
                                              dense: true,
                                              subtitle: Text("จริงหรอครับ"),
                                              visualDensity: VisualDensity(vertical: -3),
                                              trailing:
                                                  Icon(Icons.report_gmailerrorred_rounded),
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
