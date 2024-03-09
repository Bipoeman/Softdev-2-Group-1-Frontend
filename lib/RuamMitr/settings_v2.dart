import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/avatar.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/RuamMitr/admin.dart';
import 'package:ruam_mitt/RuamMitr/Component/ruammitr_report.dart';
import 'package:ruam_mitt/RuamMitr/Component/client_settings.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsWidgetV2 extends StatefulWidget {
  const SettingsWidgetV2({super.key, required this.reportBoxController});
  final BoxController reportBoxController;

  @override
  State<SettingsWidgetV2> createState() => _SettingsWidgetV2State();
}

class _SettingsWidgetV2State extends State<SettingsWidgetV2> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    CustomThemes customTheme = ThemesPortal.appThemeFromContext(context, "RuamMitr")!;
    Map<String, Color> customColor = customTheme.customColors;

    return SingleChildScrollView(
      physics: const RangeMaintainingScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size.height - MediaQuery.of(context).padding.top - 100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AvatarViewer(size: size),
                      reportToUs(themeProvider, widget.reportBoxController)
                    ],
                  ),
                ),
                const ClientSettingsWidget(),
                // if (profileData['role'] == "User")
                //   Padding(
                //     padding:
                //         EdgeInsets.symmetric(horizontal: size.width * 0.19),
                //     child: InkWell(
                //       onTap: () {},
                //       child: Ink(
                //         width: size.width,
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text(
                //               "Report",
                //               style: theme.textTheme.bodyLarge,
                //             ),
                //             const Icon(Icons.flag)
                //           ],
                //         ),
                //       ),
                //     ),
                //   )
                // else
                //   const SizedBox(),
              ],
            ),
            Column(
              children: [
                if (profileData['role'] == "Admin")
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const AdminPage(),
                        ),
                      );
                    },
                    icon: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: customColor['main']!,
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      child: Icon(
                        Icons.admin_panel_settings,
                        size: 30,
                        shadows: [
                          const BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 12.0,
                            blurRadius: 12.0,
                          ),
                          BoxShadow(
                            color: customColor['main']!,
                            spreadRadius: 12.0,
                            blurRadius: 12.0,
                          ),
                        ],
                        color: customColor['onMain']!,
                      ),
                    ),
                    // Image.asset(
                    //   "assets/images/Ruammitr/admin_page_icon.png",
                    //   height: size.height * 0.07,
                    // ),
                  ),
                Container(
                  width: [size.width * 0.6, 300.0].reduce(min),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, size.width * 0.15),
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      textStyle: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          CustomThemes customTheme =
                              ThemesPortal.appThemeFromContext(context, "RuamMitr")!;
                          ThemeData theme = customTheme.themeData;
                          Map<String, Color> customColors = customTheme.customColors;
                          return AlertDialog(
                            backgroundColor: customColors["evenContainer"],
                            surfaceTintColor: customColors["evenContainer"],
                            shadowColor: Colors.black38,
                            elevation: 4,
                            title: Text(
                              "Logout?",
                              style: theme.textTheme.headlineLarge!.copyWith(
                                color: customColors["onEvenContainer"],
                              ),
                            ),
                            content: Text(
                              "Do you want to logout?",
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
                                onTap: () async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  await prefs.setBool("isChecked", false);
                                  await prefs.setString("password", "");
                                  isOnceLogin = true;
                                  publicToken = "";
                                  profileData = {};
                                  if (context.mounted) {
                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                      loginPageRoute,
                                      (Route<dynamic> route) => false,
                                    );
                                  }
                                },
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
                    },
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
