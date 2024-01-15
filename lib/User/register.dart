import 'package:flutter/material.dart';

const Color backgroundColor = Color(0xffe8e8e8);
const Color mainColor = Color(0xffd33333);

TextFormField textField({
  required String labelText,
  required Color fillColor,
  Icon? icon,
  bool? obscureText,
  TextInputType? inputType,
}) {
  return TextFormField(
    keyboardType: inputType,
    obscureText: obscureText ?? false,
    decoration: InputDecoration(
      fillColor: fillColor,
      filled: true,
      labelStyle: TextStyle(color: Colors.grey[400]),
      contentPadding: const EdgeInsets.fromLTRB(30, 0, 5, 0),
      labelText: labelText,
      prefixIconColor: Colors.white,
      prefixIcon: icon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: size.height * 0.2,
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
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: size.height * 0.7),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  textField(
                    labelText: "Fullname",
                    fillColor: backgroundColor,
                  ),
                  textField(
                      labelText: "Email",
                      fillColor: backgroundColor,
                      inputType: TextInputType.emailAddress),
                  textField(
                    labelText: "Username",
                    fillColor: backgroundColor,
                  ),
                  textField(
                    labelText: "Password",
                    fillColor: backgroundColor,
                    obscureText: true,
                  ),
                  textField(
                    labelText: "Repeat Password",
                    fillColor: backgroundColor,
                    obscureText: true,
                  ),
                  SizedBox(
                    width: double.infinity,
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
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
