import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/RuamMitr/login.dart';
import 'package:ruam_mitt/RuamMitr/register.dart';
import 'package:ruam_mitt/RuamMitr/portal.dart';
import 'package:ruam_mitt/Dinodengzz/navigation.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const SuperApp(),
  ));
}

class SuperApp extends StatefulWidget {
  const SuperApp({super.key});

  @override
  State<SuperApp> createState() => _SuperAppState();
}

class _SuperAppState extends State<SuperApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/login",
      routes: {
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(),
        "/home": (context) => const PortalPage(),
        "/game": (context) => const MyGame(),
      },
      title: "RuamMitr - App for Uni Students",
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
