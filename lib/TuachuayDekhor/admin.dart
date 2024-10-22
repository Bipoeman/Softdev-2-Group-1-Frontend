import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TuachuayDekhorAdminPage extends StatefulWidget {
  const TuachuayDekhorAdminPage({super.key});

  @override
  State<TuachuayDekhorAdminPage> createState() =>
      _TuachuayDekhorAdminPageState();
}

class _TuachuayDekhorAdminPageState extends State<TuachuayDekhorAdminPage> {
  late List<dynamic> item;
  late List<dynamic> report;
  final reporturl = Uri.parse("$api$dekhorShowReportRoute");
  final deleteurl = Uri.parse("$api$dekhorDeleteReportRoute");
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    item = [];
    report = [];
    _loadDetail();
  }

  Future<void> namereport() async {
    var response = await http.get(reporturl);
    if (response.statusCode == 200) {
      setState(() {
        report = jsonDecode(response.body);
        item = List.generate(
            report.length, (index) => 'Title : ${report[index]['title']}');
        print(report);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> deleteReport(int index) async {
    var idReport = report[index]['id_report'];
    var deleteurl = Uri.parse("$api$dekhorDeleteReportRoute/$idReport");
    await http.delete(deleteurl);
  }

  Future<void> _loadDetail() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    await namereport();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CustomThemes theme =
        ThemesPortal.appThemeFromContext(context, "TuachuayDekhor")!;
    bool isDarkMode =
        ThemesPortal.getCurrent(context).isDarkMode("TuachuayDekhor");
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
            : SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: size.height -
                          [size.width * 0.4, 100.0].reduce(min) -
                          MediaQuery.of(context).padding.top),
                  child: Column(
                    children: [
                      Container(
                        color: customColors["main"],
                        width: size.width,
                        height: size.width * 0.2,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image(
                            image: AssetImage(
                              "assets/images/Logo/TuachuayDekhor_${isDarkMode ? "Light" : "Dark"}.png",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.width * 0.05, bottom: size.width * 0.05),
                        child: Text(
                          "ALL REPORTS",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: customColors["onContainer"],
                          ),
                        ),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: item.length,
                        itemBuilder: (context, index) {
                          final currentItem = item[index];
                          return Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                            child: Dismissible(
                              key: Key(currentItem),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                setState(() {
                                  deleteReport(index);
                                  item.removeAt(index);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: customColors["container"],
                                    content: Text(
                                      "Report dismissed",
                                      style: TextStyle(
                                        color: customColors["onContainer"],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 10),
                                color: Colors.red,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                color: customColors["container"],
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      tuachuayDekhorPageRoute["detailreport"]!,
                                      arguments: {
                                        'id_post': report[index]['id_post'],
                                        'id_report': report[index]['id_report'],
                                      },
                                    );
                                  },
                                  title: Text(
                                    currentItem,
                                    style: TextStyle(
                                      color: customColors["onContainer"],
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
