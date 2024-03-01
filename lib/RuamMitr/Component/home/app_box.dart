import 'package:flutter/material.dart';

class AppBox extends StatelessWidget {
  const AppBox({
    super.key,
    required this.appName,
    this.appIconPath,
    this.appDescription,
    this.appRoute,
    required this.width,
    required this.height,
  });
  final String? appIconPath;
  final String? appName;
  final String? appDescription;
  final VoidCallback? appRoute;
  final double width;
  final double height;

  Widget getAppIcon(context) {
    ThemeData theme = Theme.of(context);
    if (appIconPath != null) {
      try {
        // return ImageIcon(
        //   Image.asset(appIconPath!).image,
        //   size: 50,
        // );
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Image.asset(
            appIconPath!,
          ),
        );
      } catch (_) {}
      try {
        return ImageIcon(
          NetworkImage(appIconPath!),
        );
      } catch (_) {}

      debugPrint("Cannot load app icon from $appIconPath");
    }
    return Icon(
      Icons.apps,
      color: theme.colorScheme.primary,
    );
  }

  @override
  Widget build(context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: appRoute ??
          () {
            print("Tapped $appName");
          },
      child: Ink(
        height: height > 100 ? height : 100,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: width * 0.15, child: getAppIcon(context)),
                SizedBox(width: width * 0.03),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width * 0.3,
                      child: Text(
                        appName ?? "App",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.titleLarge!.color,
                        ),
                      ),
                    ),
                    Text(
                      appDescription ?? "Description",
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            // const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
