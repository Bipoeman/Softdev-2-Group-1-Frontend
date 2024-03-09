import 'dart:math';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' show DateFormat;
import 'package:image_picker/image_picker.dart';
import 'package:ruam_mitt/global_func.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';

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
    void Function()? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: customTheme.customColors["evenContainer"]!.withOpacity(0.5),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap ?? () {},
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "What's Your Title?",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: customTheme.customColors["onEvenContainer"],
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: customTheme.themeData.textTheme.bodyLarge!.fontFamily,
                    ),
                  ),
                  Text(
                    description ?? "Describe your object.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: customTheme.customColors["onEvenContainer"],
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      fontFamily: customTheme.themeData.textTheme.bodyLarge!.fontFamily,
                    ),
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

  Future<File?> getImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var result = await FlutterImageCompress.compressAndGetFile(
        image.path,
        image.path + '_compressed.jpg',
        quality: 30,
      );
      if (result != null) {
        return File(result.path);
      } else {
        print('Error compressing image');
      }
    }
    return null;
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
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
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
                            onTap: () {},
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
