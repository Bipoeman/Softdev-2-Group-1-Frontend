import "package:flutter/material.dart";
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import "package:provider/provider.dart";
import "dart:math";

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      children: [
        IntrinsicHeight(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ),
        ),
        SizedBox(
          width: [size.width * 0.6, 300.0].reduce(min),
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffcb2e23),
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              foregroundColor: Colors.white,
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
