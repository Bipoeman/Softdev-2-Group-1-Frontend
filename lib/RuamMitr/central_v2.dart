import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/loading_screen.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/RuamMitr/home_v2.dart';
import 'package:ruam_mitt/RuamMitr/profile_v2.dart';
import 'package:ruam_mitt/RuamMitr/settings_v2.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:http/http.dart' as http;
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageV2 extends StatefulWidget {
  const HomePageV2({super.key});

  @override
  State<HomePageV2> createState() => _HomePageV2State();
}

class _HomePageV2State extends State<HomePageV2> {
  int pageIndex = 1;
  PageController pageController = PageController(initialPage: 1);
  GlobalKey<FormState> reportFormKey = GlobalKey();
  // GlobalKey<FormFieldState> appSelectKey = GlobalKey();
  TextEditingController titleController = TextEditingController();
  TextEditingController explanationController = TextEditingController();
  TextEditingController imageSelectionController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode explanationFocusNode = FocusNode();
  File? imageSelected;

  Future<File?> getImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    //TO convert Xfile into file
    File file = File(image.path);
    //debugPrint(‘Image picked’);
    return file;
  }

  @override
  void initState() {
    super.initState();
    // debugPrint("Home Ruammitr InitState");
    Uri uri = Uri.parse("$api$userDataRequestRoute");
    setState(() {});
    http.get(
      uri,
      headers: {"Authorization": "Bearer $publicToken"},
    ).then(
      (http.Response res) {
        profileData = jsonDecode(res.body);
        if (!isDashboardTimerActive) {
          isDashboardTimerActive = true;
          dashboardTimer = Timer.periodic(
            const Duration(seconds: 5),
            (timer) async {
              currentActiveTimer++;
              try {
                await http.get(
                  Uri.parse("$api$userDataRequestRoute"),
                  headers: {"Authorization": "Bearer $publicToken"},
                ).then(
                  (res) {
                    if (res.statusCode == 200) {
                      profileData = jsonDecode(res.body);
                      if (timeoutCount > 1) {
                        Navigator.pop(context);
                        timeoutCount = 0;
                      }
                    } else {
                      timeoutCount++;
                    }
                  },
                );
              } catch (e) {
                debugPrint(e.toString());
                timeoutCount++;
              }
              if (!context.mounted) return;
              if (timeoutCount == 2) {
                showLoadingScreen(context: context, message: "Getting User Info.");
              } else if (timeoutCount == 3) {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    CustomThemes customThemes =
                        ThemesPortal.appThemeFromContext(context, "RuamMitr")!;
                    return PopScope(
                      canPop: false,
                      child: AlertDialog(
                        backgroundColor: customThemes.customColors["evenContainer"],
                        icon: Icon(
                          Icons.wifi_off,
                          color: customThemes.customColors["onEvenContainer"]!.withOpacity(0.75),
                          size: 48,
                        ),
                        title: Text(
                          "Failed to Get User Info. Exiting...",
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: customThemes.customColors["onevenContainer"],
                            fontFamily: customThemes.themeData.textTheme.bodyLarge!.fontFamily,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (timeoutCount > 3) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool("isChecked", false);
                isOnceLogin = true;
                publicToken = "";
                profileData = {};
                isDashboardTimerActive = false;
                currentActiveTimer = 0;
                timeoutCount = 0;
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginPageRoute,
                    (Route<dynamic> route) => false,
                  );
                }
                timer.cancel();
              }
            },
          );
        }
        setState(() {});
      },
    );
  }

  void _showConfirmExit() {
    showDialog(
      context: context,
      builder: (context) {
        CustomThemes customTheme = ThemesPortal.appThemeFromContext(context, "RuamMitr")!;
        ThemeData theme = customTheme.themeData;
        Map<String, Color> customColors = customTheme.customColors;
        return AlertDialog(
          backgroundColor: customColors["evenContainer"],
          surfaceTintColor: customColors["evenContainer"],
          shadowColor: Colors.black38,
          elevation: 4,
          title: Text(
            "Exit?",
            style: theme.textTheme.headlineLarge!.copyWith(
              color: customColors["onEvenContainer"],
            ),
          ),
          content: Text(
            "Do you want to exit the app?",
            style: theme.textTheme.bodyLarge!.copyWith(
              color: customColors["onEvenContainer"],
            ),
          ),
          actions: [
            InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(10),
              child: Ink(
                width: 75,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "No",
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: customColors["onEvenContainer"],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => SystemNavigator.pop(),
              borderRadius: BorderRadius.circular(10),
              child: Ink(
                width: 75,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Yes",
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: customColors["onEvenContainer"],
                    ),
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
    ThemeProvider themes = Provider.of<ThemeProvider>(context);
    ThemeData theme = themes.themeFrom("RuamMitr")!.themeData;
    BoxController reportBoxController = BoxController();
    var nowParam = DateFormat('yyyyddMMHHmm').format(DateTime.now());
    if (profileData['profile'] != null) {
      profileData['imgPath'] = "${profileData['profile']}#$nowParam";
    } else {
      profileData['imgPath'] =
          "https://api.multiavatar.com/${(profileData['fullname'] ?? "").replaceAll(" ", "+")}.png";
    }
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        _showConfirmExit();
      },
      child: Container(
        decoration: ruamMitrBackgroundGradient(themes),
        child: Theme(
          data: theme,
          child: Builder(
            builder: (context) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                bottomNavigationBar: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  color: theme.colorScheme.primaryContainer,
                  child: SalomonBottomBar(
                    currentIndex: pageIndex,
                    onTap: (pageViewSelectedIndex) {
                      pageController.animateToPage(
                        pageViewSelectedIndex,
                        duration: const Duration(seconds: 1),
                        curve: const Tanh(),
                      );
                    },
                    selectedItemColor: theme.colorScheme.brightness == Brightness.light
                        ? theme.colorScheme.primary
                        : Colors.white,
                    items: [
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.person),
                        title: const Text("Profile"),
                      ),
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.home),
                        title: const Text("Home"),
                      ),
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.settings),
                        title: const Text("Settings"),
                      ),
                    ],
                  ),
                ),
                body: SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView(
                          controller: pageController,
                          onPageChanged: (pageChanged) {
                            setState(() => pageIndex = pageChanged);
                            debugPrint("Changed to page $pageChanged");
                          },
                          children: [
                            profileData['fullname'] == null
                                ? const Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(),
                                        Divider(),
                                        Text("Loading user data"),
                                      ],
                                    ),
                                  )
                                : const ProfileWidgetV2(),
                            profileData['fullname'] == null
                                ? const Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(),
                                        Divider(),
                                        Text("Loading user data"),
                                      ],
                                    ),
                                  )
                                : HomeWidgetV2(
                                    reportBoxController: reportBoxController,
                                    pageIndexSetter: (page) {
                                      setState(() {
                                        pageIndex = page;
                                        pageController.animateToPage(
                                          page,
                                          duration: const Duration(seconds: 1),
                                          curve: const Tanh(),
                                        );
                                      });
                                    },
                                  ),
                            SettingsWidgetV2(
                              reportBoxController: reportBoxController,
                              pageIndexSetter: (page) {
                                setState(() {
                                  pageIndex = page;
                                  pageController.animateToPage(
                                    page,
                                    duration: const Duration(seconds: 1),
                                    curve: const Tanh(),
                                  );
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      SlidingBox(
                        onBoxClose: () {
                          reportFormKey.currentState?.reset();
                        },
                        draggableIcon: Icons.keyboard_arrow_down_rounded,
                        controller: reportBoxController,
                        collapsed: true,
                        draggable: false,
                        draggableIconVisible: true,
                        minHeight: 0,
                        maxHeight: size.height * 0.6,
                        color: theme.colorScheme.primaryContainer,
                        body: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: size.width,
                          child: Form(
                            // onChanged: () {
                            //   debugPrint("something change in the form");
                            // },
                            key: reportFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 20),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Report",
                                          style: TextStyle(
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall
                                                  ?.fontSize,
                                              fontFamily: GoogleFonts.getFont("Inter").fontFamily,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Center(
                                          child: IconButton(
                                            onPressed: () {
                                              if (titleController.text.trim().isNotEmpty ||
                                                  explanationController.text.trim().isNotEmpty ||
                                                  imageSelectionController.text.isNotEmpty) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return discardReportConfirm(
                                                          theme, size, context,
                                                          onAnswer: (isConfirm) {
                                                        if (isConfirm) {
                                                          if (explanationFocusNode.hasFocus) {
                                                            explanationFocusNode.unfocus();
                                                          }
                                                          if (titleFocusNode.hasFocus) {
                                                            titleFocusNode.unfocus();
                                                          }
                                                          reportFormKey.currentState?.reset();
                                                          imageSelectionController.clear();
                                                          titleController.clear();
                                                          explanationController.clear();
                                                          reportBoxController.closeBox();
                                                        }
                                                        Navigator.pop(context);
                                                      });
                                                    });
                                              } else {
                                                if (explanationFocusNode.hasFocus) {
                                                  explanationFocusNode.unfocus();
                                                }
                                                if (titleFocusNode.hasFocus) {
                                                  titleFocusNode.unfocus();
                                                }
                                                reportFormKey.currentState?.reset();
                                                imageSelectionController.clear();
                                                titleController.clear();
                                                explanationController.clear();
                                                reportBoxController.closeBox();
                                              }
                                              setState(() {});
                                            },
                                            icon: const Icon(Icons.close),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Text(
                                  "Title",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: GoogleFonts.getFont("Inter").fontFamily,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.01),
                                TextFormField(
                                  maxLength: 30,
                                  focusNode: titleFocusNode,
                                  controller: titleController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: theme.colorScheme.background,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    prefixIcon: const Icon(Icons.title),
                                    counterText: "",
                                    suffixIcon: titleController.text.isNotEmpty
                                        ? GestureDetector(
                                            onTap: titleController.clear,
                                            child: const Icon(Icons.clear))
                                        : null,
                                    hintText: "Title",
                                  ),
                                  validator: (value) {
                                    if ((value ?? "").isEmpty) {
                                      return "Report must have topic";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    reportFormKey.currentState!.validate();
                                    setState(() {});
                                  },
                                ),
                                SizedBox(height: size.height * 0.01),
                                Text(
                                  "Explanation",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: GoogleFonts.getFont("Inter").fontFamily,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.01),
                                TextFormField(
                                  focusNode: explanationFocusNode,
                                  controller: explanationController,

                                  // minLines: 1,
                                  maxLines: 4,
                                  maxLength: 200,
                                  decoration: InputDecoration(
                                    filled: true,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.all(6),
                                    fillColor: theme.colorScheme.background,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  validator: (value) {
                                    if ((value ?? "").isEmpty) {
                                      return "Please explain about the report";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    reportFormKey.currentState!.validate();
                                  },
                                ),
                                SizedBox(height: size.height * 0.01),
                                Text(
                                  "Upload Photo (Not Required)",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: GoogleFonts.getFont("Inter").fontFamily,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.01),
                                TextFormField(
                                  maxLines: 1,
                                  readOnly: true,
                                  controller: imageSelectionController,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.upload),
                                    filled: true,
                                    fillColor: theme.colorScheme.background,
                                    hintText: "Upload Your Screenshot",
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                  ),
                                  onTap: () async {
                                    // debugPrint("Want to upload report picture");
                                    imageSelected = await getImage();
                                    if (imageSelected == null) {
                                    } else {
                                      imageSelectionController.text =
                                          imageSelected!.path.split("/").last;
                                    }
                                  },
                                ),
                                SizedBox(height: size.height * 0.025),
                                SizedBox(
                                  width: double.infinity,
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
                                    child: const Text("Send"),
                                    onPressed: () async {
                                      debugPrint("Validated");
                                      if (reportFormKey.currentState!.validate()) {
                                        Uri url = Uri.parse("$api$userPostIssueRoute");
                                        http.MultipartRequest request =
                                            http.MultipartRequest('POST', url);
                                        request.headers.addAll({
                                          "Authorization": "Bearer $publicToken",
                                          "Content-Type": "application/json"
                                        });
                                        if (imageSelected != null) {
                                          request.files.add(
                                            http.MultipartFile.fromBytes(
                                              "file",
                                              File(imageSelected!.path).readAsBytesSync(),
                                              filename: imageSelected!.path,
                                            ),
                                          );
                                        }
                                        request.fields['type'] = "ruammitr";
                                        request.fields['title'] = titleController.text;
                                        request.fields['description'] = explanationController.text;
                                        // debugPrint(request.files.first);
                                        http.StreamedResponse res = await request.send();
                                        http.Response response =
                                            await http.Response.fromStream(res);
                                        debugPrint(response.body);
                                        reportFormKey.currentState?.reset();
                                        imageSelectionController.clear();
                                        titleController.clear();
                                        explanationController.clear();
                                        reportBoxController.closeBox();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  AlertDialog discardReportConfirm(
    ThemeData theme,
    Size size,
    BuildContext context, {
    required void Function(bool isConfirm) onAnswer,
  }) {
    return AlertDialog(
      backgroundColor: theme.colorScheme.primaryContainer,
      surfaceTintColor: theme.colorScheme.primaryContainer,
      title: const Text("Discard report?"),
      actions: [
        InkWell(
          child: Ink(
              width: size.width * 0.2,
              height: size.width * 0.2 * 0.5,
              decoration: BoxDecoration(
                // color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Text("No",
                      style: TextStyle(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )))),
          onTap: () {
            onAnswer(false);
          },
        ),
        InkWell(
          child: Ink(
            width: size.width * 0.2,
            height: size.width * 0.2 * 0.8,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          onTap: () {
            onAnswer(true);
          },
        ),
      ],
    );
  }
}

class Tanh extends Curve {
  final double count;

  const Tanh({this.count = 3});

  // t = x
  @override
  double transformInternal(double t) {
    t *= 3.5;
    var val = (exp(t) - exp(-t)) / (exp(t) + exp(-t));
    return val; //f(x)
  }
}
