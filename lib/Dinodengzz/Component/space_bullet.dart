import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:ruam_mitt/Dinodengzz/Component/space_boss.dart';
import 'package:ruam_mitt/Dinodengzz/Component/space_enemy.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

enum State { shoot }

class Bullet extends SpriteAnimationGroupComponent
    with HasGameRef<GameRoutes>, CollisionCallbacks {
  Bullet({
    super.position,
  });

  final double _speed = 250;
  late final SpriteAnimation shootAnimation;
  bool gameOver = false;

  Vector2 direction = Vector2(0, -1);

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(
      position: Vector2(0, 0),
      size: Vector2(16, 16),
      isSolid: true,
    ));
    _loadAllAnimations();
    return super.onLoad();
  }

  void _loadAllAnimations() {
    shootAnimation = _spriteAnimation(4);

    animations = {
      State.shoot: shootAnimation,
    };

    current = State.shoot;
  }

  SpriteAnimation _spriteAnimation(int amount) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache(
            'Main Characters/Player_charged_donut_shot (16 x 16).png'),
        SpriteAnimationData.sequenced(
            amount: amount, stepTime: 0.05, textureSize: Vector2.all(16)));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if ((other is Enemy || other is Boss) && !gameOver) {
      FlameAudio.play(game.hitStarSfx,
          volume: game.masterVolume * game.sfxVolume);
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
