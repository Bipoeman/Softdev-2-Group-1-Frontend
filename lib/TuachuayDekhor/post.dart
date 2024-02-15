import "package:comment_box/comment/comment.dart";
import "package:flutter/material.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:ruam_mitt/TuachuayDekhor/Component/navbar.dart";

class TuachuayDekhorBlogPage extends StatefulWidget {
  const TuachuayDekhorBlogPage({super.key});

  @override
  State<TuachuayDekhorBlogPage> createState() => _TuachuayDekhorBlogPageState();
}

class _TuachuayDekhorBlogPageState extends State<TuachuayDekhorBlogPage> {
  bool isOwner = false;
  TextEditingController commentTextController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const NavbarTuachuayDekhor()),
      body: SafeArea(
        child: CommentBox(
          userImage:
              const NetworkImage("https://api.multiavatar.com/Starcrasher.png"),
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
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: size.width * 0.04),
                                    Text("pumxni"),
                                    isOwner
                                        ? IconButton(
                                            onPressed: () {
                                              print("edit the blog");
                                            },
                                            icon:
                                                Icon(Icons.edit_note_outlined))
                                        : Divider()
                                  ],
                                ),
                                !isOwner
                                    ? IconButton(
                                        onPressed: () {
                                          print("report the blog");
                                        },
                                        icon: const Icon(Icons.report_outlined))
                                    : IconButton(
                                        onPressed: () {
                                          print("delete the blog");
                                        },
                                        icon: const Icon(Icons.delete_outlined))
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.025,
                            ),
                            Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: size.height * 0.25,
                                  color: Colors.grey,
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
                            // SizedBox(height: size.height * 0.01),
                            SizedBox(
                              height: size.height * 0.18,
                              // ignore: prefer_const_constructors
                              child: Scrollbar(
                                child: Markdown(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    data: """### หอดีมากครับ ดีจนอยากย้ายเลย
Lorem Ipsum is simply **Bold** text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum
                              """),
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
                                        visualDensity:
                                            VisualDensity(vertical: -3),
                                        trailing: Icon(
                                            Icons.report_gmailerrorred_rounded),
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
