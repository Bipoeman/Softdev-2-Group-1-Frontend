import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ruam_mitt/Dinodengzz/levelselect.dart';
import 'package:ruam_mitt/Dinodengzz/start.dart';
import 'package:ruam_mitt/Dinodengzz/dinodengzz.dart';

class MyGame extends StatefulWidget {
  const MyGame({super.key});

  @override
  State<MyGame> createState() => _GameHomePageState();
}

class _GameHomePageState extends State<MyGame> {
  late DinoDengzz game;

  @override
  void initState() {
    super.initState();
    game = DinoDengzz(); // Pass context here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StartScreen(
        onStartPressed: () {
          runApp(GameWidget(game: game));
        },
        onLevelSelectionPressed: () {
          _navigateToLevelSelection(context, game);
        },
        onExitPressed: () {
          Navigator.popUntil(context, (route) => false);
          Navigator.pushNamed(context, '/login');
        },
      ),
    );
  }

  void _navigateToLevelSelection(BuildContext context, DinoDengzz game) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LevelSelectionScreen(
          levelNames: game.levelNames,
          onLevelSelected: (selectedLevelIndex) {
            game.currentLevelIndex = selectedLevelIndex;
            Navigator.pop(context); // Close the level selection screen
            runApp(GameWidget(game: game));
          },
        ),
      ),
    );
  }
}
