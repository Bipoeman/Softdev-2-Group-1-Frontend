import 'package:flutter/material.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:ruam_mitt/global_func.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ContentWidget extends StatefulWidget {
  const ContentWidget({
    super.key,
  });

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  var dashboardContent = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getDashboardContent();
  }

  void getDashboardContent() async {
    setState(() {
      isLoading = true;
    });
    var response = await http.get(
      Uri.parse("$api$userDashboardRoute"),
      headers: {
        "Authorization": "Bearer $publicToken",
      },
    );
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      debugPrint("Get Success");
      var resJson = await json.decode(response.body);
      setState(() {
        dashboardContent = resJson;
        isLoading = false;
      });
    } else {
      throw Exception("Failed to load dashboard content");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CustomThemes customTheme = ThemesPortal.appThemeFromContext(context, "RuamMitr")!;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: customTheme.customColors["main"],
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.02,
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.02,
                vertical: size.height * 0.02,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: customTheme.customColors["evenContainer"]!.withOpacity(0.4),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Your Dashboard",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: customTheme.customColors["onEvenContainer"],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Divider(
                      color: customTheme.customColors["onEvenContainer"]!.withOpacity(0.2),
                      thickness: 2,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: customTheme.customColors["evenContainer"]!.withOpacity(0.4),
                          border: Border.all(
                            color: customTheme.customColors["onEvenContainer"]!.withOpacity(0.6),
                            width: 5,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "User ID",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: customTheme.customColors["onEvenContainer"],
                              ),
                            ),
                            Text(
                              dashboardContent["user_info"]["id"].toString() ?? "0",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: customTheme.customColors["onEvenContainer"],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Welcome, ${dashboardContent["user_info"]["username"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: customTheme.customColors["onEvenContainer"],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
