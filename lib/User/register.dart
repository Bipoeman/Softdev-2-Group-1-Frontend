import 'package:flutter/material.dart';
import 'package:ruam_mitt/Component/text_field.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

Color backgroundColor = const Color(0xffe8e8e8);
Color mainColor = const Color(0xffd33333);
Color textColor = const Color(0xff000000);

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final fullnameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmpasswordTextController = TextEditingController();

  void _registerAccount() async {
    var response = await http.post(
        Uri.parse("https://softdev2-backend.azurewebsites.net/register"),
        body: {
          'fullname': fullnameTextController.text,
          'email': emailTextController.text,
          'username': usernameTextController.text,
          'password': passwordTextController.text,
        });

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registration successful."),
          backgroundColor: Colors.red,
        ),
      );
      Navigator.of(context).pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registration failed."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    fullnameTextController.dispose();
    emailTextController.dispose();
    usernameTextController.dispose();
    passwordTextController.dispose();
    confirmpasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          toolbarHeight: 75.0,
          title: const Text(
            "Create your account",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: mainColor,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onTap: () {
              // Navigator.popAndPushNamed(context, "/login");
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
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height - MediaQuery.of(context).padding.top - 75,
            ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                padding: const EdgeInsets.all(30),
                width: [512.0, size.width * 0.9].reduce(min),
                height: 512,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround, // Adjust the spacing here
                  children: [
                    textField(
                      controller: fullnameTextController,
                      labelText: "Fullname",
                      fillColor: backgroundColor,
                      icon: const Icon(Icons.person),
                    ),
                    textField(
                      controller: emailTextController,
                      labelText: "Email",
                      fillColor: backgroundColor,
                      inputType: TextInputType.emailAddress,
                      icon: const Icon(Icons.email_outlined),
                    ),
                    textField(
                      controller: usernameTextController,
                      labelText: "Username",
                      fillColor: backgroundColor,
                      icon: const Icon(Icons.account_box_outlined),
                    ),
                    textField(
                      controller: passwordTextController,
                      labelText: "Password",
                      fillColor: backgroundColor,
                      obscureText: true,
                      icon: const Icon(Icons.lock_outline),
                    ),
                    textField(
                      controller: confirmpasswordTextController,
                      labelText: "Repeat Password",
                      fillColor: backgroundColor,
                      obscureText: true,
                      icon: const Icon(Icons.lock_outline),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50, // Updated height
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Create Account"),
                        onPressed: () {
                          if (passwordTextController.text ==
                              confirmpasswordTextController.text) {
                            _registerAccount();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Password and Comfrim Password does not match."),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Column(
                      children: [
                        const Text(
                            "By creating an account, you have accepted our"),
                        TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    insetPadding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(20.0),
                                      child: const Text(
                                        "Terms and Conditions",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: const Text(
                            "Terms and Conditions.",
                            style: TextStyle(
                              color: Color(0xff7eb0de),
                            ),
                          ),
                        ),
                      ],
                    )
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
