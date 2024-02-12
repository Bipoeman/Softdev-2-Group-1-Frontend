// ignore_for_file: use_super_parameters

import 'dart:async';
import 'dart:ffi';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ruam_mitt/Dinodengzz/Component/player.dart';
import 'package:ruam_mitt/Dinodengzz/dinodengzz.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

class Checkpoint extends SpriteAnimationComponent
    with HasGameRef<GameRoutes>, CollisionCallbacks {
  Checkpoint({position, size})
      : super(
          position: position,
          size: size,
        );
  int star = 1;

  @override
  FutureOr<void> onLoad() {
    //debugMode = true;
    add(RectangleHitbox(
      position: Vector2(18, 18),
      size: Vector2(12, 46),
      collisionType: CollisionType.passive,
    ));
    animation = SpriteAnimation.fromFrameData(
        game.images
            .fromCache('Items/Checkpoints/Checkpoint/Checkpoint (No Flag).png'),
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: 1,
          textureSize: Vector2.all(64),
        ));
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player && other.noodleCollected) {
      if (other.fruitCount >= (other.fruitHave)) {
        star = 3;
      } else if (other.fruitCount > (other.fruitHave / 2)) {
        star = 2;
      } else {
        star = 1;
      }
      print(star);
      _reachedCheckpoint();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void _reachedCheckpoint() async {
    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache(
            'Items/Checkpoints/Checkpoint/Checkpoint (Flag Out) (64x64).png'),
        SpriteAnimationData.sequenced(
          amount: 26,
          stepTime: 0.05,
          textureSize: Vector2.all(64),
          loop: false,
        ));

    await animationTicker?.completed;

    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache(
            'Items/Checkpoints/Checkpoint/Checkpoint (Flag Idle)(64x64).png'),
        SpriteAnimationData.sequenced(
          amount: 10,
          stepTime: 0.05,
          textureSize: Vector2.all(64),
        ));
    gameRef.showLevelCompleteMenu(star);
  }
}
