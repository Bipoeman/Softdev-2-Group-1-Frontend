import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:ruam_mitt/Dinodengzz/Component/custom_hitbox.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

enum State {
  idle,
  hit,
  gameover,
}

class SpacePlayer extends SpriteAnimationGroupComponent
    with HasGameRef<GameRoutes>, DragCallbacks {
  SpacePlayer({
    super.position,
  });
  Vector2 moveDirection = Vector2.zero();

  final double stepTime = 0.025;
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation hitAnimation;
  final double _speed = 200;

  CustomHitBox hitbox = CustomHitBox(
    offsetX: 12,
    offsetY: 4,
    width: 16,
    height: 28,
  );
  @override
  FutureOr<void> onLoad() {
    //debugMode = true;
    _loadAllAnimations();
    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
    ));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += moveDirection.normalized() * _speed * dt;
    if (position.x < 0) position.x = 0;
    if (position.x > game.size.x - 32) position.x = game.size.x - 32;
  }

  void setMoveDirection(Vector2 newMovedirection) {
    moveDirection = newMovedirection;
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation('Idle', 11);
    hitAnimation = _spriteAnimation('Hit', 7)..loop = false;

    animations = {
      State.idle: idleAnimation,
      State.hit: hitAnimation,
    };

    current = State.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
        gameRef.images
            .fromCache('Main Characters/Relaxaurus/$state (32x32).png'),
        SpriteAnimationData.sequenced(
            amount: amount, stepTime: stepTime, textureSize: Vector2.all(32)));
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (event.canvasDelta.r > 0) {
      setMoveDirection(Vector2(event.canvasDelta.r, 0));
    } else if (event.canvasDelta.r < 0) {
      setMoveDirection(Vector2(event.canvasDelta.r, 0));
    }
    super.onDragUpdate(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    setMoveDirection(Vector2.zero());
    super.onDragEnd(event);
  }
}
