import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:lottie/lottie.dart';
import 'package:ruam_mitt/RuamMitr/avatar_custom.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_func.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:http/http.dart' as http;
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';

class ProfileWidgetV2 extends StatefulWidget {
  const ProfileWidgetV2({super.key});

  @override
  State<ProfileWidgetV2> createState() => _ProfileWidgetV2State();
}

class _ProfileWidgetV2State extends State<ProfileWidgetV2>
    with TickerProviderStateMixin {
  BoxController editProfileController = BoxController();
  BoxController editImageProfileBoxController = BoxController();
  String fieldToEditDisplayText = "";
  String fieldEditKey = "";
  FocusNode profileEditFocusNode = FocusNode();
  TextEditingController fieldEditController = TextEditingController();
  late AnimationController animationController;
  BuildContext? dialogContext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this);
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fieldEditController.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    CustomThemes ruammitrThemeData =
        ThemesPortal.appThemeFromContext(context, "RuamMitr")!;
    Map<String, Color> customColors = ruammitrThemeData.customColors;
    String globalStatus = "idle";
    Future<File?> getImage({ImageSource? source}) async {
      final ImagePicker picker = ImagePicker();
      // Pick an image
      XFile? image = await picker.pickImage(
        source: source ?? ImageSource.gallery,
      );
      if (image != null) {
        var result = await FlutterImageCompress.compressAndGetFile(
          image.path,
          '${image.path}_compressed.jpg',
          quality: 30,
        );
        if (result != null) {
          return File(result.path);
        } else {
          debugPrint('Error compressing image');
        }
      }
      return null;
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
                              editImageProfileBoxController.openBox();
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
                      const Divider(
                        height: 4,
                        thickness: 1,
                        indent: 20,
                        endIndent: 0,
                        color: Color.fromARGB(44, 109, 108, 108),
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
                      const Divider(
                        height: 4,
                        thickness: 1,
                        indent: 20,
                        endIndent: 0,
                        color: Color.fromARGB(44, 109, 108, 108),
                      ),
                      ListTile(
                        leading: const Icon(Icons.password),
                        title: const Text("********"),
                        trailing: const Icon(Icons.edit),
                        onTap: () {
                          Navigator.pushNamed(
                              context, ruamMitrPageRoute["password-change"]!);
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
          onBoxOpen: () => editImageProfileBoxController.closeBox(),
          physics: const NeverScrollableScrollPhysics(),
          collapsed: true,
          draggableIconVisible: false,
          maxHeight: size.height * 0.3,
          minHeight: 0,
          color: customColors["oddContainer"]!,
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
                        fillColor: customColors["textInputContainer"]!,
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
                        debugPrint("$url");
                        await http
                            .put(
                              url,
                              headers: {
                                "Authorization": "Bearer $publicToken",
                                "Content-Type": "application/json"
                              },
                              body: json.encode(profileData),
                            )
                            .timeout(const Duration(seconds: 4))
                            .onError((error, stackTrace) {
                          debugPrint("$error");
                          return http.Response("Error $error", 404);
                        }).then((value) {
                          debugPrint(
                              "Return status Code : ${value.statusCode}");
                          debugPrint("Return body : ${value.body}");
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
        ),
        SlidingBox(
          onBoxOpen: () => editProfileController.closeBox(),
          physics: const NeverScrollableScrollPhysics(),
          collapsed: true,
          draggableIconVisible: false,
          maxHeight: size.height * 0.4,
          minHeight: 0,
          color: customColors["oddContainer"]!,
          draggable: false,
          controller: editImageProfileBoxController,
          body: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Edit your profile image...",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        editImageProfileBoxController.closeBox();
                      },
                    ),
                  ],
                ),
                const Divider(),
                ListTile(
                  title: const Text("Customize your avatar"),
                  tileColor: Colors.white,
                  trailing: const Icon(Icons.edit),
                  onTap: () async {
                    String selectedAvatarString = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AvatarCustomPage(),
                      ),
                    );
                    // debugPrint(selectedAvatarString);
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          dialogContext = context;
                          return AlertDialog(
                            content: SizedBox(
                              height: size.height * 0.4,
                              child: Center(
                                child: globalStatus == "loading"
                                    ? LottieBuilder.asset(
                                        "assets/images/Logo/Animation_loading.json",
                                        repeat: true,
                                        controller: animationController,
                                        onLoaded: (composition) {
                                          animationController.duration =
                                              composition.duration;
                                          animationController.forward();
                                        },
                                      )
                                    : globalStatus == "success"
                                        ? LottieBuilder.asset(
                                            "assets/images/Logo/Animation_Success.json",
                                            repeat: true,
                                            controller: animationController,
                                            onLoaded: (composition) {
                                              animationController.duration =
                                                  composition.duration;
                                              animationController.forward();
                                            },
                                          )
                                        : globalStatus == "fail"
                                            ? LottieBuilder.asset(
                                                "assets/images/Logo/Animation_Fail.json",
                                                repeat: true,
                                                controller: animationController,
                                                onLoaded: (composition) {
                                                  animationController.duration =
                                                      composition.duration;
                                                  animationController.forward();
                                                },
                                              )
                                            : Container(),
                              ),
                            ),
                          );
                        },
                      );
                      final pictureInfo = await vg.loadPicture(
                          SvgStringLoader(selectedAvatarString), context);
                      final image = await pictureInfo.picture.toImage(275, 275);
                      final byteData =
                          await image.toByteData(format: ImageByteFormat.png);
                      final pngBytes = byteData!.buffer.asUint8List();
                      if (context.mounted) {
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
                            pngBytes,
                            filename: "${profileData['fullname']}_generate",
                          ),
                        );
                        // print(request.files.first);
                        setState(() {
                          globalStatus = "loading";
                        });
                        http.StreamedResponse response = await request.send();
                        http.Response res =
                            await http.Response.fromStream(response);
                        if (res.statusCode == 200) {
                          dynamic responseJson = json.decode(res.body);
                          profileData['imgPath'] =
                              "https://pyygounrrwlsziojzlmu.supabase.co/storage/v1/object/public/${responseJson['fullPath']}";
                          setState(() {
                            globalStatus = "success";
                            animationController.reset();
                          });
                          await Future.delayed(
                              const Duration(milliseconds: 1500));
                          globalStatus = "idle";
                          if (dialogContext?.mounted ?? false) {
                            Navigator.pop(dialogContext!);
                          }
                        } else if (res.statusCode == 403) {
                          if (context.mounted) {
                            // int newTokenStatusReturn =
                            await requestNewToken(context);
                          }
                        }

                        debugPrint(res.body);
                        editImageProfileBoxController.closeBox();
                      }
                    }
                  },
                ),
                const Divider(),
                ListTile(
                  // Generate new avatar
                  title: const Text("Generate new avatar"),
                  tileColor: Colors.white,
                  trailing: const Icon(Icons.repeat_rounded),
                  onTap: () async {
                    Uri url = Uri.parse(
                        "https://api.multiavatar.com/${(profileData['fullname'] ?? "").replaceAll(" ", "+")}.png");
                    http.Response response = await http.get(url);

                    // debugPrint(response.bodyBytes);
                    Uint8List imageRequested = response.bodyBytes;
                    if (context.mounted) {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: SizedBox(
                              height: size.height * 0.5,
                              child: Center(
                                child: globalStatus == "loading"
                                    ? LottieBuilder.asset(
                                        "assets/images/Logo/Animation_loading.json",
                                        repeat: true,
                                        controller: animationController,
                                        onLoaded: (composition) {
                                          animationController.duration =
                                              composition.duration;
                                          animationController.forward();
                                        },
                                      )
                                    : globalStatus == "success"
                                        ? LottieBuilder.asset(
                                            "assets/images/Logo/Animation_Success.json",
                                            repeat: true,
                                            controller: animationController,
                                            onLoaded: (composition) {
                                              animationController.duration =
                                                  composition.duration;
                                              animationController.forward();
                                            },
                                          )
                                        : globalStatus == "fail"
                                            ? LottieBuilder.asset(
                                                "assets/images/Logo/Animation_Fail.json",
                                                repeat: true,
                                                controller: animationController,
                                                onLoaded: (composition) {
                                                  animationController.duration =
                                                      composition.duration;
                                                  animationController.forward();
                                                },
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.memory(
                                                    imageRequested,
                                                    frameBuilder: (context,
                                                        child,
                                                        frame,
                                                        wasSynchronouslyLoaded) {
                                                      if (wasSynchronouslyLoaded) {
                                                        return child;
                                                      }
                                                      return AnimatedSwitcher(
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    200),
                                                        child: frame != null
                                                            ? child
                                                            : const SizedBox(
                                                                height: 60,
                                                                width: 60,
                                                                child: CircularProgressIndicator(
                                                                    strokeWidth:
                                                                        6),
                                                              ),
                                                      );
                                                    },
                                                  ),
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        width: size.width * 0.7,
                                                        height: 50,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                theme
                                                                    .colorScheme
                                                                    .primary,
                                                            textStyle:
                                                                TextStyle(
                                                              color: theme
                                                                  .colorScheme
                                                                  .onPrimary,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20,
                                                            ),
                                                            foregroundColor:
                                                                theme
                                                                    .colorScheme
                                                                    .onPrimary,
                                                          ),
                                                          child: const Text(
                                                              "Generate"),
                                                          onPressed: () async {
                                                            String
                                                                generateRandomString(
                                                                    int len) {
                                                              var r = Random();
                                                              const chars =
                                                                  'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                                                              return List.generate(
                                                                  len,
                                                                  (index) => chars[
                                                                      r.nextInt(
                                                                          chars
                                                                              .length)]).join();
                                                            }

                                                            Uri url = Uri.parse(
                                                                "https://api.multiavatar.com/${(profileData['fullname'] ?? "").replaceAll(" ", "+")}+${generateRandomString(10)}.png");
                                                            setState(() =>
                                                                (globalStatus =
                                                                    "loading"));
                                                            http.Response
                                                                response =
                                                                await http
                                                                    .get(url);
                                                            if (response
                                                                    .statusCode ==
                                                                200) {
                                                              setState(() =>
                                                                  (globalStatus =
                                                                      "idle"));
                                                            } else {
                                                              setState(() =>
                                                                  (globalStatus =
                                                                      "fail"));
                                                            }
                                                            setState(() {
                                                              imageRequested =
                                                                  response
                                                                      .bodyBytes;
                                                            });
                                                            globalStatus =
                                                                "idle";
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      SizedBox(
                                                        width: size.width * 0.7,
                                                        height: 50,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                theme
                                                                    .colorScheme
                                                                    .primary,
                                                            textStyle:
                                                                TextStyle(
                                                              color: theme
                                                                  .colorScheme
                                                                  .onPrimary,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20,
                                                            ),
                                                            foregroundColor:
                                                                theme
                                                                    .colorScheme
                                                                    .onPrimary,
                                                          ),
                                                          child: const Text(
                                                              "Save"),
                                                          onPressed: () async {
                                                            Uri url = Uri.parse(
                                                                "$api$userImageUpdateRoute");
                                                            http.MultipartRequest
                                                                request =
                                                                http.MultipartRequest(
                                                                    'POST',
                                                                    url);
                                                            request.headers
                                                                .addAll({
                                                              "Authorization":
                                                                  "Bearer $publicToken",
                                                              "Content-Type":
                                                                  "application/json"
                                                            });
                                                            request.files.add(
                                                              http.MultipartFile
                                                                  .fromBytes(
                                                                "file",
                                                                imageRequested,
                                                                filename:
                                                                    "${profileData['fullname']}_generate",
                                                              ),
                                                            );

                                                            // print(request.files.first);
                                                            setState(() =>
                                                                (globalStatus =
                                                                    "loading"));
                                                            http.StreamedResponse
                                                                response =
                                                                await request
                                                                    .send();
                                                            http.Response res =
                                                                await http
                                                                        .Response
                                                                    .fromStream(
                                                                        response);
                                                            if (res.statusCode ==
                                                                200) {
                                                              setState(() =>
                                                                  (globalStatus =
                                                                      "success"));
                                                              animationController
                                                                  .reset();
                                                              await Future.delayed(
                                                                  const Duration(
                                                                      seconds:
                                                                          1));
                                                            } else {
                                                              setState(() =>
                                                                  (globalStatus =
                                                                      "fail"));
                                                            }
                                                            if (res.statusCode ==
                                                                200) {
                                                              dynamic
                                                                  responseJson =
                                                                  json.decode(
                                                                      res.body);
                                                              profileData[
                                                                      'imgPath'] =
                                                                  "https://pyygounrrwlsziojzlmu.supabase.co/storage/v1/object/public/${responseJson['fullPath']}";
                                                              setState(() {});
                                                            } else if (res
                                                                    .statusCode ==
                                                                403) {
                                                              if (context
                                                                  .mounted) {
                                                                // int newTokenStatusReturn =
                                                                await requestNewToken(
                                                                    context);
                                                              }
                                                            }
                                                            debugPrint(
                                                                res.body);
                                                            if (context
                                                                .mounted) {
                                                              editImageProfileBoxController
                                                                  .closeBox();
                                                              Navigator.pop(
                                                                  context);
                                                            }
                                                            globalStatus =
                                                                "idle";
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text("Choose your image"),
                  tileColor: Colors.white,
                  trailing: const Icon(Icons.image),
                  onTap: () {
                    void doImage({ImageSource? source}) async {
                      File? imageSelectedFile = await getImage(source: source);
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
                          File(imageSelectedFile.path).readAsBytesSync(),
                          filename: imageSelectedFile.path,
                        ),
                      );
                      // print(request.files.first);
                      if (!context.mounted) return;
                      showDialog(
                        context: context,
                        builder: (context) {
                          return PopScope(
                            canPop: false,
                            child: Dialog.fullscreen(
                              backgroundColor: Colors.transparent,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: customColors["main"]!,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                      http.StreamedResponse response = await request.send();
                      http.Response res =
                          await http.Response.fromStream(response);
                      if (!context.mounted) return;
                      Navigator.pop(context);
                      if (res.statusCode == 200) {
                        dynamic responseJson = json.decode(res.body);
                        var nowParam =
                            DateFormat('yyyyddMMHHmm').format(DateTime.now());
                        print(nowParam);
                        profileData['imgPath'] =
                            "https://pyygounrrwlsziojzlmu.supabase.co/storage/v1/object/public/${responseJson['fullPath']}#$nowParam";

                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: customColors["main"]!,
                            content: Text(
                              "Image uploaded successfully. Please wait for a moment.",
                              style: theme.textTheme.bodyMedium!.copyWith(
                                color: customColors["onMain"]!,
                              ),
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        setState(() {});
                      } else if (res.statusCode == 403) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: customColors["main"]!,
                            content: Text(
                              "Error: 403 Forbidden, Please try again later.",
                              style: theme.textTheme.bodyMedium!.copyWith(
                                color: customColors["onMain"]!,
                              ),
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        // int newTokenStatusReturn =
                        await requestNewToken(context);
                      }
                      editImageProfileBoxController.closeBox();
                    }

                    showDialog(
                      context: context,
                      builder: (context) {
                        CustomThemes ruammitrThemeData =
                            ThemesPortal.appThemeFromContext(
                                context, "RuamMitr")!;
                        ThemeData theme = ruammitrThemeData.themeData;
                        Map<String, Color> customColors =
                            ruammitrThemeData.customColors;

                        return SimpleDialog(
                          alignment: Alignment.center,
                          backgroundColor: customColors["evenContainer"],
                          surfaceTintColor: customColors["evenContainer"],
                          shadowColor: Colors.black38,
                          elevation: 4,
                          title: Text(
                            "Get Your Image From",
                            style: theme.textTheme.headlineLarge!.copyWith(
                              color: customColors["onEvenContainer"],
                            ),
                          ),
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  doImage(source: ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: customColors["oddContainer"]!
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        color: customColors["onOddContainer"]!,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Camera",
                                        style: theme.textTheme.titleLarge!
                                            .copyWith(
                                          color:
                                              customColors["onOddContainer"]!,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  doImage(source: ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: customColors["oddContainer"]!
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.photo_library_outlined,
                                        color: customColors["onOddContainer"]!,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Gallery",
                                        style: theme.textTheme.titleLarge!
                                            .copyWith(
                                          color:
                                              customColors["onOddContainer"]!,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
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
