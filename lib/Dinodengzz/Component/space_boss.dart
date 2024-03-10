import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
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

class Boss extends SpriteAnimationGroupComponent
    with HasGameRef<GameRoutes>, CollisionCallbacks {
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
    hitAnimation = _spriteAnimation('Patrick Hit Damage', 3, 0.08)
      ..loop = false;
    transformedAnimation = _spriteAnimation('Patrick Hit Next Stage', 13, 0.08)
      ..loop = false;
    finalformedAnimation =
        _spriteAnimation('Patrick Final Transforming 1', 4, 0.05)..loop = false;
    finalfinishedAnimation =
        _spriteAnimation('Patrick Final Transforming 2', 16, 0.05)
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

  SpriteAnimation _speacialspriteAnimation(
      String state, int amount, double stepTime) {
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
  Future<void> onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) async {
    if (other is Bullet) lifePoint--;
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
          showDefeatDialog();
          gameRef.showLevelCompleteBoss();
          hitCount++;
          break;
        default:
          break;
      }
      super.onCollisionStart(intersectionPoints, other);
    }
  }

  void showDefeatDialog() {
    print('hi');
  }
}
