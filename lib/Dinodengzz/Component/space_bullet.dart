import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ruam_mitt/Dinodengzz/Component/space_enemy.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

enum State { shoot }

class Bullet extends SpriteAnimationGroupComponent
    with HasGameRef<GameRoutes>, CollisionCallbacks {
  Bullet({
    super.position,
  });

  final double _speed = 450;
  late final SpriteAnimation shootAnimation;

  Vector2 direction = Vector2(0, -1);

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  void _loadAllAnimations() {
    shootAnimation = _spriteAnimation('Hit', 4);

    animations = {
      State.shoot: shootAnimation,
    };

    current = State.shoot;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache(
            'assets/images/Main Characters/Player_charged_donut_shot (16 x 16).png'),
        SpriteAnimationData.sequenced(
            amount: amount, stepTime: 0.05, textureSize: Vector2.all(16)));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      removeFromParent();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += direction * _speed * dt;

    if (position.y < 0) {
      removeFromParent();
    }
  }
}
