import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({
    super.key,
    this.onBackPressed,
  });

  static const id = 'Settings';
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 5),
            IconButton(
              onPressed: onBackPressed,
              icon: Image.asset("assets/Menu/Buttons/Back.png"),
            )
          ],
        ),
      ),
    );
  }
}
