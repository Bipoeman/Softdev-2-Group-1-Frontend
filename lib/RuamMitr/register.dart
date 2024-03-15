import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/loading_screen.dart';
import 'package:ruam_mitt/RuamMitr/Component/frequent_widget/custom_text_field.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'dart:math';

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
  var _registerButtonEnabled = false;
  final _formKey = GlobalKey<FormState>();
  final _isEmptyFromStart = {
    "fullname": true,
    "email": true,
    "username": true,
    "password": true,
    "confirmPassword": true,
  };

  (bool, String) fullnameChecker(String fullname) {
    String fullnameWarning = "";
    if (RegExp(r'^\s').hasMatch(fullname)) {
      fullnameWarning += "\n - no whitespace before the first character.";
    }
    if (RegExp(r'\s$').hasMatch(fullname)) {
      fullnameWarning += "\n - no whitespace after the last character.";
    }
    if (RegExp(r'^[0-9]').hasMatch(fullname)) {
      fullnameWarning += "\n - the first character cannot be a number.";
    }
    if (RegExp(r'[!@#$%^&*()?":{}|<>]').hasMatch(fullname)) {
      fullnameWarning += "\n - no special character.";
    }
    return (fullnameWarning.isNotEmpty, fullnameWarning);
  }

  (bool, String) emailChecker(String email) {
    String emailWarning = "";
    if (!EmailValidator.validate(email)) {
      emailWarning += "The e-mail is incorrect form.";
    }
    return (emailWarning.isNotEmpty, emailWarning);
  }

  (bool, String) usernameChecker(String username) {
    String usernameWarning = "";
    if (username.length < 5) {
      usernameWarning += "\n - at least 5 characters.";
    }
    if (RegExp(r'\s').hasMatch(username)) {
      usernameWarning += "\n - no whitespace.";
    }
    if (RegExp(r'^[0-9]').hasMatch(username)) {
      usernameWarning += "\n - the first character cannot be a number.";
    }
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(username)) {
      usernameWarning += "\n - no special character.";
    }
    return (usernameWarning.isNotEmpty, usernameWarning);
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

  String? fullnameValidator(String? value) {
    if (_isEmptyFromStart["fullname"]! && value!.isEmpty) {
      return null;
    }
    if (_isEmptyFromStart["fullname"]!) {
      _isEmptyFromStart["fullname"] = false;
      setState(() {});
    }

    var (isFullnameError, fullnameMessage) = fullnameChecker(value!);
    if (value.isEmpty) {
      return "Please enter your full name.";
    }
    if (isFullnameError) {
      return "Full name must have $fullnameMessage";
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (_isEmptyFromStart["email"]! && value!.isEmpty) {
      return null;
    }
    if (_isEmptyFromStart["email"]!) {
      _isEmptyFromStart["email"] = false;
      setState(() {});
    }

    var (isEmailError, emailMessage) = emailChecker(value!);
    if (value.isEmpty) {
      return "Please enter your e-mail.";
    }
    if (isEmailError) {
      return emailMessage;
    }
    return null;
  }

  String? usernameValidator(String? value) {
    if (_isEmptyFromStart["username"]! && value!.isEmpty) {
      return null;
    }
    if (_isEmptyFromStart["username"]!) {
      _isEmptyFromStart["username"] = false;
      setState(() {});
    }

    var (isUsernameError, usernameMessage) = usernameChecker(value!);
    if (value.isEmpty) {
      return "Please enter your username.";
    }
    if (isUsernameError) {
      return "Username must have $usernameMessage";
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (_isEmptyFromStart["password"]! && value!.isEmpty) {
      return null;
    }
    if (_isEmptyFromStart["password"]!) {
      _isEmptyFromStart["password"] = false;
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
    if (_isEmptyFromStart["confirmPassword"]! && value!.isEmpty) {
      return null;
    }
    if (_isEmptyFromStart["confirmPassword"]!) {
      _isEmptyFromStart["confirmPassword"] = false;
      setState(() {});
    }

    if (value!.isEmpty) {
      return "Please enter password.";
    }
    if (value != passwordTextController.text) {
      return "Confirm password and the password does not match.";
    }
    return null;
  }

  void validateRegisterInputs(String value) {
    bool noAnyStartStates = _isEmptyFromStart.values.every((element) => !element);
    if (_formKey.currentState!.validate() && !_registerButtonEnabled && noAnyStartStates) {
      _registerButtonEnabled = true;
      setState(() {});
    } else if (!_formKey.currentState!.validate() && _registerButtonEnabled) {
      _registerButtonEnabled = false;
      setState(() {});
    }
  }

  void _registerAccount() async {
    showLoadingScreen(context: context, message: "Registering...");
    ThemeData theme = Theme.of(context);
    var response = await http.post(
      Uri.parse("$api$registerPageRoute"),
      body: {
        'fullname': fullnameTextController.text,
        'email': emailTextController.text,
        'username': usernameTextController.text,
        'password': passwordTextController.text,
      },
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Registration successful.",
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
            ),
          ),
          backgroundColor: theme.colorScheme.primary,
        ),
      );
      Navigator.of(context).pushNamedAndRemoveUntil(
        loginPageRoute,
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Registration failed.",
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
            ),
          ),
          backgroundColor: theme.colorScheme.primary,
        ),
      );
      Navigator.pop(context);
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
    ThemeData theme = Theme.of(context);
    ThemeProvider themes = Provider.of<ThemeProvider>(context);
    CustomThemes ruammitrTheme = themes.themeFrom("RuamMitr")!;
    return SafeArea(
      child: Container(
        decoration: ruamMitrBackgroundGradient(themes),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            toolbarHeight: 75.0,
            title: Text(
              "Create an account",
              style: TextStyle(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold),
            ),
            backgroundColor: theme.colorScheme.primary,
            leading: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios,
                color: theme.colorScheme.onPrimary,
              ),
              onTap: () {
                Navigator.popUntil(context, (route) => false);
                Navigator.pushNamed(context, loginPageRoute);
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
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
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        textField(
                          controller: fullnameTextController,
                          validator: fullnameValidator,
                          labelText: "Full Name",
                          context: context,
                          icon: const Icon(Icons.person),
                          onChanged: validateRegisterInputs,
                        ),
                        textField(
                          controller: emailTextController,
                          validator: emailValidator,
                          labelText: "E-mail",
                          context: context,
                          inputType: TextInputType.emailAddress,
                          icon: const Icon(Icons.email_outlined),
                          onChanged: validateRegisterInputs,
                        ),
                        textField(
                          controller: usernameTextController,
                          validator: usernameValidator,
                          labelText: "Username",
                          context: context,
                          icon: const Icon(Icons.account_box_outlined),
                          onChanged: validateRegisterInputs,
                        ),
                        textField(
                          controller: passwordTextController,
                          validator: passwordValidator,
                          labelText: "Password",
                          context: context,
                          obscureText: true,
                          icon: const Icon(Icons.lock_outline),
                          onChanged: validateRegisterInputs,
                        ),
                        textField(
                          controller: confirmpasswordTextController,
                          validator: confirmPasswordValidator,
                          labelText: "Repeat Password",
                          context: context,
                          obscureText: true,
                          icon: const Icon(Icons.lock_outline),
                          onChanged: validateRegisterInputs,
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
                            onPressed: _registerButtonEnabled ? _registerAccount : null,
                            child: const Text("Create Account"),
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
    );
  }
}
