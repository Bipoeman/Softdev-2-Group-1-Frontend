import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ruam_mitt/global_const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TuachuayDekhorAdminPage extends StatefulWidget {
  const TuachuayDekhorAdminPage({Key? key}) : super(key: key);

  @override
  State<TuachuayDekhorAdminPage> createState() =>
      _TuachuayDekhorAdminPageState();
}

class _TuachuayDekhorAdminPageState extends State<TuachuayDekhorAdminPage> {
  late List<dynamic> item;
  late List<dynamic> report;
  final reporturl = Uri.parse("$api$dekhorShowReportRoute");
  final deleteurl = Uri.parse("$api$dekhorDeleteReportRoute");

  @override
  void initState() {
    super.initState();
    item = [];
    report = [];
    namereport();
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
    var id_report = report[index]['id_report'];
    var deleteurl = Uri.parse("$api$dekhorDeleteReportRoute/$id_report");
    await http.delete(deleteurl);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: size.height -
                    [size.width * 0.4, 100.0].reduce(min) -
                    MediaQuery.of(context).padding.top),
            child: Column(
              children: [
                Container(
                  color: const Color.fromRGBO(0, 48, 73, 1),
                  width: size.width,
                  height: size.width * 0.2,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.pushNamed(
                          context, tuachuayDekhorPageRoute["home"]!);
                    },
                    child: const Image(
                      image: AssetImage(
                          "assets/images/Logo/TuachuayDekhor_Dark.png"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.width * 0.05, bottom: size.width * 0.05),
                  child: const Text(
                    "ALL REPORTS",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
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
                            const SnackBar(
                              content: Text("Item dismissed"),
                            ),
                          );
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 10),
                          color: Colors.red,
                          child: const Icon(Icons.delete),
                        ),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          color: Colors.grey[300],
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(context,
                                  tuachuayDekhorPageRoute["detailreport"]!,
                                  arguments: report[index]['id_report']);
                            },
                            title: Text(
                              currentItem,
                              style: const TextStyle(
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
