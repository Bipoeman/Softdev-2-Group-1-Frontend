import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:http/http.dart' as http;

class TuachuayDekhorEditDraftPage extends StatefulWidget {
  final int id_draft;
  const TuachuayDekhorEditDraftPage({super.key, required this.id_draft});

  @override
  State<TuachuayDekhorEditDraftPage> createState() =>
      _TuachuayDekhorEditDraftPageState();
}

class _TuachuayDekhorEditDraftPageState
    extends State<TuachuayDekhorEditDraftPage>
    with SingleTickerProviderStateMixin {
  String? _dropdownValue;
  BoxController boxController = BoxController();
  TextEditingController markdownTitleController = TextEditingController();
  TextEditingController markdownContentController = TextEditingController();
  String markdownTitleText = "";
  String markdownContentText = "";
  final FocusNode firstFocusNode = FocusNode();
  final FocusNode anotherFocusNode = FocusNode();
  late AnimationController animationController;
  bool status = true;
  late int id_draft;
  final writeblogurl = Uri.parse("$api$dekhorWriteBlogRoute");
  final drafttopostbloggurl = Uri.parse("$api$dekhorDrafttoPostBlogRoute");
  var detaildraft = [];
  var post = [];
  final posturl = Uri.parse("$api$dekhorPosttoprofileRoute");
  late Uri editurl;
  late Uri detailurl;
  late Uri deletedrafturl;
  late Uri uppicurl;
  bool isLoading = false;
  late File _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _loadDetail() async {
    setState(() {
      isLoading = true;
    });

    await detail().then((_) {
      if (detaildraft.isNotEmpty) {
        setState(() {
          markdownTitleController.text = detaildraft[0]['title'];
          markdownContentController.text = detaildraft[0]['content'];
          _dropdownValue = detaildraft[0]['category'];
          _image = File(detaildraft[0]['pathimage']);
        });
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    id_draft = widget.id_draft;
    editurl = Uri.parse("$api$dekhorEditDraftRoute/$id_draft");
    detailurl = Uri.parse("$api$dekhorDetailDraftRoute/$id_draft");
    deletedrafturl = Uri.parse("$api$dekhorDeleteDraftRoute/$id_draft");
    uppicurl = Uri.parse("$api$dekhorUpdatePicDraftRoute/$id_draft");
    _loadDetail();
    posttoprofile();
    firstFocusNode.requestFocus();
    animationController = AnimationController(
      vsync: this,
    );
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 700), () {
          FocusManager.instance.primaryFocus?.unfocus();
          animationController.reset();
          Navigator.pop(context);
          Navigator.pushNamed(context, tuachuayDekhorPageRoute["profile"]!);
        });
      }
    });
  }

  Future<void> writeblog(File imageFile) async {
    try {
      var request = http.MultipartRequest('POST', writeblogurl);
      request.headers['Authorization'] = 'Bearer $publicToken';
      request.fields['title'] = markdownTitleController.text;
      request.fields['content'] = markdownContentController.text;
      request.fields['category'] = _dropdownValue!;
      request.fields['fullname'] = profileData['fullname'];
      request.files
          .add(await http.MultipartFile.fromPath('file', imageFile.path));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        status = true;
      } else {
        status = false;
      }
    } catch (error) {
      print('Error writing blog: $error');
    }
  }

  Future<void> drafttopostblog() async {
    var response = await http.post(drafttopostbloggurl, headers: {
      "Authorization": "Bearer $publicToken"
    }, body: {
      "title": markdownTitleController.text,
      "content": markdownContentController.text,
      "category": _dropdownValue,
      "image_link": detaildraft[0]['image_link'],
      "fullname": profileData['fullname'],
      "pathimage": _image.path,
    });

    if (response.statusCode == 200) {
      print('success');
      status = true;
    } else {
      print('failed');
      status = false;
    }
  }

  Future<void> editdraft() async {
    var response = await http.put(editurl, headers: {
      "Authorization": "Bearer $publicToken"
    }, body: {
      "title": markdownTitleController.text,
      "content": markdownContentController.text,
      "category": _dropdownValue,
      "fullname": profileData['fullname'],
      "pathimage": _image.path,
    });

    if (response.statusCode == 200) {
      status = true;
    } else {
      status = false;
    }
  }

  Future<void> updatepicture(File? imageFile) async {
    try {
      var request = http.MultipartRequest('PUT', uppicurl);
      request.files
          .add(await http.MultipartFile.fromPath('file', imageFile!.path));
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        status = true;
      } else {
        status = false;
      }
    } catch (error) {
      print('Error writing blog: $error');
    }
  }

  Future<void> detail() async {
    var response = await http.get(detailurl);
    if (response.statusCode == 200) {
      setState(() {
        detaildraft = jsonDecode(response.body);
        print(detaildraft);
      });
    } else {
      throw Exception('Failed to load data');
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

  Future<void> deletedraft() async {
    await http.delete(deletedrafturl);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(0, 48, 73, 1),
                ),
              )
            : SlidingBox(
                controller: boxController,
                physics: const NeverScrollableScrollPhysics(),
                collapsed: true,
                draggable: false,
                minHeight: 0,
                maxHeight: size.height * 0.75,
                onBoxClose: () => anotherFocusNode.requestFocus(),
                body: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                            child: const Icon(Icons.close),
                            onTap: () {
                              boxController.closeBox();
                            }),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const Text(
                          "Preview",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 48, 73, 1),
                          ),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Title :",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 48, 73, 1),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        height: size.height * 0.075,
                        child: Scrollbar(
                          child: Markdown(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            data: markdownTitleText,
                          ),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: size.height * 0.3,
                        ),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: IntrinsicHeight(
                          child: ClipRRect(
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : (_image.path.split('/').last)
                                            .split('_')
                                            .first ==
                                        "dekhorblog"
                                    ? Image.network(
                                        detaildraft[0]['image_link'],
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(_image, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Content :",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 48, 73, 1),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        height: size.height * 0.45,
                        child: Scrollbar(
                          child: Markdown(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            data: markdownContentText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                backdrop: Backdrop(
                  overlay: true,
                  moving: false,
                  body: Stack(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: size.height -
                                [size.width * 0.4, 100.0].reduce(min) -
                                MediaQuery.of(context).padding.top),
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
                                onTap: () {
                                  if ((markdownTitleController.text !=
                                          detaildraft[0]['title']) ||
                                      (markdownContentController.text !=
                                          detaildraft[0]['content']) ||
                                      (_dropdownValue !=
                                          detaildraft[0]['category'])) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          surfaceTintColor: Colors.white,
                                          backgroundColor: Colors.white,
                                          iconPadding: EdgeInsets.zero,
                                          iconColor: const Color.fromRGBO(
                                              0, 48, 73, 1),
                                          icon: Stack(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    24, 30, 24, 16),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.note_alt,
                                                        size: 50),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, right: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                      color: Colors.grey,
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      icon: const Icon(
                                                          Icons.close),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          title: const Text("Save draft?"),
                                          actionsAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          actions: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.red),
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "Discard",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.green),
                                              child: TextButton(
                                                onPressed: () {
                                                  editdraft();
                                                  updatepicture(_image);
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  Navigator.pushNamed(
                                                      context,
                                                      tuachuayDekhorPageRoute[
                                                          "draft"]!);
                                                  print("Draft saved");
                                                },
                                                child: const Text(
                                                  "Draft",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.01,
                                right: size.width * 0.04,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 70,
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 10),
                                    child: RawMaterialButton(
                                      onPressed: () {
                                        deletedraft();
                                        print("Delete draft tapped");
                                        Navigator.pop(context);
                                      },
                                      fillColor: Colors.red[900],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                      child: const Text("DELETE"),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    margin: const EdgeInsets.only(right: 10),
                                    child: RawMaterialButton(
                                      onPressed: () {
                                        if (_image.path !=
                                            detaildraft[0]['pathimage']) {
                                          writeblog(_image);
                                        } else {
                                          drafttopostblog();
                                        }
                                        deletedraft();
                                        print("Post tapped");
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                surfaceTintColor: Colors.white,
                                                backgroundColor: Colors.white,
                                                child: SizedBox(
                                                  width: size.width * 0.3,
                                                  height: size.height * 0.3,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      LottieBuilder.asset(
                                                        status
                                                            ? "assets/images/Logo/Animation_Success.json"
                                                            : "assets/images/Logo/Animation_Fail.json",
                                                        repeat: false,
                                                        controller:
                                                            animationController,
                                                        onLoaded:
                                                            (composition) {
                                                          animationController
                                                                  .duration =
                                                              composition
                                                                  .duration;
                                                          animationController
                                                              .forward();
                                                        },
                                                      ),
                                                      SizedBox(
                                                          height: size.height *
                                                              0.03),
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          status
                                                              ? "Post successful!"
                                                              : "Post failed!",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      fillColor:
                                          const Color.fromRGBO(217, 192, 41, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                      child: const Text("POST"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.02,
                                left: size.width * 0.12,
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                      profileData['profile'] ??
                                          "https://api.multiavatar.com/${profileData['fullname'] ?? "John Doe".replaceAll(" ", "+")}.png",
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    height: 30,
                                    width: size.width * 0.55,
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      focusNode: firstFocusNode,
                                      controller: markdownTitleController,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      keyboardType: TextInputType.text,
                                      cursorColor:
                                          Colors.black.withOpacity(0.5),
                                      cursorHeight: 18,
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.withOpacity(0.3),
                                        filled: true,
                                        labelText: "Write a title",
                                        labelStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 14,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      setState(() {
                                        markdownTitleText =
                                            markdownTitleController.text;
                                        markdownContentText =
                                            markdownContentController.text;
                                      });
                                      boxController.openBox();
                                    },
                                    icon: const Icon(Icons.preview),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: size.height * 0.02,
                                left: size.width * 0.2,
                              ),
                              width: size.width * 0.85,
                              child: TextFormField(
                                focusNode: anotherFocusNode,
                                controller: markdownContentController,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                                keyboardType: TextInputType.multiline,
                                cursorColor: Colors.black.withOpacity(0.5),
                                cursorHeight: 16,
                                minLines: 8,
                                maxLines: 8,
                                decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  fillColor: Colors.grey.withOpacity(0.3),
                                  filled: true,
                                  labelText: "Write a blog",
                                  labelStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: size.width * 0.12,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(0, 48, 73, 1),
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: DropdownButton(
                                  underline: const SizedBox(),
                                  padding: const EdgeInsets.only(left: 10),
                                  hint: const Text(
                                    "Select Category",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  dropdownColor: Colors.white,
                                  iconEnabledColor: Colors.black,
                                  items: const [
                                    DropdownMenuItem(
                                      value: "decoration",
                                      child: Text(
                                        "Decoration",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "cleaning",
                                      child: Text(
                                        "Cleaning",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "cooking",
                                      child: Text(
                                        "Cooking",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "story",
                                      child: Text(
                                        "Story",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                  value: _dropdownValue,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        _dropdownValue = value;
                                      },
                                    );
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(right: 5),
                                margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey[200],
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _getImage();
                                        print("Add image tapped");
                                      },
                                      child: const Icon(
                                        Icons.image,
                                        color: Color.fromRGBO(0, 48, 73, 1),
                                        size: 24,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      constraints: BoxConstraints(
                                        maxWidth: size.width * 0.525,
                                      ),
                                      child: Text(
                                        _image.path.split('/').last,
                                        overflow: TextOverflow.ellipsis,
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
              ),
      ),
    );
  }
}
