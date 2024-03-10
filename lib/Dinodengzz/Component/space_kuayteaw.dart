import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ruam_mitt/Dinodengzz/Component/space_boss.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

enum State { shoot }

class Kuayteaw extends SpriteAnimationGroupComponent
    with HasGameRef<GameRoutes>, CollisionCallbacks {
  Kuayteaw();

  final double _speed = 300;
  late final SpriteAnimation shootAnimation;

  Vector2 direction = Vector2(0, -1);

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(
      position: Vector2(0, 0),
      size: Vector2(game.size.x * 0.69, game.size.y * 0.069),
      isSolid: true,
    ));
    _loadAllAnimations();
    position = Vector2(game.size.x / 2 - 32, game.size.y * 0.8);
    return super.onLoad();
  }

  void _loadAllAnimations() {
    shootAnimation = _spriteAnimation(1);

    animations = {
      State.shoot: shootAnimation,
    };

    current = State.shoot;
  }

  SpriteAnimation _spriteAnimation(int amount) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache('Background/Kuayteaw.png'),
        SpriteAnimationData.sequenced(
            amount: amount, stepTime: 0.05, textureSize: Vector2.all(64)));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Boss) removeFromParent();
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
