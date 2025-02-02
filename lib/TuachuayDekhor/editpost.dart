import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:http/http.dart' as http;

class TuachuayDekhorEditBlogPage extends StatefulWidget {
  final int id_post;
  const TuachuayDekhorEditBlogPage({super.key, required this.id_post});

  @override
  State<TuachuayDekhorEditBlogPage> createState() =>
      _TuachuayDekhorEditBlogPageState();
}

class _TuachuayDekhorEditBlogPageState extends State<TuachuayDekhorEditBlogPage>
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
  bool status = false;
  late int id_post;
  late Uri detailurl;
  late Uri editurl;
  late Uri uppicurl;
  final writeblogurl = Uri.parse("$api$dekhorWriteBlogRoute");
  var detailpost = [];
  var post = [];
  final posturl = Uri.parse("$api$dekhorPosttoprofileRoute");
  bool isLoading = false;
  late File _image;
  bool selectBarVisible = false;

  Future<void> _getImageGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );

    if (pickedFile != null) {
      var result = await FlutterImageCompress.compressAndGetFile(
        pickedFile.path,
        '${pickedFile.path}_compressed.jpg',
        quality: 80,
      );

      setState(() {
        if (result != null) {
          _image = File(result.path);
        } else {
          print('Error compressing image');
        }
      });
    }
  }

  Future<void> _getImageCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );

    if (pickedFile != null) {
      var result = await FlutterImageCompress.compressAndGetFile(
        pickedFile.path,
        '${pickedFile.path}_compressed.jpg',
        quality: 70,
      );

      setState(() {
        if (result != null) {
          _image = File(result.path);
        } else {
          print('Error compressing image');
        }
      });
    }
  }

  Widget selectBar() {
    Size size = MediaQuery.of(context).size;
    CustomThemes theme =
        ThemesPortal.appThemeFromContext(context, "TuachuayDekhor")!;
    Map<String, Color> customColors = theme.customColors;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 100),
      bottom: selectBarVisible ? 0 : -size.height * 0.12,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          color: customColors["main"]!,
        ),
        width: size.width,
        height: size.height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: size.width * 0.485,
              height: size.height * 0.08,
              decoration: BoxDecoration(
                color: customColors["main"]!,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  selectBarVisible = false;
                  _getImageCamera();
                  print("Add image tapped");
                },
                icon: Icon(
                  Icons.camera_alt,
                  color: customColors["onMain"]!,
                  size: 30,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: customColors["onMain"]!,
                borderRadius: BorderRadius.circular(10),
              ),
              height: size.height * 0.06,
              width: 3,
            ),
            Container(
              width: size.width * 0.485,
              height: size.height * 0.08,
              decoration: BoxDecoration(
                color: customColors["main"]!,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  selectBarVisible = false;
                  _getImageGallery();
                  print("Add image tapped");
                },
                icon: Icon(
                  Icons.image,
                  color: customColors["onMain"]!,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadDetail() async {
    setState(() {
      isLoading = true;
    });

    await detail().then((_) {
      if (detailpost.isNotEmpty) {
        setState(() {
          markdownTitleController.text = detailpost[0]['title'];
          markdownContentController.text = detailpost[0]['content'];
          _dropdownValue = detailpost[0]['category'];
          _image = File(detailpost[0]['pathimage']);
        });
      }
    });
    setState(() {
      isLoading = false;
    });
    print(detailpost);
  }

  @override
  void initState() {
    super.initState();
    id_post = widget.id_post;
    detailurl = Uri.parse("$api$dekhorDetailPostRoute/$id_post");
    editurl = Uri.parse("$api$dekhorEditPostRoute/$id_post");
    uppicurl = Uri.parse("$api$dekhorUpdatePicRoute/$id_post");
    _loadDetail();
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
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pushNamed(context, tuachuayDekhorPageRoute["blog"]!,
              arguments: id_post);
        });
      }
    });
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

  Future<void> editblog() async {
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

  void onBackPressed(Map<String, Color> customColors) {
    if ((markdownTitleController.text != detailpost[0]['title']) ||
        (markdownContentController.text != detailpost[0]['content']) ||
        (_dropdownValue != detailpost[0]['category']) ||
        _image.path.split('/').last !=
            File(detailpost[0]['pathimage']).path.split('/').last) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            surfaceTintColor: customColors["container"]!,
            backgroundColor: customColors["container"]!,
            iconColor: customColors["main"]!,
            icon: Icon(
              Icons.edit_off,
              size: 50,
              color: customColors["main"]!,
            ),
            title: Text(
              "Discard edit?",
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
                    borderRadius: BorderRadius.circular(10), color: Colors.red),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    print("Discard edited post");
                  },
                  child: const Text(
                    "Discard",
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
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: customColors["main"]!,
                ),
              )
            : SlidingBox(
                color: customColors["background"]!,
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
                            child: Icon(
                              Icons.close,
                              color: customColors["main"]!,
                              size: 20,
                            ),
                            onTap: () {
                              boxController.closeBox();
                            }),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Preview",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: customColors["main"]!,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Title :",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: customColors["main"]!,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: customColors["textInputContainer"]!
                              .withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        height: size.height * 0.075,
                        width: size.width,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            markdownTitleText,
                          ),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: size.height * 0.3,
                        ),
                        margin: const EdgeInsets.only(bottom: 10),
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
                                          child: InteractiveViewer(
                                            maxScale: 10,
                                            child: _image.path
                                                        .split('/')
                                                        .last ==
                                                    File(detailpost[0]
                                                            ['pathimage'])
                                                        .path
                                                        .split('/')
                                                        .last
                                                ? Image.network(
                                                    detailpost[0]['image_link'],
                                                  )
                                                : Image.file(
                                                    _image,
                                                  ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 30,
                                        right: 30,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              customColors["icon2"]!,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.close,
                                              color: customColors["container"]!,
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: _image.path.split('/').last ==
                                    File(detailpost[0]['pathimage'])
                                        .path
                                        .split('/')
                                        .last
                                ? Image.network(
                                    detailpost[0]['image_link'],
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Content :",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: customColors["main"]!,
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
                              child: PopScope(
                                canPop: false,
                                onPopInvoked: (bool didPop) {
                                  if (didPop) {
                                    return;
                                  }
                                  onBackPressed(customColors);
                                },
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
                                  onTap: () => onBackPressed(customColors),
                                ),
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
                                      onPressed: () async {
                                        await editblog();
                                        await updatepicture(_image);
                                        print("Post tapped");
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                surfaceTintColor:
                                                    customColors["container"]!,
                                                backgroundColor:
                                                    customColors["container"]!,
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
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: customColors[
                                                                "onContainer"]!,
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
                                left: size.width * 0.08,
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
                                    width: size.width * 0.6,
                                    child: TextFormField(
                                      onTap: () {
                                        selectBarVisible = false;
                                      },
                                      textInputAction: TextInputAction.next,
                                      onEditingComplete: () {
                                        anotherFocusNode.requestFocus();
                                      },
                                      focusNode: firstFocusNode,
                                      controller: markdownTitleController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: customColors["textInput"]!
                                          .withOpacity(0.5),
                                      onChanged: (value) {
                                        setState(() {
                                          markdownTitleText = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        fillColor:
                                            customColors["textInputContainer"]!,
                                        filled: true,
                                        labelText: "Write a title",
                                        labelStyle: TextStyle(
                                          color: customColors["label"]!,
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
                                      selectBarVisible = false;
                                      setState(() {
                                        markdownTitleText =
                                            markdownTitleController.text;
                                        markdownContentText =
                                            markdownContentController.text;
                                      });
                                      boxController.openBox();
                                    },
                                    icon: Icon(
                                      Icons.preview,
                                      color: customColors["main"]!,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: size.height * 0.02,
                                left: size.width * 0.16,
                              ),
                              width: size.width * 0.85,
                              child: TextFormField(
                                onTap: () {
                                  selectBarVisible = false;
                                },
                                focusNode: anotherFocusNode,
                                controller: markdownContentController,
                                keyboardType: TextInputType.multiline,
                                cursorColor:
                                    customColors["textInput"]!.withOpacity(0.5),
                                minLines: 5,
                                maxLines: 5,
                                onChanged: (value) {
                                  setState(() {
                                    markdownContentText = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  fillColor:
                                      customColors["textInputContainer"]!,
                                  filled: true,
                                  labelText: "Write a blog",
                                  labelStyle: TextStyle(
                                    color: customColors["label"]!,
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
                        child: Container(
                          height: size.width * 0.12,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: customColors["main"]!,
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: customColors["container"]!,
                                ),
                                child: DropdownButton(
                                  underline: const SizedBox(),
                                  padding: const EdgeInsets.only(left: 10),
                                  hint: Text(
                                    "Select Category",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: customColors["onContainer"]!,
                                    ),
                                  ),
                                  dropdownColor: customColors["container"]!,
                                  iconEnabledColor:
                                      customColors["onContainer"]!,
                                  items: [
                                    DropdownMenuItem(
                                      value: "decoration",
                                      child: Text(
                                        "Decoration",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: customColors["onContainer"]!,
                                        ),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "cleaning",
                                      child: Text(
                                        "Cleaning",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: customColors["onContainer"]!,
                                        ),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "cooking",
                                      child: Text(
                                        "Cooking",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: customColors["onContainer"]!,
                                        ),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "story",
                                      child: Text(
                                        "Story",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: customColors["onContainer"]!,
                                        ),
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
                                  color: customColors["container"]!,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    selectBarVisible = true;
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        child: Icon(
                                          Icons.image,
                                          color: customColors["main"]!,
                                          size: 24,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        constraints: BoxConstraints(
                                          maxWidth: size.width * 0.51,
                                        ),
                                        child: Text(
                                          _image.path.split('/').last,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const NavbarTuachuayDekhor(),
                      selectBar(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
