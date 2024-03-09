import 'package:flutter/material.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'dart:math';

class CreateAvatarPage extends StatefulWidget {
  const CreateAvatarPage({super.key});

  @override
  State<CreateAvatarPage> createState() => _CreateAvatarPageState();
}

class _CreateAvatarPageState extends State<CreateAvatarPage> {
  Container inkWellBox({
    required CustomThemes customTheme,
    String? title,
    String? description,
    Function()? onTap,
  }) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: customTheme.customColors["evenContainer"],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title ?? "What's Your Title?",
                    style: customTheme.themeData.textTheme.titleLarge,
                  ),
                  Text(
                    description ?? "Describe your object.",
                    style: customTheme.themeData.textTheme.bodyLarge,
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: customTheme.customColors["onEvenContainer"],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CustomThemes customTheme = ThemesPortal.appThemeFromContext(context, "RuamMitr")!;
    ThemeData theme = customTheme.themeData;
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        gradient: backgroundGradient(context, "RuamMitr"),
      ),
      child: Theme(
        data: theme,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            toolbarHeight: 75.0,
            title: Text(
              "Choose Your Avatar",
              style: TextStyle(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold),
            ),
            backgroundColor: theme.colorScheme.primary,
            leading: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios,
                color: theme.colorScheme.onPrimary,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const RangeMaintainingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: size.height - MediaQuery.of(context).padding.top - 75,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 50),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      width: [512.0, size.width * 0.9].reduce(min),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            customTheme.customColors["oddContainer"]!,
                            customTheme.customColors["oddContainer"]!.withOpacity(0),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          inkWellBox(
                            customTheme: customTheme,
                            title: "Fluttermoji",
                            description: "Let you customize your avatar.",
                          ),
                          inkWellBox(
                            customTheme: customTheme,
                            title: "Al-Generate",
                            description: "Let AI generate your avatar.",
                          ),
                          inkWellBox(
                            customTheme: customTheme,
                            title: "Upload",
                            description: "Let you upload your avatar.",
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  ruamMitrPageRoute["homev2"]!,
                                  (route) => false,
                                );
                              },
                              child: Text(
                                "Skip for Now",
                                style: customTheme.themeData.textTheme.bodyLarge!.copyWith(
                                  color: customTheme.customColors["hyperlink"],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
