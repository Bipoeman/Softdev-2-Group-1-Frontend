import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import "dart:math";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  bool? isChecked = false;
  final url = Uri.parse("$api$loginPageRoute");
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  late SharedPreferences removepassword;

  Future<void> sendLoginRequest() async {
    var response = await http.post(url, body: {
      "emailoruser": usernameTextController.text,
      "password": passwordTextController.text,
    }).timeout(const Duration(seconds: 5), onTimeout: () {
      return http.Response("Connection timeout", 408);
    }).onError((error, stackTrace) => http.Response("Error", 404));
    if (context.mounted) {
      ThemeData theme = Theme.of(context);
      if (response.statusCode == 408) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Connection timeout. Please check your internet connection.",
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
              ),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
      } else if (response.statusCode == 200) {
        saveuser();
        print(response.body);
        publicToken = response.body;
        Navigator.of(context).pushNamedAndRemoveUntil(
          ruamMitrPageRoute["homev2"]!,
          (route) => false,
        );
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Error. Please try again later.",
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
              ),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
      } else {
        removepassword;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Login failed. Please check your credentials.",
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
              ),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
      }
    }
  }

  void navigateToHome() async {
    bool isLoggedIn = usernameTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty &&
        isChecked!;
    if (isLoggedIn) {
      sendLoginRequest();
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //   ruamMitrPageRoute["home"]!,
      //   (route) => false,
      // );
    }
  }

  clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isChecked = prefs.getBool("isChecked");
      usernameTextController.text = prefs.getString("emailoruser") ?? "";
      passwordTextController.text = prefs.getString("password") ?? "";
      print(
          "username found : ${usernameTextController.text}, password found : ${passwordTextController.text}");
      navigateToHome();
    });
  }

  saveCheckbox() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isChecked", isChecked ?? false);
  }

  saveuser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("emailoruser", usernameTextController.text);
    await prefs.setString("password", passwordTextController.text);
  }

  void initial() async {
    removepassword = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    initial();
    loadData();
  }

  @override
  void dispose() {
    usernameTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    ThemeProvider themes = Provider.of<ThemeProvider>(context);
    return Container(
      decoration: ruamMitrBackgroundGradient(themes),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height - MediaQuery.of(context).padding.top,
              ),
              child: Center(
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                          height: [150.0, size.width * 0.5].reduce(min),
                          width: [150.0, size.width * 0.5].reduce(min),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            "assets/Logo/bipoelogo1.svg",
                            fit: BoxFit.contain,
                          ),
                        ),
                        Column(
                          children: [
                            // Text(
                            //   "RuamMitr",
                            //   style: TextStyle(
                            //     color: theme.colorScheme.primary,
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 35,
                            //   ),
                            // ),
                            Text(
                              "PORTAL APP",
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w300,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(30),
                          width: [512.0, size.width * 0.8].reduce(min),
                          height: 360,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: theme.colorScheme.primaryContainer
                                .withOpacity(0.8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextFormField(
                                controller: usernameTextController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  fillColor: theme.colorScheme.background,
                                  filled: true,
                                  labelStyle: TextStyle(
                                      color: theme.colorScheme.onBackground
                                          .withOpacity(0.5)),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(30, 0, 5, 0),
                                  labelText: "Email or Username",
                                  prefixIconColor:
                                      theme.colorScheme.onBackground,
                                  prefixIcon: const Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: passwordTextController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                decoration: InputDecoration(
                                  fillColor: theme.colorScheme.background,
                                  filled: true,
                                  labelStyle: TextStyle(
                                      color: theme.colorScheme.onBackground
                                          .withOpacity(0.5)),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(30, 0, 5, 0),
                                  labelText: "Password",
                                  prefixIconColor:
                                      theme.colorScheme.onBackground,
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: isChecked ?? false,
                                          // tristate: false,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value != null) {
                                                isChecked = value;
                                                if (isChecked == true) {
                                                  saveCheckbox();
                                                  saveuser();
                                                } else {
                                                  clearPreferences();
                                                }
                                              }
                                            });
                                          },
                                          activeColor:
                                              theme.colorScheme.onPrimary,
                                          checkColor: theme.colorScheme.primary,
                                        ),
                                        const Text(
                                          "Remember me",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                      child: Text(
                                        "Forgot password?",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: theme.colorScheme.secondary),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colorScheme.primary,
                                    textStyle: TextStyle(
                                      color: theme.colorScheme.onPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    foregroundColor:
                                        theme.colorScheme.onPrimary,
                                  ),
                                  child: const Text("Login"),
                                  onPressed: () {
                                    sendLoginRequest();
                                  },
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Don't have an account?"),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, registerPageRoute);
                                    },
                                    child: Text(
                                      "Create an account",
                                      style: TextStyle(
                                        color: theme.colorScheme.secondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      child: IconButton(
                        icon: Image.asset("assets/Menu/Buttons/Play.png"),
                        onPressed: () {
                          Navigator.pushNamed(context, dinodengzzPageRoute);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
