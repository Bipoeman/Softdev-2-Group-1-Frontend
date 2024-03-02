import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/frequent_widget/custom_text_field.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/global_const.dart';

class PasswordChangeData {
  late Map<String, bool> isInitiallyBlank;
  late Map<String, TextEditingController> fieldController;
  PasswordChangeData(List<String> fields) {
    isInitiallyBlank = {for (var element in fields) element: true};
    fieldController = {
      for (var element in fields) element: TextEditingController()
    };
  }
}

class PasswordChangePage extends StatefulWidget {
  const PasswordChangePage({super.key});

  @override
  State<PasswordChangePage> createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  bool sendOTPEnabled = false;
  GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();
  PasswordChangeData passwordChangeData =
      PasswordChangeData(["email", "OTP", "password", "confirmPassword"]);

  (bool, String) emailChecker(String email) {
    String emailWarning = "";
    if (!EmailValidator.validate(email)) {
      sendOTPEnabled = false;
      emailWarning += "The e-mail is incorrect form.";
    }
    return (emailWarning.isNotEmpty, emailWarning);
  }

  String? emailValidator(String? value) {
    if (passwordChangeData.isInitiallyBlank["email"]! && value!.isEmpty) {
      return null;
    }
    if (passwordChangeData.isInitiallyBlank["email"]!) {
      sendOTPEnabled = false;
      passwordChangeData.isInitiallyBlank["email"] = false;
      setState(() {});
    }

    var (isEmailError, emailMessage) = emailChecker(value!);
    setState(() {});
    if (value.isEmpty) {
      sendOTPEnabled = false;
      return "Please enter your e-mail.";
    }
    if (isEmailError) {
      sendOTPEnabled = false;
      return emailMessage;
    }
    sendOTPEnabled = true;
    setState(() {});
    return null;
  }

  void requestOTP() async {
    
  }

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
            body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: size.height - MediaQuery.of(context).padding.top,
                ),
                child: Center(
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
                      key: changePasswordFormKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                // child: customTextField("Email", theme,
                                //     icon: Icons.person,
                                //     validator: emailValidator,),
                                child: textField(
                                  labelText: "Email",
                                  context: context,
                                  icon: const Icon(Icons.email_outlined),
                                  controller: passwordChangeData
                                      .fieldController['email'],
                                  validator: emailValidator,
                                  onChanged: (value) {
                                    changePasswordFormKey.currentState!
                                        .validate();
                                  },
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    backgroundColor: theme.colorScheme.primary,
                                    padding: EdgeInsets.zero),
                                onPressed: sendOTPEnabled ? requestOTP : null,
                                child: Icon(
                                  Icons.send,
                                  color: theme.colorScheme.primaryContainer,
                                ),
                              )
                              // Icon(Icons.send)
                            ],
                          ),
                          textField(
                            labelText: "OTP",
                            context: context,
                            icon: const Icon(Icons.password),
                            controller:
                                passwordChangeData.fieldController['OTP'],
                            inputType: TextInputType.number,
                            onChanged: (value) {
                              changePasswordFormKey.currentState!.validate();
                            },
                          ),
                          textField(
                            labelText: "New password",
                            context: context,
                            icon: const Icon(Icons.lock),
                            controller:
                                passwordChangeData.fieldController['password'],
                            inputType: TextInputType.visiblePassword,
                            obscureText: true,
                            onChanged: (value) {
                              changePasswordFormKey.currentState!.validate();
                            },
                          ),
                          textField(
                            labelText: "Confirm password",
                            context: context,
                            icon: const Icon(Icons.lock),
                            controller: passwordChangeData
                                .fieldController['confirmPassword'],
                            inputType: TextInputType.visiblePassword,
                            obscureText: true,
                            onChanged: (value) {
                              changePasswordFormKey.currentState!.validate();
                            },
                          ),
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
        ),
      ),
    );
  }

  TextFormField customTextField(
    String hint,
    ThemeData theme, {
    required IconData icon,
    TextEditingController? controller,
    bool enabled = true,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        fillColor: theme.colorScheme.background,
        filled: true,
        hintStyle:
            TextStyle(color: theme.colorScheme.onBackground.withOpacity(0.5)),
        contentPadding: const EdgeInsets.fromLTRB(30, 0, 5, 0),
        hintText: hint,
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
