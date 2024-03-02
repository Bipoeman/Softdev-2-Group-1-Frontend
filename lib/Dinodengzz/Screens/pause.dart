import 'package:flutter/material.dart';

class PauseMenu extends StatelessWidget {
  const PauseMenu({
    super.key,
    this.onResumePressed,
    this.onSettingPressed,
    this.onExitPressed,
    this.onRetryPressed,
  });

  static const id = 'PauseMenu';

  final VoidCallback? onResumePressed;
  final VoidCallback? onRetryPressed;
  final VoidCallback? onSettingPressed;
  final VoidCallback? onExitPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(210, 229, 238, 238),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Paused',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: onResumePressed,
                child: const Text('Resume'),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: onRetryPressed,
                child: const Text('Retry'),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: onSettingPressed,
                child: const Text('Setting'),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: onExitPressed,
                child: const Text('Exit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
