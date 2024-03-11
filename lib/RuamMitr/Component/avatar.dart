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
    this.size,
    this.pageIndexSetter,
  });
  final String? username;
  final String? avatarUrl;
  final Size? size;
  final ThemeData? themeData;
  final void Function(int)? pageIndexSetter;

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
      radius: 24,
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
              if (pageIndexSetter != null) {
                pageIndexSetter!(0);
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: getAvatar(context),
                  ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: size == null ? 150 : size!.width * 0.4),
                      child: Text(
                        profileData['fullname'] ?? "John Doe",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: themeData == null
                                ? themes.themeFrom("RuamMitr")!.customColors['textInput']
                                : themeData!.colorScheme.onPrimary),
                      ),
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
