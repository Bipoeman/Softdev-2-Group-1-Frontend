import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:ruam_mitt/Dinodengzz/Component/hud.dart';
import 'package:ruam_mitt/Dinodengzz/Component/jump_button.dart';
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

  late JoystickComponent joystick;
  late final JumpButton jumpButton = JumpButton();
  late final Hud hud = Hud();
  bool showControls = false;
  bool levelComplete = false;

  Color backgroundColor() => const Color.fromARGB(255, 30, 28, 45);

  @override
  FutureOr<void> onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
    _loadLevel();
    add(jumpButton);
    add(hud);
  }

  @override
  void update(double dt) {
    updateJoystick();
    hud.updateLifeCount(player.remainingLives);
    super.update(dt);
  }

  void updateJoystick() {
    if (showControls) player.hasJumped = jumpButton.hasJumped;
  }

  void _loadLevel() {
    Level world = Level(
      levelName: game.levelNames[currentLevel],
      player: player,
    );

    cam = CameraComponent.withFixedResolution(
      world: world,
      width: 640,
      height: 320,
    );
    cam.viewfinder.anchor = Anchor.topLeft;

    add(world);
    add(cam);
  }
}
