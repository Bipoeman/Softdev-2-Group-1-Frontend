import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:ruam_mitt/Dinodengzz/Component/custom_hitbox.dart';
import 'package:ruam_mitt/Dinodengzz/Component/space_enemy.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

enum State {
  idle,
  hit,
  gameover,
}

class SpacePlayer extends SpriteAnimationGroupComponent
    with HasGameRef<GameRoutes>, DragCallbacks, CollisionCallbacks {
  SpacePlayer({
    super.position,
  });
  Vector2 moveDirection = Vector2.zero();

  final double stepTime = 0.025;
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation hitAnimation;
  final double _speed = 200;
  int remainingLives = 3;
  bool isImmune = false;
  Timer? immunityTimer;
  bool gameOver = false;

  CustomHitBox hitbox = CustomHitBox(
    offsetX: 0,
    offsetY: 0,
    width: 32,
    height: 32,
  );
  @override
  FutureOr<void> onLoad() {
    //debugMode = true;
    _loadAllAnimations();
    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
      isSolid: true,
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

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (!isImmune && other is Enemy) _respawn();
    super.onCollisionStart(intersectionPoints, other);
  }

  void _respawn() async {
    if (!gameOver) {
      FlameAudio.play(game.hitSfx, volume: game.masterVolume * game.sfxVolume);
      remainingLives--;
      current = State.hit;
      isImmune = true;
      if (remainingLives <= 0) {
        gameOver = true;
        game.showRetryMenuvertical();
      }
      await Future.delayed(const Duration(milliseconds: 1500));
      isImmune = false;
      await animationTicker?.completed;
      animationTicker?.reset();
    }
  }
}
