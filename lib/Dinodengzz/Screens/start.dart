import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  final VoidCallback onLevelSelectionPressed;
  final VoidCallback onExitPressed;
  final VoidCallback onSettingPressed;

  const StartScreen(
      {super.key,
      required this.onLevelSelectionPressed,
      required this.onExitPressed,
      required this.onSettingPressed});

  static const id = 'StartScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'DinoDengzz',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
                color: Colors.deepOrange[200],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: onLevelSelectionPressed,
              icon: Image.asset("assets/Menu/Buttons/Play.png"),
              label: const Text('Play'),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: onSettingPressed,
              icon: Image.asset("assets/Menu/Buttons/Settings.png"),
              label: const Text('Setting'),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: onExitPressed,
              icon: const Icon(Icons.exit_to_app),
              label: const Text('Exit'),
            ),
          ],
        ),
      ),
    );
  }
}
