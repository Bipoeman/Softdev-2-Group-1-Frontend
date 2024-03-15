import 'dart:convert';
import 'dart:math';
import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/frequent_widget/custom_text_field.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:http/http.dart' as http;

class PasswordChangeData {
  late Map<String, bool> isInitiallyBlank;
  late Map<String, TextEditingController> fieldController;
  PasswordChangeData(List<String> fields) {
    isInitiallyBlank = {for (var element in fields) element: true};
    fieldController = {for (var element in fields) element: TextEditingController()};
  }
}

class PasswordChangePage extends StatefulWidget {
  const PasswordChangePage({super.key});

  @override
  State<PasswordChangePage> createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  bool sendOTPEnabled = false;
  bool waitingForOTPSendSuccess = false;
  bool isChangePasswordEnabled = false;
  bool isOTPSendSuccess = false;
  GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();
  PasswordChangeData passwordChangeData =
      PasswordChangeData(["email", "OTP", "password", "confirmPassword"]);

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    isOTPTimerActive = true;
    otpTimer = Timer.periodic(oneSec, (timer) {
      if (currentOTPTimer <= 0) {
        timer.cancel();
        isOTPTimerActive = false;
        currentOTPTimer = 60;
      } else {
        currentOTPTimer--;
      }
    });
  }

  void validateNewPasswordInputs(String value) {
    bool noAnyStartStates = passwordChangeData.isInitiallyBlank.values.every((element) {
      return !element;
    });
    if (changePasswordFormKey.currentState!.validate() &&
        !isChangePasswordEnabled &&
        noAnyStartStates) {
      isChangePasswordEnabled = true;
    } else if (!changePasswordFormKey.currentState!.validate() && isChangePasswordEnabled) {
      isChangePasswordEnabled = false;
    }
    setState(() {});
  }

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

  (bool, String) passwordChecker(String password) {
    String passwordWarning = "";
    if (password.length < 8) {
      passwordWarning += "\n - at least 8 characters.";
    }
    if (!RegExp(r'[a-zA-Z]').hasMatch(password)) {
      passwordWarning += "\n - at least 1 alphabet.";
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      passwordWarning += "\n - at least 1 number.";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      passwordWarning += "\n - at least 1 special character.";
    }
    return (passwordWarning.isNotEmpty, passwordWarning);
  }

  String? passwordValidator(String? value) {
    if (passwordChangeData.isInitiallyBlank["password"]! && value!.isEmpty) {
      return null;
    }
    if (passwordChangeData.isInitiallyBlank["password"]!) {
      passwordChangeData.isInitiallyBlank["password"] = false;
      setState(() {});
    }

    var (isPasswordError, passwordMessage) = passwordChecker(value!);
    if (value.isEmpty) {
      return "Please enter password.";
    }
    if (isPasswordError) {
      return "Password must have $passwordMessage";
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (passwordChangeData.isInitiallyBlank["confirmPassword"]! && value!.isEmpty) {
      return null;
    }
    if (passwordChangeData.isInitiallyBlank["confirmPassword"]!) {
      passwordChangeData.isInitiallyBlank["confirmPassword"] = false;
      setState(() {});
    }

    if (value!.isEmpty) {
      return "Please enter password.";
    }
    if (value != passwordChangeData.fieldController['password']!.text) {
      return "Confirm password and the password does not match.";
    }
    return null;
  }

  void requestOTP() async {
    setState(() {
      waitingForOTPSendSuccess = true;
    });
    Uri url = Uri.parse(
      "$api$requestOTPRoute?email=${passwordChangeData.fieldController['email']!.text}",
    );
    var otpRes = await http.get(url);
    if (otpRes.statusCode == 200) {
      isOTPSendSuccess = true;
      startTimer();
    } else {
      isOTPSendSuccess = false;
    }
    waitingForOTPSendSuccess = false;
    debugPrint(otpRes.body);
    setState(() {});
  }

  void changePassword(BuildContext context) async {
    Uri url = Uri.parse("$api$userPasswordResetRoute");
    var response = await http.put(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'email': passwordChangeData.fieldController['email']!.text,
          'otp': passwordChangeData.fieldController['OTP']!.text,
          'password': passwordChangeData.fieldController['password']!.text,
        }));
    var bodyJson = jsonDecode(response.body);
    if (bodyJson['msg'] == "Password updated successfully") {
      if (context.mounted) {
        var snackBar = SnackBar(
          content: Text(bodyJson['msg']),
          backgroundColor: Theme.of(context).colorScheme.primary,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Future.delayed(const Duration(milliseconds: 500)).then((value) {
          if (context.mounted) {
            Navigator.pop(context);
          }
        });
      }
    } else if (bodyJson['msg'] == "Invalid OTP") {
      if (context.mounted) {
        var snackBar = SnackBar(
          content: Text("${bodyJson['msg']}. Please request OTP again."),
          backgroundColor: Theme.of(context).colorScheme.primary,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        passwordChangeData.fieldController['OTP']!.clear();
      }
    }
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
                  color: theme.colorScheme.onPrimary,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                "Change your password",
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      // color: theme.colorScheme.primaryContainer
                      // .withOpacity(0.8),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ruammitrTheme.customColors["oddContainer"]!,
                          ruammitrTheme.customColors["oddContainer"]!.withOpacity(0),
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
                                  controller: passwordChangeData.fieldController['email'],
                                  validator: emailValidator,
                                  onChanged: validateNewPasswordInputs,
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    backgroundColor: theme.colorScheme.primary,
                                    fixedSize: const Size(45, 45),
                                    padding: EdgeInsets.zero),
                                onPressed:
                                    (sendOTPEnabled && !isOTPTimerActive) ? requestOTP : null,
                                child: isOTPTimerActive && !waitingForOTPSendSuccess
                                    ? Text(
                                        "$currentOTPTimer",
                                        style: TextStyle(
                                          color: theme.colorScheme.onPrimary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      )
                                    : waitingForOTPSendSuccess
                                        ? SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: CircularProgressIndicator(
                                              color: ruammitrTheme.customColors["onMain"]!,
                                            ),
                                          )
                                        : Icon(
                                            Icons.send,
                                            color: ruammitrTheme.customColors["onMain"],
                                          ),
                              ),
                              // Icon(Icons.send)
                            ],
                          ),
                          textField(
                            labelText: "OTP",
                            context: context,
                            maxLength: 6,
                            icon: const Icon(Icons.password),
                            controller: passwordChangeData.fieldController['OTP'],
                            inputType: TextInputType.number,
                            validator: (p0) {
                              if ((p0 ?? "").length != 6) {
                                return "OTP Must have length of 6";
                              } else {
                                passwordChangeData.isInitiallyBlank['OTP'] = false;
                                return null;
                              }
                            },
                            onChanged: validateNewPasswordInputs,
                          ),
                          textField(
                            controller: passwordChangeData.fieldController['password'],
                            validator: passwordValidator,
                            labelText: "Password",
                            context: context,
                            obscureText: true,
                            icon: const Icon(Icons.lock_outline),
                            onChanged: validateNewPasswordInputs,
                          ),
                          textField(
                            controller: passwordChangeData.fieldController['confirmPassword'],
                            validator: confirmPasswordValidator,
                            labelText: "Confirm Password",
                            context: context,
                            obscureText: true,
                            icon: const Icon(Icons.lock_outline),
                            onChanged: validateNewPasswordInputs,
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
                              onPressed: (isChangePasswordEnabled && isOTPSendSuccess)
                                  ? () async {
                                      changePassword(context);
                                    }
                                  : null,
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
        hintStyle: TextStyle(color: theme.colorScheme.onBackground.withOpacity(0.5)),
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
