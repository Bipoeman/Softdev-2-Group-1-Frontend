import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:ruam_mitt/Dinodengzz/Component/space_boss.dart';
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
  final Boss boss = Boss();
  late BulletManager bullet;
  final VoidCallback? onPausePressed;
  final VoidCallback? onLevelCompleted;
  final VoidCallback? onGameOver;
  late SpaceHud hud;
  late ParallaxComponent background;
  late int initialBossHealth = 1000;
  late int currentBossHealth;
  bool gameOver = false;
  int time = 0;

  @override
  FutureOr<void> onLoad() async {
    await Flame.device.setPortrait();
    await Flame.device.fullScreen();
    double screenWidth = game.size.x;
    double screenHeight = game.size.y;
    hud = SpaceHud(screenWidth, screenHeight);
    playerShip.position = Vector2(screenWidth * 0.5 - 16, screenHeight * 0.869);
    playerShip.size = Vector2.all(64);
    boss.position = Vector2(screenWidth * 0.5 - 60, screenHeight * 0.069);
    bullet = BulletManager(playerShip.position, playerShip.gameOver);
    background = ParallaxComponent(
      parallax: await gameRef.loadParallax(
        [ParallaxImageData('Background/Space(64 x 64).png')],
        baseVelocity: Vector2(0, -40),
        repeat: ImageRepeat.repeat,
        fill: LayerFill.none,
      ),
    );

    add(background);
    add(playerShip);
    add(hud);
    add(boss);

    showFirstDialog(game.buildContext);
  }

  @override
  void update(double dt) {
    hud.updateLifeCount(playerShip.remainingLives);
    hud.updateEnemyHealth(boss.lifePoint / 1000);
    playerShip.onMoveLeft(hud.moveLeft);
    playerShip.onMoveRight(hud.moveRight);
    gameOver = (playerShip.gameOver || boss.bossCleared);
    bullet.gameOver = gameOver;
    enemies.gameOver = gameOver;
    currentBossHealth = boss.lifePoint;
    if ((initialBossHealth - currentBossHealth) >= 250) {
      playerShip.remainingLives++;
      initialBossHealth = currentBossHealth;
    }

    super.update(dt);
  }

  void showFirstDialog(BuildContext? context) {
    if (context == null) {
      return;
    }

    String title = "ดาวตัวเบิ้ม";

    List<String> contents = [
      "แกมาที่นี้ได้อย่างไรกัน แต่ไม่สำคัญหรอกเพราะฉันจะจัดการแกเอง",
    ];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(219, 255, 192, 136),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(width: 16.0, color: Color.fromARGB(255, 70, 24, 6)),
          ),
          contentPadding: const EdgeInsets.all(24.0),
          title: Text(
            title,
            style: const TextStyle(
              color: Color.fromARGB(255, 206, 63, 89),
              fontFamily: 'Kanit',
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    textStyle: const TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 20,
                      color: Color.fromARGB(255, 58, 52, 52),
                    ),
                    contents[0],
                    speed: const Duration(milliseconds: 55),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: Colors.red.withOpacity(0.5),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      boss.current = BossState.phase1;
                      FlameAudio.bgm
                          .play(game.finalBoss, volume: game.masterVolume * game.bgmVolume);
                      add(enemies);
                      add(bullet);
                    },
                    child: const Text(
                      "เข้ามาเลย!",
                      style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
