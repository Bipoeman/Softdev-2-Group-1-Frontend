// ignore_for_file: use_super_parameters, non_constant_identifier_names

import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ruam_mitt/Components/custom_hitbox.dart';
import 'package:ruam_mitt/Components/player.dart';
import 'package:ruam_mitt/dinodengzz.dart';

class Fruit extends SpriteAnimationComponent
    with HasGameRef<DinoDengzz>, CollisionCallbacks {
  final String fruit;

  Fruit({
    this.fruit = 'Apple',
    position,
    size,
  }) : super(
          position: position,
          size: size,
        );

  bool collected = false;
  final double stepTime = 0.05;
  final hitbox_fruit = CustomHitBox(
    offsetX: 10,
    offsetY: 10,
    height: 12,
    width: 12,
  );
  final hitbox_kt = CustomHitBox(
    offsetX: 0,
    offsetY: 0,
    height: 32,
    width: 32,
  );

  @override
  FutureOr<void> onLoad() {
    int frame = 1;
    if (fruit != 'kuayteaw') {
      frame = 17;
      add(RectangleHitbox(
        position: Vector2(hitbox_fruit.offsetX, hitbox_fruit.offsetY),
        size: Vector2(hitbox_fruit.width, hitbox_fruit.height),
        collisionType: CollisionType.passive,
      ));
    } else {
      add(RectangleHitbox(
        position: Vector2(hitbox_kt.offsetX, hitbox_kt.offsetY),
        size: Vector2(hitbox_kt.width, hitbox_kt.height),
        collisionType: CollisionType.passive,
      ));
    }

    //debugMode = true;
    priority = 2;

    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache('Items/Fruits/$fruit.png'),
        SpriteAnimationData.sequenced(
            amount: frame, stepTime: stepTime, textureSize: Vector2.all(32)));

    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      collidedWithPlayer();
      if (fruit == 'kuayteaw') other.gotNoodle();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void collidedWithPlayer() async {
    if (!collected) {
      collected = true;
      animation = SpriteAnimation.fromFrameData(
        game.images.fromCache('Items/Fruits/Collected.png'),
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: stepTime,
          textureSize: Vector2.all(32),
          loop: false,
        ),
      );
    }

    await animationTicker?.completed;
    removeFromParent();
  }
}
