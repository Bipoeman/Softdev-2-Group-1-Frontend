import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final VoidCallback onRetryPressed;
  final VoidCallback onMainMenuPressed;

  const GameOverScreen(
      {super.key,
      required this.onRetryPressed,
      required this.onMainMenuPressed});

  static const id = 'GameOver';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Game Over',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetryPressed,
              child: const Text('Retry'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onMainMenuPressed,
              child: const Text('Main Menu'),
            ),
          ],
        ),
      ),
    );
  }
}
