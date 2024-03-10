import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ruam_mitt/Dinodengzz/Component/custom_hitbox.dart';
import 'package:ruam_mitt/Dinodengzz/Component/space_bullet.dart';
import 'package:ruam_mitt/Dinodengzz/Component/space_kuayteaw.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

enum State { run }

class Enemy extends SpriteAnimationGroupComponent
    with HasGameRef<GameRoutes>, CollisionCallbacks {
  Enemy({
    super.position,
  });
  late final SpriteAnimation _runAnimation;
  CustomHitBox hitbox = CustomHitBox(
    offsetX: 0,
    offsetY: 0,
    width: 32,
    height: 32,
  );
  final double _speed = 250;

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(
      position: Vector2(4, 6),
      size: Vector2(24, 22),
      isSolid: true,
    ));
    _loadAllAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, 1) * _speed * dt;
    if (position.y > game.size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Bullet || other is Kuayteaw) {
      removeFromParent();
    }
  }

  void _loadAllAnimations() {
    _runAnimation = _spriteAnimation('Run', 12);

    animations = {
      State.run: _runAnimation,
    };
    current = State.run;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Opponent (Patrick)/Run (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: 12,
        stepTime: 0.069,
        textureSize: Vector2.all(32),
      ),
    );
  }
}
