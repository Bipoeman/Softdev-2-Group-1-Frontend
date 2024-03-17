import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/avatar.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/RuamMitr/admin.dart';
import 'package:ruam_mitt/RuamMitr/Component/ruammitr_report.dart';
import 'package:ruam_mitt/RuamMitr/Component/client_settings.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ruam_mitt/RuamMitr/Component/frequent_widget/custom_text_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

class SettingsWidgetV2 extends StatefulWidget {
  const SettingsWidgetV2({
    super.key,
    required this.reportBoxController,
    this.pageIndexSetter,
  });

  final BoxController reportBoxController;
  final void Function(int)? pageIndexSetter;

  @override
  State<SettingsWidgetV2> createState() => _SettingsWidgetV2State();
}

class _SettingsWidgetV2State extends State<SettingsWidgetV2> {
  GlobalKey<FormState> requestOTPKey = GlobalKey<FormState>();
  bool isEmailInitiallyBlank = true;
  bool isEmailValid = false;
  bool sendOTPEnabled = false;
  bool waitingForOTPSendSuccess = false;
  TextEditingController emailController = TextEditingController();

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

  (bool, String) emailChecker(String email) {
    String emailWarning = "";
    if (!EmailValidator.validate(email)) {
      sendOTPEnabled = false;
      emailWarning += "The e-mail is incorrect form.";
    }
    return (emailWarning.isNotEmpty, emailWarning);
  }

  String? emailValidator(String? value) {
    if (isEmailInitiallyBlank && value!.isEmpty) {
      return null;
    }
    if (isEmailInitiallyBlank) {
      sendOTPEnabled = false;
      isEmailInitiallyBlank = false;
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
    setState(() {
      waitingForOTPSendSuccess = true;
    });
    Uri url = Uri.parse(
      "$api$requestOTPRoute?email=${emailController.text}",
    );
    var otpRes = await http.get(url);
    if (otpRes.statusCode == 200) {
      setState(() {
        waitingForOTPSendSuccess = false;
      });
      if (!context.mounted) return;
      CustomThemes customTheme = ThemesPortal.appThemeFromContext(context, "RuamMitr")!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: customTheme.customColors["container"]!,
          content: Text(
            "OTP has been sent to your e-mail.",
            style: TextStyle(
              color: customTheme.customColors["onContainer"]!,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: customTheme.themeData.textTheme.bodyLarge!.fontFamily,
            ),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
      startTimer();
      Navigator.pop(context);
      emailController.clear();
    } else {
      setState(() {
        waitingForOTPSendSuccess = false;
      });
      if (!context.mounted) return;
      CustomThemes customTheme = ThemesPortal.appThemeFromContext(context, "RuamMitr")!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: customTheme.customColors["main"]!,
          content: Text(
            "OTP request failed. Please try again.",
            style: TextStyle(
              color: customTheme.customColors["onMain"]!,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: customTheme.themeData.textTheme.bodyLarge!.fontFamily,
            ),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    CustomThemes customTheme = ThemesPortal.appThemeFromContext(context, "RuamMitr")!;
    Map<String, Color> customColor = customTheme.customColors;

    return SingleChildScrollView(
      physics: const RangeMaintainingScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size.height - MediaQuery.of(context).padding.top - 100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AvatarViewer(
                        size: size,
                        pageIndexSetter: widget.pageIndexSetter,
                      ),
                      reportToUs(themeProvider, widget.reportBoxController)
                    ],
                  ),
                ),
                const ClientSettingsWidget(),
                // if (profileData['role'] == "User")
                //   Padding(
                //     padding:
                //         EdgeInsets.symmetric(horizontal: size.width * 0.19),
                //     child: InkWell(
                //       onTap: () {},
                //       child: Ink(
                //         width: size.width,
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text(
                //               "Report",
                //               style: theme.textTheme.bodyLarge,
                //             ),
                //             const Icon(Icons.flag)
                //           ],
                //         ),
                //       ),
                //     ),
                //   )
                // else
                //   const SizedBox(),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: [size.width * 0.9, 300.0].reduce(min),
                  height: 50,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          CustomThemes customTheme =
                              ThemesPortal.appThemeFromContext(context, "RuamMitr")!;
                          ThemeData theme = customTheme.themeData;
                          Map<String, Color> customColors = customTheme.customColors;
                          return Dialog(
                            backgroundColor: customColors["oddContainer"],
                            surfaceTintColor: customColors["oddContainer"],
                            shadowColor: Colors.black38,
                            elevation: 4,
                            child: IntrinsicHeight(
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Request OTP",
                                      style: theme.textTheme.headlineLarge!.copyWith(
                                        color: customColors["onOddContainer"],
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            height: 90,
                                            width: size.width * 0.45,
                                            alignment: Alignment.center,
                                            child: Form(
                                              key: requestOTPKey,
                                              child: textField(
                                                labelText: "E-mail",
                                                context: context,
                                                icon: Icon(
                                                  Icons.email,
                                                  color: customColors["onOddContainer"],
                                                ),
                                                controller: emailController,
                                                validator: emailValidator,
                                                onChanged: (value) {
                                                  if (requestOTPKey.currentState!.validate()) {
                                                    sendOTPEnabled = true;
                                                    setState(() {});
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: const CircleBorder(),
                                                backgroundColor: theme.colorScheme.primary,
                                                fixedSize: const Size(45, 45),
                                                padding: EdgeInsets.zero),
                                            onPressed: (sendOTPEnabled && !isOTPTimerActive)
                                                ? requestOTP
                                                : null,
                                            child: isOTPTimerActive && !waitingForOTPSendSuccess
                                                ? Text(
                                                    "$currentOTPTimer",
                                                    style: TextStyle(
                                                      color: customColors["onMain"],
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  )
                                                : waitingForOTPSendSuccess
                                                    ? SizedBox(
                                                        width: 30,
                                                        height: 30,
                                                        child: CircularProgressIndicator(
                                                          color: customColors["onMain"]!,
                                                        ),
                                                      )
                                                    : Icon(
                                                        Icons.send,
                                                        color: customColors["onMain"],
                                                      ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: customTheme.customColors["container"]!.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.request_page,
                            color: customTheme.customColors["onContainer"]!,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Make a request for OTP",
                            style: theme.textTheme.titleLarge!.copyWith(
                              color: customTheme.customColors["onContainer"]!,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                if (profileData['role'] == "Admin")
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const AdminPage(),
                        ),
                      );
                    },
                    icon: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: customColor['main']!,
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      child: Icon(
                        Icons.admin_panel_settings,
                        size: 30,
                        shadows: [
                          const BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 12.0,
                            blurRadius: 12.0,
                          ),
                          BoxShadow(
                            color: customColor['main']!,
                            spreadRadius: 12.0,
                            blurRadius: 12.0,
                          ),
                        ],
                        color: customColor['onMain']!,
                      ),
                    ),
                    // Image.asset(
                    //   "assets/images/Ruammitr/admin_page_icon.png",
                    //   height: size.height * 0.07,
                    // ),
                  ),
                Container(
                  width: [size.width * 0.6, 300.0].reduce(min),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, size.width * 0.15),
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      textStyle: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          CustomThemes customTheme =
                              ThemesPortal.appThemeFromContext(context, "RuamMitr")!;
                          ThemeData theme = customTheme.themeData;
                          Map<String, Color> customColors = customTheme.customColors;
                          return AlertDialog(
                            backgroundColor: customColors["evenContainer"],
                            surfaceTintColor: customColors["evenContainer"],
                            shadowColor: Colors.black38,
                            elevation: 4,
                            title: Text(
                              "Logout?",
                              style: theme.textTheme.headlineLarge!.copyWith(
                                color: customColors["onEvenContainer"],
                              ),
                            ),
                            content: Text(
                              "Do you want to logout?",
                              style: theme.textTheme.bodyLarge!.copyWith(
                                color: customColors["onEvenContainer"],
                              ),
                            ),
                            actions: [
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                borderRadius: BorderRadius.circular(10),
                                child: Ink(
                                  width: 75,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "No",
                                      style: theme.textTheme.titleLarge!.copyWith(
                                        color: customColors["onEvenContainer"],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  await prefs.setBool("isChecked", false);
                                  await prefs.setString("password", "");
                                  isOnceLogin = true;
                                  publicToken = "";
                                  profileData = {};
                                  timeoutCount = 0;
                                  if (dashboardTimer != null) {
                                    dashboardTimer!.cancel();
                                  }
                                  isDashboardTimerActive = false;
                                  currentActiveTimer = 0;
                                  if (context.mounted) {
                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                      loginPageRoute,
                                      (Route<dynamic> route) => false,
                                    );
                                  }
                                },
                                borderRadius: BorderRadius.circular(10),
                                child: Ink(
                                  width: 75,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Yes",
                                      style: theme.textTheme.titleLarge!.copyWith(
                                        color: customColors["onEvenContainer"],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
