import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/global_const.dart';

class PasswordChangePage extends StatefulWidget {
  const PasswordChangePage({super.key});

  @override
  State<PasswordChangePage> createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themes = Provider.of<ThemeProvider>(context);
    ThemeData theme = themes.themeFrom("RuamMitr")!.themeData;
    CustomThemes ruammitrTheme = themes.themeFrom("RuamMitr")!;

    Size size = MediaQuery.of(context).size;
    return Theme(
      data: theme,
      child: Builder(
        builder: (context) => Container(
          decoration: ruamMitrBackgroundGradient(themes),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: theme.colorScheme.primary,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: theme.colorScheme.primaryContainer,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                "Change your password",
                style: TextStyle(
                  color: theme.colorScheme.primaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(30),
                width: [512.0, size.width * 0.8].reduce(min),
                height: size.height * 0.55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  // color: theme.colorScheme.primaryContainer
                  // .withOpacity(0.8),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ruammitrTheme.customColors["oddContainer"]!,
                      ruammitrTheme.customColors["oddContainer"]!
                          .withOpacity(0),
                    ],
                  ),
                ),
                child: Form(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: customTextField(
                              "Email",
                              theme,
                              icon: Icons.person,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: theme.colorScheme.primary,
                              padding: EdgeInsets.zero
                            ),
                            onPressed: null,
                            child: Icon(
                              Icons.send,
                              color: theme.colorScheme.primaryContainer,
                            ),
                          )
                          // Icon(Icons.send)
                        ],
                      ),
                      const SizedBox(height: 25),
                      customTextField("OTP", theme, icon: Icons.lock),
                      const SizedBox(height: 25),
                      customTextField("Password", theme, icon: Icons.password),
                      const SizedBox(height: 25),
                      customTextField("Repeat Password", theme,
                          icon: Icons.password),
                      const SizedBox(height: 25),
                      Container(
                        width: double.infinity,
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            textStyle: TextStyle(
                              color: theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            foregroundColor: theme.colorScheme.onPrimary,
                          ),
                          onPressed: null,
                          // onPressed: _registerButtonEnabled ? _registerAccount : null,
                          child: const Text("Change Password"),
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
    );
  }

  TextFormField customTextField(String hint, ThemeData theme,
      {required IconData icon, TextEditingController? controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: theme.colorScheme.background,
        filled: true,
        labelStyle:
            TextStyle(color: theme.colorScheme.onBackground.withOpacity(0.5)),
        contentPadding: const EdgeInsets.fromLTRB(30, 0, 5, 0),
        labelText: hint,
        prefixIconColor: theme.colorScheme.onBackground,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
