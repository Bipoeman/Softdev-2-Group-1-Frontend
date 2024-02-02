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
  final String? appRoute;
  final double width;
  final double height;

  Widget getAppIcon(context) {
    ThemeData theme = Theme.of(context);
    if (appIconPath != null) {
      try {
        return ImageIcon(
          Image.asset(appIconPath!).image,
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
      color: theme.colorScheme.onPrimary,
    );
  }

  @override
  Widget build(context) {
    ThemeData theme = Theme.of(context);
    return TextButton(
      onPressed: () {
        // Add your button logic here
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: width,
              height: height * 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getAppIcon(context),
                  Text(
                    appName ?? "App",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width - 20,
              height: height * 0.5 - 20,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  appDescription ?? "Description",
                  style: TextStyle(
                    fontSize: 15,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
