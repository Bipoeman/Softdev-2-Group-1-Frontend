import 'package:flutter/material.dart';
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
  TextFormField textField({
    required String labelText,
    required BuildContext context,
    Icon? icon,
    bool? obscureText,
    TextInputType? inputType,
    void Function(String)? onChanged,
    void Function()? onTap,
    void Function(PointerDownEvent)? onTapOutside,
    void Function()? onEditingComplete,
    void Function(String)? onFieldSubmitted,
    void Function(String?)? onSaved,
  }) {
    ThemeData theme = Theme.of(context);
    return TextFormField(
      keyboardType: inputType,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        fillColor: theme.colorScheme.background.withOpacity(0.8),
        filled: true,
        labelStyle: TextStyle(color: theme.colorScheme.onBackground.withOpacity(0.5)),
        contentPadding: const EdgeInsets.fromLTRB(30, 0, 5, 0),
        labelText: labelText,
        prefixIconColor: theme.colorScheme.onBackground,
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: onChanged,
      onTap: onTap,
      onTapOutside: onTapOutside,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.background,
        appBar: AppBar(
          toolbarHeight: 75.0,
          title: Text(
            "Create your account",
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
            ),
          ),
          backgroundColor: theme.colorScheme.primary,
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: theme.colorScheme.onPrimary,
            ),
            onTap: () {
              Navigator.popUntil(context, (route) => false);
              Navigator.pushNamed(context, "/login");
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
                  color: theme.colorScheme.primaryContainer.withOpacity(0.8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround, // Adjust the spacing here
                  children: [
                    textField(
                      labelText: "Fullname",
                      context: context,
                      icon: const Icon(Icons.person),
                    ),
                    textField(
                      labelText: "Email",
                      context: context,
                      inputType: TextInputType.emailAddress,
                      icon: const Icon(Icons.email_outlined),
                    ),
                    textField(
                      labelText: "Username",
                      context: context,
                      icon: const Icon(Icons.account_box_outlined),
                    ),
                    textField(
                      labelText: "Password",
                      context: context,
                      obscureText: true,
                      icon: const Icon(Icons.lock_outline),
                    ),
                    textField(
                      labelText: "Repeat Password",
                      context: context,
                      obscureText: true,
                      icon: const Icon(Icons.lock_outline),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50, // Updated height
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
                        child: const Text("Create Account"),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            "/home",
                            (route) => false,
                          );
                        },
                      ),
                    ),
                    Column(
                      children: [
                        const Text("By creating an account, you have accepted our"),
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
                              },
                            );
                          },
                          child: Text(
                            "Terms and Conditions.",
                            style: TextStyle(
                              color: theme.colorScheme.secondary,
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
