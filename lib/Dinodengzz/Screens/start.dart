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
      persistentFooterAlignment: AlignmentDirectional.centerStart,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'DinoDengzz',
              style: TextStyle(
                fontSize: 90,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
                color: Color.fromRGBO(255, 138, 101, 1),
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
