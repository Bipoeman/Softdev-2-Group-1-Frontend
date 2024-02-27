import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:http/http.dart' as http;

class ProfileWidgetV2 extends StatefulWidget {
  const ProfileWidgetV2({super.key});

  @override
  State<ProfileWidgetV2> createState() => _ProfileWidgetV2State();
}

class _ProfileWidgetV2State extends State<ProfileWidgetV2> {
  BoxController editProfileController = BoxController();
  String fieldToEditDisplayText = "";
  String fieldEditKey = "";
  FocusNode profileEditFocusNode = FocusNode();
  TextEditingController fieldEditController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fieldEditController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    Future<File?> getImage() async {
      final ImagePicker _picker = ImagePicker();
      // Pick an image
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return null;
      }
      //TO convert Xfile into file
      File file = File(image.path);
      //print(‘Image picked’);
      return file;
    }

    return Stack(
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
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -[size.width * 0.6, 300.0].reduce(min),
                      left: size.width * 0.5 -
                          [size.width * 0.6, 300.0].reduce(min),
                      child: CustomPaint(
                        painter: HalfCirclePainter(
                          color: theme.colorScheme.primary,
                        ),
                        size: Size(
                          [size.width * 1.2, 600.0].reduce(min),
                          [size.width * 0.6, 300.0].reduce(min),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: 175,
                          height: 175,
                          margin: EdgeInsets.only(
                            top: [size.width * 0.6, 300.0].reduce(min) -
                                175 * 0.6,
                          ),
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.primaryContainer,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(profileData['imgPath']),
                            ),
                          ),
                        ),
                        Positioned.directional(
                          textDirection: TextDirection.ltr,
                          bottom: 10,
                          end: 10,
                          child: GestureDetector(
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: theme.colorScheme.primaryContainer,
                              ),
                            ),
                            onTap: () async {
                              print("You might want to change profile image");
                              print(publicToken);
                              File? imageSelectedFile = await getImage();
                              if (imageSelectedFile == null) return;
                              Uri url = Uri.parse("$api$userImageUpdateRoute");
                              http.MultipartRequest request =
                                  http.MultipartRequest('POST', url);
                              request.headers.addAll({
                                "Authorization": "Bearer $publicToken",
                                "Content-Type": "application/json"
                              });
                              request.files.add(
                                http.MultipartFile.fromBytes(
                                  "file",
                                  File(imageSelectedFile.path)
                                      .readAsBytesSync(),
                                  filename: imageSelectedFile.path,
                                ),
                              );

                              // print(request.files.first);
                              http.StreamedResponse response =
                                  await request.send();
                              http.Response res =
                                  await http.Response.fromStream(response);
                              if (res.statusCode == 200) {
                                dynamic responseJson = json.decode(res.body);
                                var nowParam = DateFormat('yyyyddMMHHmmss')
                                    .format(DateTime.now());
                                print(nowParam);
                                profileData['imgPath'] =
                                    "https://pyygounrrwlsziojzlmu.supabase.co/storage/v1/object/public/${responseJson['fullPath']}#$nowParam";
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.fromLTRB(
                        0,
                        [
                          ([size.width * 0.6, 300.0].reduce(min) - 175) * 0.5,
                          0.0,
                        ].reduce(max),
                        0,
                        0,
                      ),
                      child: Center(
                        child: Text(
                          profileData['fullname'],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(profileData['fullname']),
                        trailing: const Icon(Icons.edit),
                        onTap: () {
                          setState(() {
                            fieldToEditDisplayText = "Full Name";
                            fieldEditKey = "fullname";
                            fieldEditController.text = profileData['fullname'];
                          });
                          if (editProfileController.isBoxOpen) {
                            editProfileController.closeBox();
                          } else {
                            editProfileController.openBox();
                          }
                        },
                      ),
                      const Divider(
                        height: 4,
                        thickness: 1,
                        indent: 20,
                        endIndent: 0,
                        color: Color.fromARGB(44, 109, 108, 108),
                      ),
                      ListTile(
                        leading: const Icon(Icons.email_outlined),
                        title: Text(profileData['email']),
                        trailing: const Icon(Icons.edit),
                        onTap: () {
                          setState(() {
                            fieldToEditDisplayText = "Email";
                            fieldEditKey = "email";
                            fieldEditController.text =
                                profileData[fieldEditKey];
                          });
                          if (editProfileController.isBoxOpen) {
                            editProfileController.closeBox();
                          } else {
                            editProfileController.openBox();
                          }
                        },
                      ),
                      const Divider(
                        height: 4,
                        thickness: 1,
                        indent: 20,
                        endIndent: 0,
                        color: Color.fromARGB(44, 109, 108, 108),
                      ),
                      ListTile(
                        leading: const Icon(Icons.calendar_month_outlined),
                        title: Text(profileData['birthday'] ?? "Not provided"),
                        trailing: const Icon(Icons.edit),
                        onTap: () {
                          Navigator.pushNamed(
                              context, ruamMitrPageRoute['edit-profile']!);
                        },
                      ),
                      const Divider(
                        height: 4,
                        thickness: 1,
                        indent: 20,
                        endIndent: 0,
                        color: Color.fromARGB(44, 109, 108, 108),
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone_outlined),
                        title: Text(profileData['phonenum'] ?? "Not provided"),
                        trailing: const Icon(Icons.edit),
                        onTap: () {
                          setState(
                            () {
                              fieldToEditDisplayText = "Phone Number";
                              fieldEditKey = "phonenum";
                              fieldEditController.text =
                                  profileData[fieldEditKey] ?? "";
                            },
                          );
                          if (editProfileController.isBoxOpen) {
                            editProfileController.closeBox();
                          } else {
                            editProfileController.openBox();
                          }
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.edit_document),
                        title: Text(profileData['description'] ??
                            "Edit your desciption"),
                        trailing: const Icon(Icons.edit),
                        onTap: () {
                          setState(() {
                            fieldToEditDisplayText = "Description";
                            fieldEditKey = "description";
                            fieldEditController.text =
                                profileData[fieldEditKey] ?? "";
                          });
                          if (editProfileController.isBoxOpen) {
                            editProfileController.closeBox();
                          } else {
                            editProfileController.openBox();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SlidingBox(
          physics: const NeverScrollableScrollPhysics(),
          collapsed: true,
          draggableIconVisible: false,
          maxHeight: size.height * 0.3,
          minHeight: 0,
          draggable: false,
          controller: editProfileController,
          body: Container(
            // margin: EdgeInsets.only(bottom: 71),
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, top: 10, bottom: 71),
            child: SizedBox(
              height: size.height * 0.28,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        fieldToEditDisplayText,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          editProfileController.closeBox();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    // height: size.height * 0.07,
                    child: TextField(
                      focusNode: profileEditFocusNode,
                      controller: fieldEditController,
                      decoration: InputDecoration(
                        hintText:
                            "Enter your ${fieldToEditDisplayText.toLowerCase()}",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.background,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            if (profileEditFocusNode.hasFocus) {
                              profileEditFocusNode.unfocus();
                            }
                            fieldEditController.clear();
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        textStyle: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        foregroundColor: theme.colorScheme.onPrimary,
                      ),
                      child: const Text("Save"),
                      onPressed: () async {
                        profileData[fieldEditKey] = fieldEditController.text;
                        Uri url = Uri.parse("$api$userDataUpdateRoute");
                        await http
                            .put(
                              url,
                              headers: {
                                "Authorization": "Bearer $publicToken",
                                "Content-Type": "application/json"
                              },
                              body: json.encode(profileData),
                            )
                            .timeout(const Duration(seconds: 2))
                            .onError((error, stackTrace) {
                          print(error);
                          return http.Response("Error", 404);
                        }).then((value) {
                          print(value.statusCode);
                          setState(() {});
                          if (value.statusCode == 200) {
                            if (value.body == "change profile success") {
                              if (profileEditFocusNode.hasFocus) {
                                profileEditFocusNode.unfocus();
                              }
                              editProfileController.closeBox();
                            }
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class HalfCirclePainter extends CustomPainter {
  final Color color;

  HalfCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height);

    final path = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(
        Rect.fromCircle(center: center, radius: radius),
        0,
        pi,
        false,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(HalfCirclePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
