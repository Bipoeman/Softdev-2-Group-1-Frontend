import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/global_var.dart';

class AvatarViewer extends StatelessWidget {
  const AvatarViewer({
    super.key,
    this.username,
    this.avatarUrl,
    this.themeData,
  });
  final String? username;
  final String? avatarUrl;
  final ThemeData? themeData;

  Widget getAvatar(BuildContext context) {
    ThemeData theme = Theme.of(context);
    // if (avatarUrl != null) {
    //   try {
    //     return CircleAvatar(
    //       radius: 30,
    //       backgroundImage: NetworkImage(avatarUrl!),
    //     );
    //   } catch (e) {
    //     debugPrint(e.toString());
    //   }
    // }
    return CircleAvatar(
      radius: 30,
      backgroundColor: theme.colorScheme.primaryContainer.withOpacity(0.5),
      backgroundImage: NetworkImage(profileData['imgPath']),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themes = Provider.of<ThemeProvider>(context);
    ThemeData defaultThemeData = themes.themeFrom("RuamMitr")!.themeData;
    return Theme(
      data: themeData ?? defaultThemeData,
      child: IntrinsicHeight(
        child: IntrinsicWidth(
          child: RawMaterialButton(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            constraints: const BoxConstraints(),
            onPressed: () {
              // Navigator.pushNamed(context, ruamMitrPageRoute["profile"]!);
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: getAvatar(context),
                  ),
                  const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      profileData['fullname'] ?? "John Doe",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: themeData == null
                              ? themes
                                  .themeFrom("RuamMitr")!
                                  .customColors['textInput']
                              : themeData!.colorScheme.onPrimary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
