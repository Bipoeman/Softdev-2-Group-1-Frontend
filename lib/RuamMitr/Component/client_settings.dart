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
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: [size.width * 0.9, 300.0].reduce(min),
          child: const Divider(
            height: 4,
            thickness: 1,
            color: Color.fromARGB(44, 109, 108, 108),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: [size.width * 0.9, 300.0].reduce(min),
          height: 50,
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  CustomThemes customTheme = ThemesPortal.appThemeFromContext(context, "RuamMitr")!;
                  ThemeData theme = customTheme.themeData;
                  Map<String, Color> customColors = customTheme.customColors;
                  return AlertDialog(
                    backgroundColor: customColors["evenContainer"],
                    surfaceTintColor: customColors["evenContainer"],
                    shadowColor: Colors.black38,
                    elevation: 4,
                    title: Text(
                      "Reset?",
                      style: theme.textTheme.headlineLarge!.copyWith(
                        color: customColors["onEvenContainer"],
                      ),
                    ),
                    content: Text(
                      "Do you want to reset all settings to default values?",
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
                        onTap: () {
                          Navigator.pop(context);
                          themeProvider.resetAllSettings(context);
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
            borderRadius: BorderRadius.circular(15),
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: customTheme.customColors["container"]!.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.restore,
                    color: customTheme.customColors["onContainer"]!,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Reset All Settings to Default",
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: customTheme.customColors["onContainer"]!,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
