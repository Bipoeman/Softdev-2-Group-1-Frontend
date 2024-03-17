import 'package:flutter/material.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';

void showLoadingScreen({required BuildContext context, required String message}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      CustomThemes customThemes = ThemesPortal.appThemeFromContext(context, "RuamMitr")!;
      ThemeData theme = customThemes.themeData;
      return PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          title: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: customThemes.themeData.textTheme.bodyLarge!.fontFamily,
              fontSize: 20,
            ),
          ),
          content: SizedBox(
            height: 50,
            width: 50,
            child: Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ),
      );
    },
  );
}
