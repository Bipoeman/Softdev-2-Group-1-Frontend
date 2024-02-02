import "package:flutter/material.dart";
import "dart:math";
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final url = Uri.parse("https://softdev2-backend.azurewebsites.net/login");
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  Future<bool> sendPostRequest() async {
    var response = await http.post(url, body: {
      "emailoruser": usernameTextController.text,
      "password": passwordTextController.text,
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.canvasColor,
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
                        height: [150.0, size.width * 0.4].reduce(min),
                        width: [150.0, size.width * 0.4].reduce(min),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                        ),
                        child: Text(
                          "Logo Here",
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "NAME",
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
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
                                prefixIconColor: theme.colorScheme.onBackground,
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
                                prefixIconColor: theme.colorScheme.onBackground,
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
                                child: Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                      color: theme.colorScheme.secondary),
                                ),
                                onPressed: () {},
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
                                  foregroundColor: theme.colorScheme.onPrimary,
                                ),
                                child: const Text("Login"),
                                onPressed: () async {
                                  if (await sendPostRequest() == true) {
                                    if (context.mounted) {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                        "/home",
                                        (route) => false,
                                      );
                                    }
                                  } else {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Login failed. Please check your credentials."),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                },
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
                        Navigator.popUntil(context, (route) => false);
                        Navigator.pushNamed(context, '/game');
                      },
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
