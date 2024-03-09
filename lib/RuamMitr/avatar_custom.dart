import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/global_const.dart';

class AvatarCustomPage extends StatefulWidget {
  const AvatarCustomPage({super.key});

  @override
  State<AvatarCustomPage> createState() => _AvatarCustomPageState();
}

class _AvatarCustomPageState extends State<AvatarCustomPage> {
  @override
  Widget build(BuildContext context) {
    // ThemeData theme = Theme.of(context);
    ThemeProvider themes = Provider.of<ThemeProvider>(context);
    CustomThemes ruammitrTheme = themes.themeFrom("RuamMitr")!;
    Size size = MediaQuery.of(context).size;
    return Theme(
      data: ruammitrTheme.themeData,
      child: Builder(builder: (context) {
        return Container(
          decoration: ruamMitrBackgroundGradient(themes),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: ruammitrTheme.themeData.colorScheme.onPrimary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text("Customize your avatar"),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: FluttermojiCircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        bottom: 30,
                      ),
                      child: FluttermojiCustomizer(
                        scaffoldWidth: min(600, size.width * 0.85),
                        autosave: true,
                        theme: FluttermojiThemeData(
                          primaryBgColor: ruammitrTheme
                                      .themeData.colorScheme.brightness ==
                                  Brightness.light
                              ? Colors.white
                              : ruammitrTheme.themeData.colorScheme.background,
                          secondaryBgColor: ruammitrTheme
                                      .themeData.colorScheme.brightness ==
                                  Brightness.light
                              ? Colors.grey[200]
                              : ruammitrTheme.themeData.colorScheme.background,
                          labelTextStyle: TextStyle(
                            color: ruammitrTheme
                                        .themeData.colorScheme.brightness ==
                                    Brightness.light
                                ? Colors.black
                                : ruammitrTheme.themeData.colorScheme.onPrimary,
                          ),
                          iconColor: ruammitrTheme
                              .themeData.colorScheme.onPrimaryContainer,
                          boxDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: min(600, size.width * 0.85),
                      height: 50,
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              ruammitrTheme.themeData.colorScheme.primary,
                          textStyle: TextStyle(
                            color:
                                ruammitrTheme.themeData.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          foregroundColor:
                              ruammitrTheme.themeData.colorScheme.onPrimary,
                        ),
                        child: const Text("Done"),
                        onPressed: () {
                          var theController = FluttermojiController();
                          theController.getFluttermojiOptions().then((value) {
                            theController.selectedOptions = value;
                            print(theController.getFluttermojiFromOptions());
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
