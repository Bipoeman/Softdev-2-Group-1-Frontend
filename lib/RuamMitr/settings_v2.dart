import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/avatar.dart';
import 'package:ruam_mitt/RuamMitr/Component/home_v2/contact_us.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsWidgetV2 extends StatefulWidget {
  const SettingsWidgetV2({super.key});

  @override
  State<SettingsWidgetV2> createState() => _SettingsWidgetV2State();
}

class _SettingsWidgetV2State extends State<SettingsWidgetV2> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size.height -
              [size.width * 0.4, 100.0].reduce(min) -
              MediaQuery.of(context).padding.top,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AvatarViewer(size: size),
                      ContactUs(themeProvider)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.19),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: theme.colorScheme.primary,
                        width: size.height * 0.03,
                        height: size.height * 0.03,
                      ),
                      SizedBox(width: size.width * 0.02),
                      Text(
                        "RuamMitr",
                        style: TextStyle(
                          fontSize: theme.textTheme.titleLarge!.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Toggle Theme",
                      style: theme.textTheme.bodyLarge,
                    ),
                    Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: [size.width * 0.6, 300.0].reduce(min),
              margin: EdgeInsets.fromLTRB(0, 20, 0, size.width * 0.15),
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
                child: const Text("Logout"),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool("isChecked", false);
                  await prefs.setString("password", "");
                  isOnceLogin = true;
                  publicToken = "";
                  profileData = {};
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginPageRoute,
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
