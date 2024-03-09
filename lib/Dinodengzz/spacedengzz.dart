import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:ruam_mitt/Dinodengzz/Component/space_bullet.dart';
import 'package:ruam_mitt/Dinodengzz/Component/space_bullet_manager.dart';
import 'package:ruam_mitt/Dinodengzz/Component/space_enemy_manager.dart';
import 'package:ruam_mitt/Dinodengzz/Component/space_hud.dart';
import 'package:ruam_mitt/Dinodengzz/Component/space_player.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

class SpaceDengzz extends Component with HasGameRef<GameRoutes>, DragCallbacks {
  SpaceDengzz({
    super.key,
    required this.onPausePressed,
    required this.onLevelCompleted,
    required this.onGameOver,
  });

  static const id = 'BossFight';
  final SpacePlayer playerShip = SpacePlayer();
  final EnemyManager enemies = EnemyManager();
  late BulletManager bullet;
  final VoidCallback? onPausePressed;
  final ValueChanged<int>? onLevelCompleted;
  final VoidCallback? onGameOver;
  late SpaceHud hud;

  @override
  FutureOr<void> onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setPortrait();
    double screenWidth = game.size.y > game.size.x ? game.size.x : game.size.y;
    double screenHeight = game.size.y > game.size.x ? game.size.y : game.size.x;
    hud = SpaceHud(screenWidth, screenHeight);
    playerShip.position = Vector2(screenWidth * 0.469, screenHeight * 0.869);
    BulletManager bullet = BulletManager(playerShip.position);

    add(playerShip);
    add(hud);
    add(enemies);
    add(bullet);
  }

  @override
  void update(double dt) {
    hud.updateLifeCount(playerShip.remainingLives);
    super.update(dt);
  }
}
