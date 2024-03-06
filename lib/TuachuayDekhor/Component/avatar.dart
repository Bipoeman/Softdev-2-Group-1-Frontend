import 'package:flutter/material.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';

class TuachuayDekhorAvatarViewer extends StatelessWidget {
  const TuachuayDekhorAvatarViewer({
    super.key,
    required this.username,
    required this.avatarUrl,
  });

  final String? username;
  final String? avatarUrl;

  Widget getAvatar(BuildContext context) {
    CustomThemes theme =
        ThemesPortal.appThemeFromContext(context, "TuachuayDekhor")!;
    Map<String, Color> customColors = theme.customColors;

    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      try {
        return CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(avatarUrl!),
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    final imgPath = profileData['imgPath'];

    if (imgPath != null && imgPath.isNotEmpty) {
      return CircleAvatar(
        radius: 30,
        backgroundColor: customColors["background"]!.withOpacity(0.5),
        backgroundImage: NetworkImage(imgPath),
      );
    }

    return CircleAvatar(
      radius: 30,
      backgroundColor: customColors["background"]!.withOpacity(0.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    CustomThemes theme =
        ThemesPortal.appThemeFromContext(context, "TuachuayDekhor")!;
    Map<String, Color> customColors = theme.customColors;

    return IntrinsicHeight(
      child: IntrinsicWidth(
        child: RawMaterialButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          constraints: const BoxConstraints(),
          onPressed: () {
            Navigator.pushNamed(
              context,
              tuachuayDekhorPageRoute["profileblogger"]!,
              arguments: {
                'username': username,
                'avatarUrl': avatarUrl,
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: getAvatar(context),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: customColors["main"],
                    ),
                    height: 24,
                    width: 68.5,
                    child: Text(
                      username ?? "John Doe",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color: customColors["onMain"],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
