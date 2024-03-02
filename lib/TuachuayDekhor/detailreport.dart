import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TuachuayDekhorDetailReportPage extends StatefulWidget {
  const TuachuayDekhorDetailReportPage(
      {super.key, required this.id_post, required this.id_report});
  final int id_post;
  final int id_report;

  @override
  State<TuachuayDekhorDetailReportPage> createState() =>
      _TuachuayDekhorDetailReportPageState();
}

class _TuachuayDekhorDetailReportPageState
    extends State<TuachuayDekhorDetailReportPage> {
  late List<dynamic> report;
  late Uri deleteposturl;
  late Uri deletereporturl;
  late Uri detailreporturl;
  late int id_post;
  late int id_report;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    id_post = widget.id_post;
    id_report = widget.id_report;
    print("ID REPORT $id_report");
    deleteposturl = Uri.parse("$api$dekhorDeletePostRoute/$id_post");
    deletereporturl = Uri.parse("$api$dekhorDeleteReportRoute/$id_report");
    detailreporturl = Uri.parse("$api$dekhorDetailReportRoute/$id_report");
    _loadDetail();
    report = [];
  }

  Future<void> _loadDetail() async {
    setState(() {
      isLoading = true;
    });

    await detailreport();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> deletepost() async {
    await http.delete(deleteposturl);
  }

  Future<void> deleteReport() async {
    await http.delete(deletereporturl);
  }

  Future<void> detailreport() async {
    var response = await http.get(detailreporturl);
    if (response.statusCode == 200) {
      setState(() {
        report = jsonDecode(response.body);
        print('REPORT $report');
      });
    } else {
      throw Exception('Failed to load data');
    }
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
            : SingleChildScrollView(
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
                          top: size.width * 0.04,
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
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            size.width * 0.1,
                            size.width * 0.04,
                            size.width * 0.1,
                            size.width * 0.04),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Title:",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                (report.isNotEmpty &&
                                        report[0]['title'] != null)
                                    ? report[0]['title']
                                    : "No title",
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(size.width * 0.1, 0,
                            size.width * 0.1, size.width * 0.08),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Reason:",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                (report.isNotEmpty &&
                                        report[0]['reason'] != null)
                                    ? report[0]['reason']
                                    : "No reason",
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(size.width * 0.1, 0,
                            size.width * 0.1, size.width * 0.04),
                        padding: EdgeInsets.all(size.width * 0.04),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 48, 73, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        (report.isNotEmpty &&
                                                report[0]['user']['profile'] !=
                                                    null)
                                            ? report[0]['user']['profile']
                                            : "https://api.multiavatar.com/${report[0]['user']['fullname']}.png",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: size.width * 0.04),
                                Text(
                                  (report.isNotEmpty &&
                                          report[0]['user']['fullname'] != null)
                                      ? report[0]['user']['fullname']
                                      : "No name",
                                  style: TextStyle(color: Colors.white),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    deletepost();
                                    deleteReport();
                                    print("delete");
                                    Navigator.pushNamed(context,
                                        tuachuayDekhorPageRoute["admin"]!);
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.width * 0.04),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Title:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    (report.isNotEmpty &&
                                            report[0]['detail']['title'] !=
                                                null)
                                        ? report[0]['detail']['title']
                                        : "No title",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.width * 0.04),
                            Container(
                              constraints: const BoxConstraints(maxHeight: 200),
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(),
                              child: IntrinsicHeight(
                                child: Image(
                                  image: NetworkImage(
                                    (report.isNotEmpty &&
                                            report[0]['detail']['image_link'] !=
                                                null)
                                        ? report[0]['detail']['image_link']
                                        : 'no image',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: size.width * 0.04),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Content:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    (report.isNotEmpty &&
                                            report[0]['detail']['content'] !=
                                                null)
                                        ? report[0]['detail']['content']
                                        : 'no content',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
