import "package:flutter/material.dart";
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import "package:provider/provider.dart";
import "dart:math";
import 'package:shared_preferences/shared_preferences.dart';

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
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
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
              // clear all routes and push to home
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/login',
                (Route<dynamic> route) => false,
              );
            },
          ),
        ),
      ],
    );
  }
}
