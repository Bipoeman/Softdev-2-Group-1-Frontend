import 'package:flutter/material.dart';

class LevelSelectionScreen extends StatelessWidget {
  final List<String> levelNames;
  final ValueChanged<int> onLevelSelected;
  final VoidCallback? onBackPressed;
  final VoidCallback? onTutorialPressed;

  const LevelSelectionScreen({
    super.key,
    required this.levelNames,
    required this.onLevelSelected,
    required this.onBackPressed,
    required this.onTutorialPressed,
  });

  static const id = 'LevelSelection';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select a Level',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            for (int i = 0; i < levelNames.length; i++)
              ElevatedButton.icon(
                onPressed: () {
                  onLevelSelected(i);
                },
                icon: Image.asset("assets/Menu/Levels/0${i + 1}.png"),
                label: Text('Level ${i + 1}'),
              ),
            const SizedBox(height: 5),
            IconButton(
              onPressed: onTutorialPressed,
              icon: Image.asset("assets/Menu/Buttons/Leaderboard.png"),
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
