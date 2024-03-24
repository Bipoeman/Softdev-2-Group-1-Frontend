import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

class MyGame extends StatefulWidget {
  const MyGame({super.key});

  @override
  State<MyGame> createState() => _GameHomePageState();
}

class _GameHomePageState extends State<MyGame> {
  late GameRoutes game;

  @override
  void initState() {
    super.initState();
    game = GameRoutes();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    game.stopBGMInApp();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameWidget.controlled(gameFactory: GameRoutes.new),
    );
  }
}
