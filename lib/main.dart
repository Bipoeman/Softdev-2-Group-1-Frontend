import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/RuamMitr/InternetControl/injection.dart';
import 'package:ruam_mitt/RuamMitr/home.dart';
import 'package:ruam_mitt/RuamMitr/settings.dart';
import 'package:ruam_mitt/RuamMitr/profile.dart';
import 'package:ruam_mitt/RuamMitr/login.dart';
import 'package:ruam_mitt/RuamMitr/register.dart';
import 'package:ruam_mitt/Dinodengzz/navigation.dart';
import 'package:ruam_mitt/global_const.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const SuperApp(),
    ),
  );
  DependencyInjection.init();
}

class SuperApp extends StatefulWidget {
  const SuperApp({super.key});

  @override
  State<SuperApp> createState() => _SuperAppState();
}

class _SuperAppState extends State<SuperApp> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themes = Provider.of<ThemeProvider>(context);

    return GetMaterialApp(
      initialRoute: loginPageRoute,
      routes: {
        loginPageRoute: (context) => const LoginPage(),
        registerPageRoute: (context) => const RegisterPage(),
        ruamMitrPageRoute["home"]!: (context) => const HomePage(),
        ruamMitrPageRoute["settings"]!: (context) => const SettingsPage(),
        ruamMitrPageRoute["profile"]!: (context) => const ProfilePage(),
        dinodengzzPageRoute: (context) => const MyGame(),
      },
      title: "RuamMitr - App for Uni Students",
      theme: themes.themeFrom("RuamMitr")?.themeData,
    );
  }
}
