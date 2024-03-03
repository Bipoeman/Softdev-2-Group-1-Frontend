import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:http/http.dart' as http;
import "package:ruam_mitt/global_const.dart";

class TuachuayDekhorReportPage extends StatefulWidget {
  final int id_post;
  final int id_blogger;
  const TuachuayDekhorReportPage({super.key, required this.id_post, required this.id_blogger});

  @override
  State<TuachuayDekhorReportPage> createState() => _TuachuayDekhorReportPageState();
}

class _TuachuayDekhorReportPageState extends State<TuachuayDekhorReportPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  late int id_post;
  late int id_blogger;
  late Uri reporturl;
  void initState() {
    super.initState();
    id_post = widget.id_post;
    id_blogger = widget.id_blogger;
    reporturl = Uri.parse("$api$dekhorReportRoute/$id_post/$id_blogger");
  }

  Future<void> reportblog() async {
    await http
        .post(reporturl, body: {"title": titleController.text, "reason": reasonController.text});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CustomThemes theme = ThemesPortal.appThemeFromContext(context, "TuachuayDekhor")!;
    Map<String, Color> customColors = theme.customColors;

    return Scaffold(
      backgroundColor: customColors["background"],
      body: SafeArea(
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
                      GestureDetector(
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
                        onTap: () {
                          if (titleController.text.isNotEmpty || reasonController.text.isNotEmpty) {
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
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.red),
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
                        },
                      ),
                      SizedBox(
                        child: Text(
                          "REPORT",
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
                          "Do you want to report this blog?",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300,
                            color: customColors["onContainer"],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(
                          bottom: size.height * 0.03,
                        ),
                        child: Text(
                          "Yours title :",
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
                          textInputAction: TextInputAction.next,
                          controller: titleController,
                          cursorColor: customColors["textInput"],
                          style: TextStyle(
                            fontSize: 12,
                            color: customColors["textInput"],
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: customColors["textInputContainer"],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(
                          bottom: size.height * 0.03,
                        ),
                        child: Text(
                          "Yours reason :",
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
                          controller: reasonController,
                          maxLines: 5,
                          cursorColor: customColors["textInput"],
                          style: TextStyle(
                            fontSize: 12,
                            color: customColors["textInput"],
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: customColors["textInputContainer"],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: const Color.fromRGBO(217, 192, 41, 1),
                            surfaceTintColor: Colors.white,
                            minimumSize: const Size(150, 35)),
                        onPressed: () {
                          reportblog();
                          Navigator.pushNamed(context, tuachuayDekhorPageRoute["home"]!);
                          print("Sending report");
                        },
                        child: const Text(
                          "SEND",
                          style: TextStyle(fontWeight: FontWeight.w900),
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
    );
  }
}
