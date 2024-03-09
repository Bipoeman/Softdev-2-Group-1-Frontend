import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:http/http.dart';
import 'package:ruam_mitt/global_var.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class ReportData {
  late Map<String, bool> isInitiallyBlank;
  late Map<String, TextEditingController> fieldController;
  late Map<String, dynamic> userData;
  ReportData(List<String> fields) {
    isInitiallyBlank = {for (var element in fields) element: true};
    fieldController = {for (var element in fields) element: TextEditingController()};
  }
}

class _AdminPageState extends State<AdminPage> {
  int issueFocusIndex = 0;
  List<Map<String, dynamic>> issueList = [];
  List<Map<String, dynamic>> openIssueList = [];
  List<Map<String, dynamic>> aceptedIssueList = [];
  List<Map<String, dynamic>> rejectedIssueList = [];
  List<Map<String, dynamic>> closedIssueList = [];
  Map<String, dynamic> selectedIssue = {};
  ReportData reportDataDisplay = ReportData(["username", "title", "app", "description"]);

  bool isAccept = true;

  Future<void> getAllIssue() async {
    issueList = [];
    openIssueList = [];
    aceptedIssueList = [];
    rejectedIssueList = [];
    closedIssueList = [];
    Uri url = Uri.parse("$api$allIssueRoute");
    await get(url,
            headers: {"Authorization": "Bearer $publicToken", "Content-Type": "application/json"})
        .then((response) {
      openIssueList = [for (var element in jsonDecode(response.body)) element];
      debugPrint("Open issue request done");
    });

    url = Uri.parse("$api$aceptedIssueRoute");
    await get(url,
            headers: {"Authorization": "Bearer $publicToken", "Content-Type": "application/json"})
        .then((response) {
      aceptedIssueList = [for (var element in jsonDecode(response.body)) element];
      debugPrint("Acepted issue request done");
    });

    url = Uri.parse("$api$rejectedIssueRoute");
    await get(url,
            headers: {"Authorization": "Bearer $publicToken", "Content-Type": "application/json"})
        .then((response) {
      rejectedIssueList = [for (var element in jsonDecode(response.body)) element];
      debugPrint("Rejected issue request done");
      closedIssueList.addAll(aceptedIssueList);
      closedIssueList.addAll(rejectedIssueList);
      issueList.addAll(openIssueList);
      issueList.addAll(aceptedIssueList);
      issueList.addAll(rejectedIssueList);
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAllIssue();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    ThemeProvider themes = Provider.of<ThemeProvider>(context);
    BoxController issueDisplayBoxController = BoxController();
    CustomThemes customThemes = ThemesPortal.appThemeFromContext(context, "RuamMitr")!;

    return Theme(
      data: theme,
      child: Container(
        decoration: ruamMitrBackgroundGradient(themes),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios,
                color: customThemes.customColors["onMain"],
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: theme.colorScheme.primary,
            title: Text(
              "Administrator",
              style: TextStyle(
                color: customThemes.customColors["onMain"],
                fontWeight: FontWeight.bold,
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
          ),
          body: SlidingBox(
            onBoxOpen: () {
              // ["username", "title", "app", "description"]
              reportDataDisplay.fieldController['username']!.text = selectedIssue['id'].toString();
              reportDataDisplay.fieldController['title']!.text = selectedIssue['title'].toString();
              reportDataDisplay.fieldController['description']!.text =
                  selectedIssue['description'].toString();
              isAccept = (selectedIssue['status'] ?? "accepted") == "accepted" ? true : false;
              debugPrint("$selectedIssue");
              setState(() {});
            },
            minHeight: 0,
            maxHeight: size.height * 0.8,
            controller: issueDisplayBoxController,
            color: theme.colorScheme.primaryContainer,
            collapsed: true,
            body: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "User reports",
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                          fontFamily: GoogleFonts.getFont("Inter").fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          issueDisplayBoxController.closeBox();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  Text(
                    "Username",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.getFont("Inter").fontFamily,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  TextFormField(
                    maxLength: 30,
                    readOnly: true,
                    // focusNode: titleFocusNode,
                    controller: reportDataDisplay.fieldController['username'],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: theme.colorScheme.background,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      prefixIcon: const Icon(Icons.person),
                      counterText: "",
                      hintText: "Username",
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
                    controller: reportDataDisplay.fieldController['title'],
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: theme.colorScheme.background,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      prefixIcon: const Icon(Icons.title),
                      hintText: "Title",
                    ),
                    validator: (value) {
                      if ((value ?? "").isEmpty) {
                        return "Report must have topic";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    "Explaniation",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.getFont("Inter").fontFamily,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  TextFormField(
                    readOnly: true,
                    controller: reportDataDisplay.fieldController['description'],
                    maxLines: 4,
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.all(15),
                      fillColor: theme.colorScheme.background,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    "Uploaded Photo",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.getFont("Inter").fontFamily,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Container(
                    width: size.width,
                    height: size.height * 0.3,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.background,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: selectedIssue['picture'] != null
                        ? InkWell(
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
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: InteractiveViewer(
                                              maxScale: 10,
                                              child: Image.network(
                                                selectedIssue['picture'],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 30,
                                        right: 30,
                                        child: CircleAvatar(
                                          backgroundColor: theme.colorScheme.primary,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.close,
                                              color: theme.colorScheme.primaryContainer,
                                            ),
                                            onPressed: () => Navigator.pop(context),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                selectedIssue['picture'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : const Center(
                            child: Text("No image uploaded"),
                          ),
                  ),
                  SizedBox(height: size.height * 0.025),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: size.width * 0.025),
                      Text(
                        "Reject",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.getFont("Inter").fontFamily,
                        ),
                      ),
                      Switch(
                        value: isAccept,
                        onChanged: (value) {
                          setState(() {
                            isAccept = value;
                          });
                        },
                      ),
                      Text(
                        "Accept",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.getFont("Inter").fontFamily,
                        ),
                      ),
                      SizedBox(width: size.width * 0.025),
                    ],
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
                      child: const Text("Close Issue"),
                      onPressed: () async {
                        // selectedIssue['id']
                        Uri url = Uri.parse("$api$adminAcceptIssueRoute");
                        Response res = await put(url,
                            headers: {
                              "Authorization": "Bearer $publicToken",
                              "Content-Type": "application/json"
                            },
                            body:
                                jsonEncode({"accept": isAccept, "issue_id": selectedIssue['id']}));
                        // debugPrint(
                        //     "accpted : ${isAccept} code : ${res.statusCode} body : ${res.body}");
                        debugPrint(
                            "accpted : $isAccept code : ${res.statusCode} body : ${res.body}");
                      },
                    ),
                  ),
                ],
              ),
            ),
            backdrop: Backdrop(
              body: RefreshIndicator(
                onRefresh: getAllIssue,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  child: Column(
                    children: [
                      adminIssueBar(
                        size,
                        theme,
                        selected: issueFocusIndex,
                        onChange: (index) {
                          setState(() {
                            issueFocusIndex = index;
                          });
                        },
                      ),
                      if (issueFocusIndex == 0)
                        Column(
                          children: List.generate(
                            issueList.length,
                            (index) => ReportCard(
                              size: size,
                              theme: theme,
                              boxController: issueDisplayBoxController,
                              reportData: issueList[index],
                              onSelect: (selectedData) {
                                selectedIssue = selectedData;
                              },
                            ),
                          ),
                        )
                      else if (issueFocusIndex == 1)
                        Column(
                          children: List.generate(
                            openIssueList.length,
                            (index) => ReportCard(
                              size: size,
                              theme: theme,
                              boxController: issueDisplayBoxController,
                              reportData: openIssueList[index],
                              onSelect: (selectedData) {
                                selectedIssue = selectedData;
                              },
                            ),
                          ),
                        )
                      else if (issueFocusIndex == 2)
                        Column(
                          children: List.generate(
                            closedIssueList.length,
                            (index) => ReportCard(
                              size: size,
                              theme: theme,
                              boxController: issueDisplayBoxController,
                              reportData: closedIssueList[index],
                              onSelect: (selectedData) {
                                selectedIssue = selectedData;
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center adminIssueBar(Size size, ThemeData theme,
      {required Function(int index) onChange, required int selected}) {
    List<String> issueStringList = ["All Issues", "Open Issues", "Closed Issues"];
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 50, bottom: 40),
        height: size.width * (588 / 738) / (588 / 85),
        width: size.width * (588 / 738),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: theme.brightness == Brightness.light
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.background,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            3,
            (index) => GestureDetector(
              onTap: () {
                onChange(index);
              },
              child: Container(
                decoration: selected == index
                    ? UnderlineTabIndicator(
                        borderSide: BorderSide(
                          color: theme.colorScheme.primary,
                          width: 3,
                        ),
                      )
                    : null,
                child: Text(
                  issueStringList[index],
                  style: TextStyle(
                    fontFamily: GoogleFonts.getFont("Inter").fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReportCard extends StatefulWidget {
  const ReportCard({
    super.key,
    required this.size,
    required this.theme,
    required this.boxController,
    required this.reportData,
    required this.onSelect,
  });
  final Size size;
  final ThemeData theme;
  final BoxController boxController;
  final Map<String, dynamic> reportData;
  final Function(Map<String, dynamic> selectedData) onSelect;

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  Map<String, Color> appColorString = const {
    "ruammitr": Color(0xFFD62828),
    "dekhor": Color(0xFF003049),
    "restroom": Color(0xFFFFB703),
    "pinthebin": Color(0xFFF77F00),
    "dinodengzz": Color(0xFF0A9396),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: () {
          widget.boxController.openBox();
          widget.onSelect(widget.reportData);
        },
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: widget.size.width * (570 / 738),
          height: widget.size.width * (570 / 738) / (570 / 152) * 1.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: widget.theme.brightness == Brightness.light
                ? widget.theme.colorScheme.primaryContainer
                : widget.theme.colorScheme.background,
          ),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                margin: const EdgeInsets.only(left: 10, right: 10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.theme.brightness == Brightness.light
                      ? widget.theme.colorScheme.background
                      : widget.theme.colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, size: 30),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 15,
                            height: 15,
                            color: appColorString[widget.reportData['type']],
                          ),
                          SizedBox(
                            width: widget.size.width * (570 / 738) * 0.5,
                            child: Text(
                              widget.reportData['title'] ?? "No title provided",
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: widget.reportData['status'] == "accepted"
                              ? Colors.green
                              : widget.reportData['status'] == "rejected"
                                  ? Colors.red
                                  : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: widget.size.width * (570 / 738) * 0.6,
                    child: Text(
                      "Explanation : ${widget.reportData['description']}",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text("User id : ${widget.reportData['user_id']}")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
