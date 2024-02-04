import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  final VoidCallback onStartPressed;
  final VoidCallback onLevelSelectionPressed;
  final VoidCallback onExitPressed;

  const StartScreen({super.key, 
    required this.onStartPressed,
    required this.onLevelSelectionPressed,
    required this.onExitPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'DinoDengzz',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onStartPressed,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Game'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onLevelSelectionPressed,
              icon: const Icon(Icons.layers),
              label: const Text('Select Level'),
            ),
            const SizedBox(height: 20),
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
