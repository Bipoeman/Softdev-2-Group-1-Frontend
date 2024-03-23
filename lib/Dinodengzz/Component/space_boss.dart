import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:ruam_mitt/Dinodengzz/Component/custom_hitbox.dart';
import 'package:ruam_mitt/Dinodengzz/Component/space_bullet.dart';
import 'package:ruam_mitt/Dinodengzz/Component/space_kuayteaw.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

enum BossState {
  phase0,
  phase1,
  phase2,
  phase3,
  phase4,
  hit,
  transformed,
  finalformed,
  finishedformed,
  dissappering,
}

class Boss extends SpriteAnimationGroupComponent with HasGameRef<GameRoutes>, CollisionCallbacks {
  Boss();

  late final SpriteAnimation phase0;
  late final SpriteAnimation phase1;
  late final SpriteAnimation phase2;
  late final SpriteAnimation phase3;
  late final SpriteAnimation phase4;
  late final SpriteAnimation hitAnimation;
  late final SpriteAnimation transformedAnimation;
  late final SpriteAnimation finalformedAnimation;
  late final SpriteAnimation finalfinishedAnimation;
  late final SpriteAnimation dissappearingAnimation;

  CustomHitBox hitbox = CustomHitBox(
    offsetX: 10,
    offsetY: 10,
    width: 100,
    height: 93,
  );
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;
  int lifePoint = 1000;
  int hitCount = 0;
  bool bossCleared = false;

  @override
  FutureOr<void> onLoad() async {
    _loadAllAnimation();
    //debugMode = true;
    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
      isSolid: true,
    ));
    return super.onLoad();
  }

  void _loadAllAnimation() {
    phase0 = _spriteAnimation('Daddy Patrick Phase 1', 1, 1);
    phase1 = _spriteAnimation('Daddy Patrick Phase 1', 8, 0.25);
    phase2 = _spriteAnimation('Daddy Patrick Phase 2', 9, 0.25);
    phase3 = _spriteAnimation('Daddy Patrick Phase 3', 3, 0.5);
    phase4 = _spriteAnimation('Patrick Final Form', 3, 0.5);
    hitAnimation = _spriteAnimation('Patrick Hit Damage', 3, 0.08)..loop = false;
    transformedAnimation = _spriteAnimation('Patrick Hit Next Stage', 13, 0.08)..loop = false;
    finalformedAnimation = _spriteAnimation('Patrick Final Transforming 1', 4, 0.05)..loop = false;
    finalfinishedAnimation = _spriteAnimation('Patrick Final Transforming 2', 16, 0.05)
      ..loop = false;
    dissappearingAnimation = _speacialspriteAnimation('Desappearing', 8, 0.025);
    animations = {
      BossState.phase0: phase0,
      BossState.phase1: phase1,
      BossState.phase2: phase2,
      BossState.phase3: phase3,
      BossState.phase4: phase4,
      BossState.hit: hitAnimation,
      BossState.transformed: transformedAnimation,
      BossState.finalformed: finalformedAnimation,
      BossState.finishedformed: finalfinishedAnimation,
      BossState.dissappering: dissappearingAnimation,
    };

    current = BossState.phase0;
  }

  SpriteAnimation _spriteAnimation(String state, int amount, double stepTime) {
    return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('Main Characters/Patrick (Boss)/$state.png'),
        SpriteAnimationData.sequenced(
            amount: amount, stepTime: stepTime, textureSize: Vector2.all(120)));
  }

  SpriteAnimation _speacialspriteAnimation(String state, int amount, double stepTime) {
    return SpriteAnimation.fromFrameData(
      gameRef.images.fromCache('Main Characters/$state (96x96).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(96),
        loop: false,
      ),
    );
  }

  @override
  Future<void> onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) async {
    if (other is Bullet) lifePoint -= 3;
    if (other is Kuayteaw) {
      lifePoint -= 250;
      hitCount++;
      switch (hitCount) {
        case 1:
          {
            current = BossState.hit;
            await animationTicker?.completed;
            animationTicker?.reset();
            current = BossState.transformed;
            await animationTicker?.completed;
            animationTicker?.reset();
            current = BossState.phase2;
          }
          break;
        case 2:
          {
            current = BossState.hit;
            await animationTicker?.completed;
            animationTicker?.reset();
            current = BossState.transformed;
            await animationTicker?.completed;
            animationTicker?.reset();
            current = BossState.phase3;
          }
          break;
        case 3:
          {
            current = BossState.hit;
            await animationTicker?.completed;
            animationTicker?.reset();
            current = BossState.transformed;
            await animationTicker?.completed;
            animationTicker?.reset();
            current = BossState.finalformed;
            await animationTicker?.completed;
            animationTicker?.reset();
            current = BossState.finishedformed;
            await animationTicker?.completed;
            animationTicker?.reset();
            current = BossState.phase4;
          }
          break;
        case 4:
          bossCleared = true;
          current = BossState.dissappering;
          await animationTicker?.completed;
          animationTicker?.reset();
          hitCount++;
          FlameAudio.bgm.stop;
          showDefeatDialog(game.buildContext);

          break;
        default:
          break;
      }
      super.onCollisionStart(intersectionPoints, other);
    }
  }

  void showDefeatDialog(BuildContext? context) {
    if (context == null) {
      return;
    }

    String title = "คนที่คุณไม่รู้ว่าใคร";

    List<String> contents = [
      "ดีใจด้วยนะในที่สุดทุกอย่างก็จะกลับมาสงบสุขอีกครั้ง",
      "ข้าไม่รู้ ข้าไม่เคยลอง",
      "ไม่บอก",
      "ใช่แล้วมันจบแล้วละ.. เวลาของข้ามาถึงแล้ว เจ้าต้องเดินทางต่อไปโดยไม่มีข้า ",
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.red.withOpacity(0.5),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        showMemeDialog(context, title, contents, 2);
                      },
                      child: const Text(
                        "แล้วนายเป็นใครอะ",
                        style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    color: Colors.green.withOpacity(0.5),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        showMemeDialog(context, title, contents, 1);
                      },
                      child: const Text(
                        "นายไม่มาสู้เองละ",
                        style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    color: Colors.blue.withOpacity(0.5),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        showTrueDialog(context, title, contents, 3);
                      },
                      child: const Text(
                        "ทุกอย่าง... จบลงแล้วใช่มั้ย",
                        style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ]);
      },
    );
  }

  void showMemeDialog(BuildContext context, String title, List<String> contents, int index) {
    if (index >= contents.length) {
      return;
    }

    showDialog(
      barrierDismissible: false,
      context: context,
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
                    contents[index],
                    textStyle: const TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 20,
                      color: Color.fromARGB(255, 58, 52, 52),
                    ),
                    speed: const Duration(milliseconds: 50),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ],
          ),
          actions: [
            Container(
              color: Colors.red.withOpacity(0.5),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  game.showLevelCompleteBoss();
                },
                child: const Text(
                  "ห่ะ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Kanit',
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showTrueDialog(BuildContext context, String title, List<String> contents, int index) {
    if (index >= contents.length) {
      return;
    }

    showDialog(
      barrierDismissible: false,
      context: context,
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
                    contents[index],
                    textStyle: const TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 20,
                      color: Color.fromARGB(255, 58, 52, 52),
                    ),
                    speed: const Duration(milliseconds: 50),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ],
          ),
          actions: [
            Container(
              color: Colors.red.withOpacity(0.5),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  game.showLevelCompleteBoss();
                },
                child: const Text(
                  "เดี๋ยวก่อน...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Kanit',
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
