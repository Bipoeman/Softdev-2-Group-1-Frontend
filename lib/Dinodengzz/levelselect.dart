import 'package:flutter/material.dart';

class LevelSelectionScreen extends StatelessWidget {
  final List<String> levelNames;
  final ValueChanged<int> onLevelSelected;

  LevelSelectionScreen(
      {required this.levelNames, required this.onLevelSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Level'),
      ),
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
              ElevatedButton(
                onPressed: () {
                  onLevelSelected(i);
                },
                child: Text('Level ${i + 1}'),
              ),
          ],
        ),
      ),
    );
  }
}
