import "package:flutter/material.dart";

Color backgroundColor = const Color(0xffe8e8e8);
Color mainColor = const Color(0xffd33333);
Color textColor = const Color(0xff000000);

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Text(
      "There is nothing in \"Profile\" page yet.",
      style: TextStyle(
        color: textColor,
        fontSize: 20,
      ),
    );
  }
}
