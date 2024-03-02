import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:ruam_mitt/Dinodengzz/Component/hud.dart';
import 'package:ruam_mitt/Dinodengzz/Component/level.dart';
import 'package:ruam_mitt/Dinodengzz/Component/player.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

class DinoDengzz extends Component with HasGameReference<GameRoutes> {
  DinoDengzz(
    this.currentLevel, {
    super.key,
    required this.onPausePressed,
    required this.onLevelCompleted,
    required this.onGameOver,
  });

  static const id = 'Gameplay';

  final int currentLevel;
  final VoidCallback onPausePressed;
  final ValueChanged<int> onLevelCompleted;
  final VoidCallback onGameOver;

  late CameraComponent cam;
  Player player = Player(character: 'Relaxaurus');
  late double cameraWidth = 640;
  late double cameraHeight;

  late JoystickComponent joystick;
  late Hud hud;
  bool joyControls = true;
  bool levelComplete = false;

  Color backgroundColor() => const Color.fromARGB(255, 30, 28, 45);

  @override
  FutureOr<void> onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
    _loadLevel();
  }

  @override
  void update(double dt) {
    hud.updateLifeCount(player.remainingLives);
    if (joyControls) {
      player.hasJumped = hud.hasJumped;
      player.horizontalMovement = hud.horizontalMovement;
    }
    super.update(dt);
  }

  void _loadLevel() {
    Level world = Level(
      levelName: game.levelNames[currentLevel],
      player: player,
    );
    double screenWidth = game.size.x;
    double screenHeight = game.size.y;
    double aspectRatio = screenWidth / screenHeight;
    cameraHeight = cameraWidth / aspectRatio;
    hud = Hud(cameraHeight);

    cam = CameraComponent.withFixedResolution(
      world: world,
      width: cameraWidth,
      height: cameraHeight,
      hudComponents: [hud],
    );
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([world, cam]);
  }
}
