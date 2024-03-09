import 'package:flutter/material.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'dart:math';

class ClientSettingsWidget extends StatelessWidget {
  const ClientSettingsWidget({super.key});

  DropdownMenuItem<String> buildMenuItem(BuildContext context, String app) {
    ThemeData theme = ThemesPortal.getCurrent(context).appThemes[app]!["light"]!.themeData;
    CustomThemes currentTheme = ThemesPortal.appThemeFromContext(context, "RuamMitr")!;
    return DropdownMenuItem(
      value: app,
      child: Row(
        children: [
          Container(
            width: 25,
            height: 25,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            app,
            style: theme.textTheme.bodyLarge!.copyWith(
              color: currentTheme.customColors["onContainer"],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CustomThemes customTheme = ThemesPortal.appThemeFromContext(context, "RuamMitr")!;
    ThemeProvider themeProvider = ThemesPortal.getCurrent(context);
    ThemeData theme = customTheme.themeData;
    List<String> appList = themeProvider.themeForApp.keys.toList();

    return Column(
      children: [
        SizedBox(
          width: [size.width * 0.9, 300.0].reduce(min),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: theme.colorScheme.primary,
                    width: size.height * 0.03,
                    height: size.height * 0.03,
                  ),
                  SizedBox(width: size.width * 0.02),
                  Text(
                    "All Apps",
                    style: TextStyle(
                      fontSize: theme.textTheme.titleLarge!.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dark Mode",
                      style: theme.textTheme.bodyLarge,
                    ),
                    Switch(
                      value: themeProvider.globalDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: [size.width * 0.9, 300.0].reduce(min),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: ThemesPortal.getCurrent(context)
                        .appThemes["RuamMitr"]!["light"]!
                        .themeData
                        .colorScheme
                        .primary,
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
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dark Mode",
                      style: theme.textTheme.bodyLarge,
                    ),
                    Switch(
                      value: themeProvider.isDarkMode("RuamMitr"),
                      onChanged: (value) {
                        themeProvider.toggleThemeForApp("RuamMitr");
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Themes",
                      style: theme.textTheme.bodyLarge,
                    ),
                    DropdownButton(
                      dropdownColor: customTheme.customColors["container"]!,
                      borderRadius: BorderRadius.circular(20),
                      items: List.generate(appList.length, (index) {
                        return buildMenuItem(context, appList[index]);
                      }),
                      value: ThemesPortal.getCurrent(context).themeForApp["RuamMitr"],
                      onChanged: (value) {
                        ThemesPortal.changeThemeColor(context, "RuamMitr", value!);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: [size.width * 0.9, 300.0].reduce(min),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: ThemesPortal.getCurrent(context)
                        .appThemes["TuachuayDekhor"]!["light"]!
                        .themeData
                        .colorScheme
                        .primary,
                    width: size.height * 0.03,
                    height: size.height * 0.03,
                  ),
                  SizedBox(width: size.width * 0.02),
                  Text(
                    "Dekhor",
                    style: TextStyle(
                      fontSize: theme.textTheme.titleLarge!.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dark Mode",
                      style: theme.textTheme.bodyLarge,
                    ),
                    Switch(
                      value: themeProvider.isDarkMode("TuachuayDekhor"),
                      onChanged: (value) {
                        themeProvider.toggleThemeForApp("TuachuayDekhor");
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Themes",
                      style: theme.textTheme.bodyLarge,
                    ),
                    DropdownButton(
                      dropdownColor: customTheme.customColors["container"]!,
                      borderRadius: BorderRadius.circular(20),
                      items: List.generate(appList.length, (index) {
                        return buildMenuItem(context, appList[index]);
                      }),
                      value: ThemesPortal.getCurrent(context).themeForApp["TuachuayDekhor"],
                      onChanged: (value) {
                        ThemesPortal.changeThemeColor(context, "TuachuayDekhor", value!);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
