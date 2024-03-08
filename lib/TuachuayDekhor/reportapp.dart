import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class TuachuayDekhorReportAppPage extends StatefulWidget {
  const TuachuayDekhorReportAppPage({super.key});

  @override
  State<TuachuayDekhorReportAppPage> createState() =>
      _TuachuayDekhorReportAppPageState();
}

class _TuachuayDekhorReportAppPageState
    extends State<TuachuayDekhorReportAppPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController explanationController = TextEditingController();
  TextEditingController imageSelectionController = TextEditingController();
  GlobalKey<FormFieldState> titleKey = GlobalKey();
  GlobalKey<FormFieldState> explanationKey = GlobalKey();
  File? imageSelected;
  bool status = false;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        imageSelected = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _sendReport() async {
    try {
      if (titleKey.currentState!.validate() &&
          explanationKey.currentState!.validate()) {
        Uri url = Uri.parse("$api$userPostIssueRoute");
        http.MultipartRequest request = http.MultipartRequest('POST', url);
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
              contentType: MediaType.parse(
                  lookupMimeType(imageSelected!.path) ?? "image/jpeg"),
            ),
          );
        }
        request.fields['type'] = "dekhor";
        request.fields['title'] = titleController.text;
        request.fields['description'] = explanationController.text;
        http.StreamedResponse res = await request.send();
        debugPrint(res.statusCode.toString());
        http.Response response = await http.Response.fromStream(res);
        debugPrint(response.body);
        if (response.statusCode == 200) {
          status = true;
        } else {
          status = false;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void onBackPressed(Map<String, Color> customColors) {
    if (titleController.text.isNotEmpty ||
        explanationController.text.isNotEmpty ||
        imageSelected != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            surfaceTintColor: customColors["background"],
            backgroundColor: customColors["background"],
            iconColor: customColors["main"],
            icon: Icon(
              Icons.report_off,
              size: 50,
              color: customColors["onContainer"],
            ),
            title: Text(
              "Discard report?",
              style: TextStyle(
                color: customColors["onContainer"],
                fontWeight: FontWeight.bold,
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
                    print("Discard report");
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CustomThemes theme =
        ThemesPortal.appThemeFromContext(context, "TuachuayDekhor")!;
    Map<String, Color> customColors = theme.customColors;

    return Scaffold(
      backgroundColor: customColors["background"]!,
      body: SafeArea(
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: size.height -
                        [size.width * 0.4, 100.0].reduce(min) -
                        MediaQuery.of(context).padding.top,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.12,
                      left: size.width * 0.04,
                      right: size.width * 0.04,
                    ),
                    child: Column(
                      children: [
                        PopScope(
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
                                  color: customColors["main"],
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Back",
                                  style: TextStyle(
                                    color: customColors["main"],
                                  ),
                                ),
                              ],
                            ),
                            onTap: () => onBackPressed(customColors),
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            "REPORT APP",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: customColors["main"],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(
                            top: size.height * 0.02,
                            bottom: size.height * 0.03,
                          ),
                          child: Text(
                            "Title :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: customColors["onContainer"],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: size.width * 0.02,
                            right: size.width * 0.02,
                            bottom: size.height * 0.03,
                          ),
                          child: TextFormField(
                            key: titleKey,
                            maxLength: 30,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            controller: titleController,
                            cursorColor: customColors["textInput"],
                            style: TextStyle(
                              color: customColors["textInput"],
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: customColors["textInputContainer"],
                              counterText: "",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if ((value ?? "").isEmpty) {
                                return "Report must have topic";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              titleKey.currentState!.validate();
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(
                            bottom: size.height * 0.03,
                          ),
                          child: Text(
                            "Explanation :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: customColors["onContainer"],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: size.width * 0.02,
                            right: size.width * 0.02,
                            bottom: size.height * 0.03,
                          ),
                          child: TextFormField(
                            key: explanationKey,
                            controller: explanationController,
                            maxLines: 4,
                            maxLength: 200,
                            cursorColor: customColors["textInput"],
                            style: TextStyle(
                              color: customColors["textInput"],
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: customColors["textInputContainer"],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if ((value ?? "").isEmpty) {
                                return "Please explain about the report";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              explanationKey.currentState!.validate();
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(
                            bottom: size.height * 0.03,
                          ),
                          child: Text(
                            "Image (Not Required) :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: customColors["onContainer"],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: size.width * 0.02,
                            right: size.width * 0.02,
                            bottom: size.height * 0.05,
                          ),
                          child: TextFormField(
                            readOnly: true,
                            maxLines: 1,
                            controller: imageSelectionController,
                            cursorColor: customColors["textInput"],
                            style: TextStyle(
                              color: customColors["textInput"],
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: customColors["textInputContainer"],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(
                                Icons.file_upload_outlined,
                                color: customColors["onContainer"],
                              ),
                              hintText: "Upload Your Screenshot",
                            ),
                            onTap: () async {
                              await _getImage();
                              if (imageSelected == null) {
                              } else {
                                imageSelectionController.text =
                                    imageSelected!.path.split("/").last;
                              }
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: size.height * 0.02),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor:
                                    const Color.fromRGBO(217, 192, 41, 1),
                                surfaceTintColor: Colors.white,
                                minimumSize: const Size(150, 35)),
                            onPressed: () async {
                              await _sendReport();
                              status
                                  ? (
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: customColors["main"],
                                          content: Text(
                                            "Report sent successfully",
                                            style: TextStyle(
                                              color: customColors["onMain"],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Navigator.pushNamed(context,
                                          tuachuayDekhorPageRoute["home"]!)
                                    )
                                  : ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor:
                                            Color.fromRGBO(214, 40, 40, 1),
                                        content: Text(
                                          "Report sent failed",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                              print("Sending report");
                            },
                            child: const Text(
                              "SEND",
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const NavbarTuachuayDekhor(),
            ],
          ),
        ),
      ),
    );
  }
}
