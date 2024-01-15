import "package:flutter/material.dart";
import "dart:math";

const Color backgroundColor = Color(0xffe8e8e8);
const Color mainColor = Color(0xffd33333);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height - MediaQuery.of(context).padding.top,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                    height: [150.0, size.width * 0.4].reduce(min),
                    width: [150.0, size.width * 0.4].reduce(min),
                    decoration: const BoxDecoration(
                      color: mainColor,
                    ),
                    child: const Text(
                      "Logo Here",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const Column(
                    children: [
                      Text(
                        "NAME",
                        style: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      Text(
                        "PORTAL APP",
                        style: TextStyle(
                          color: mainColor,
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
                      color: Colors.white,
                    ),
                    child: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              fillColor: backgroundColor,
                              filled: true,
                              labelStyle: TextStyle(color: Colors.grey[400]),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(30, 0, 5, 0),
                              labelText: "Email or Username",
                              prefixIconColor: Colors.white,
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: backgroundColor,
                              filled: true,
                              labelStyle: TextStyle(color: Colors.grey[400]),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(30, 0, 5, 0),
                              labelText: "Password",
                              prefixIconColor: Colors.white,
                              prefixIcon: const Icon(Icons.lock_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              child: const Text(
                                "Forgot password?",
                                style: TextStyle(color: Color(0xff7eb0de)),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 42,
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
                              child: const Text("Login"),
                              onPressed: () {},
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: const Text(
                                  "Create an account",
                                  style: TextStyle(
                                    color: Color(0xff7eb0de),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
