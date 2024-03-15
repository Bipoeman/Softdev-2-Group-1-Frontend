import 'package:flutter/material.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:ruam_mitt/global_func.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:add_2_calendar/add_2_calendar.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({
    super.key,
  });

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  var dashboardContent = {};
  late Timer timer;
  bool isLoading = true;
  String loadingText = "Loading...";

  @override
  void initState() {
    super.initState();
    timer = startDashboardTimer();
    getDashboardContent();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Timer startDashboardTimer() {
    return Timer.periodic(
      const Duration(seconds: 10),
      (timer) {
        getDashboardContent();
      },
    );
  }

  void getDashboardContent() async {
    setState(() {
      loadingText = "Loading...";
    });
    http.get(
      Uri.parse("$api$userDashboardRoute"),
      headers: {
        "Authorization": "Bearer $publicToken",
      },
    ).then((response) async {
      if (response.statusCode == 200) {
        debugPrint("Get Success");
        var resJson = await json.decode(response.body);
        setState(() {
          dashboardContent = resJson;
          isLoading = false;
        });
      } else {
        if (response.statusCode == 403) {
          if (!context.mounted) {
            return;
          }
          requestNewToken(context);
        }
        setState(() {
          isLoading = true;
          loadingText = "Error: ${response.statusCode}. Reloading...";
        });
      }
    }).onError((error, stackTrace) => null);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDarkMode = ThemesPortal.getCurrent(context).isDarkMode("RuamMitr");
    CustomThemes customTheme = ThemesPortal.appThemeFromContext(context, "RuamMitr")!;

    return isLoading
        ? Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Column(
                children: [
                  CircularProgressIndicator(
                    color: customTheme.customColors["main"],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    loadingText,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: customTheme.customColors["main"],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.02,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome, ${dashboardContent["user_info"]["username"]}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: customTheme.customColors["onEvenContainer"],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: customTheme.customColors["evenContainer"]!.withOpacity(0.4),
                          border: Border.all(
                            color: customTheme.customColors["main"]!,
                            width: 5,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Time Active",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: customTheme.customColors["onEvenContainer"],
                              ),
                            ),
                            Text(
                              (currentActiveTimer ~/ 12).toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: customTheme.customColors["onEvenContainer"],
                              ),
                            ),
                            Text(
                              "Minutes",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: customTheme.customColors["onEvenContainer"],
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          Event event = Event(
                            title: "RuamMitr First Time",
                            description: "Time Active: ${currentActiveTimer ~/ 12} minutes",
                            location: "Thailand",
                            startDate: DateTime.parse(dashboardContent["user_info"]["birthday"]),
                            endDate: DateTime.parse(dashboardContent["user_info"]["birthday"]),
                          );
                          await Add2Calendar.addEvent2Cal(event);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.date_range,
                              color: customTheme.customColors["onEvenContainer"],
                              size: 20,
                            ),
                            Text(
                              "Date of Creation",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: customTheme.customColors["onEvenContainer"],
                              ),
                            ),
                            Text(
                              dashboardContent["user_info"]["birthday"] ??
                                  "Do I live in the simulation?",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                color: customTheme.customColors["onEvenContainer"],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      color: customTheme.customColors["onEvenContainer"]!.withOpacity(0.2),
                      thickness: 2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: customTheme.customColors["main"]!.withOpacity(0.03),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, tuachuayDekhorPageRoute["home"]!);
                            Navigator.pushNamed(context, tuachuayDekhorPageRoute["profile"]!);
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            "assets/images/Logo/TuachuayDekhor_${isDarkMode ? "Dark" : "Light"}.png",
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 75,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.article,
                                  color: customTheme.customColors["icon1"],
                                  size: 24,
                                ),
                                Text(
                                  dashboardContent["dekhor_post"].length.toString(),
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: customTheme.customColors["onEvenContainer"],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            height: 75,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.bookmark,
                                  color: customTheme.customColors["icon2"],
                                  size: 24,
                                ),
                                Text(
                                  dashboardContent["dekhor_savedpost"].length.toString(),
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: customTheme.customColors["onEvenContainer"],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: customTheme.customColors["main"]!.withOpacity(0.03),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, restroomPageRoute["home"]!);
                            Navigator.pushNamed(context, restroomPageRoute["myrestroom"]!);
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: Padding(
                            padding: const EdgeInsets.all(7.5),
                            child: Image.asset(
                              "assets/Logo/restroom_home_logo.png",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 75,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Your Pinned Toilets",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: customTheme.customColors["onEvenContainer"],
                              ),
                            ),
                            Text(
                              dashboardContent["toilet_info"].length.toString(),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: customTheme.customColors["onEvenContainer"],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: customTheme.customColors["main"]!.withOpacity(0.03),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, pinthebinPageRoute["home"]!);
                            Navigator.pushNamed(context, pinthebinPageRoute["mybin"]!);
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: Padding(
                            padding: const EdgeInsets.all(7.5),
                            child: Image.asset(
                              "assets/Logo/bin_portal_color.png",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 75,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Your Pinned Bin",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: customTheme.customColors["onEvenContainer"],
                              ),
                            ),
                            Text(
                              dashboardContent["bin_info"].length.toString(),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: customTheme.customColors["onEvenContainer"],
                              ),
                            ),
                          ],
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
