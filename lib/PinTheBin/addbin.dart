import 'dart:math';
import "package:flutter/material.dart";
import 'package:ruam_mitt/PinTheBin/navbar.dart';

Color colorbackground = const Color(000000);

class AddbinPage extends StatefulWidget {
  const AddbinPage({super.key});

  @override
  State<AddbinPage> createState() => _AddbinPageState();
}

class _AddbinPageState extends State<AddbinPage> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: NavBar(),
    );
  }
}

class slidebar extends StatefulWidget {
  @override
  State<slidebar> createState() => _slidebar();
}

class _slidebar extends State<slidebar> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Container();
  }
}
