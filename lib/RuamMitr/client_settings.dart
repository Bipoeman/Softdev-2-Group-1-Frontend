import 'package:flutter/material.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/RuamMitr/Component/client_settings.dart';

class ClientSettingsPage extends StatefulWidget {
  const ClientSettingsPage({super.key});

  @override
  State<ClientSettingsPage> createState() => _ClientSettingsPageState();
}

class _ClientSettingsPageState extends State<ClientSettingsPage> {
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
              "Settings",
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
                    child: const ClientSettingsWidget(),
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
