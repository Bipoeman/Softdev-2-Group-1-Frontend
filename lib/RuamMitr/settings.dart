import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:ruam_mitt/global_var.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/RuamMitr/Component/main_navigator.dart';
import 'package:ruam_mitt/global_const.dart';
import "dart:math";

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SharedPreferences saveuser;

  @override
  void initState() {
    super.initState();
    initial();
  }

  removepassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("password");
  }

  void initial() async {
    saveuser = await SharedPreferences.getInstance();
    setState(() {
      removepassword();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      bottomNavigationBar: MainNavigator(pageIndex: 2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height -
                  [size.width * 0.4, 100.0].reduce(min) -
                  MediaQuery.of(context).padding.top,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Toggle Theme",
                      style: theme.textTheme.titleLarge,
                    ),
                    Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                    ),
                  ],
                ),
                Container(
                  width: [size.width * 0.6, 300.0].reduce(min),
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
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
                    onPressed: () {
                      publicToken = "";
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
        ),
      ),
    );
  }
}
