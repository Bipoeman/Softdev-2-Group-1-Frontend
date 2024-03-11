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
  SpacePlayer({super.position, super.scale});
  double direction = 0;

  final double stepTime = 0.025;
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation hitAnimation;
  late final SpriteAnimation gameOverAnimation;
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
    position.x += direction * _speed * dt;
    onStop();
    if (position.x < 0) position.x = 0;
    if (position.x > game.size.x - 32) position.x = game.size.x - 32;
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation('Idle', 6);
    hitAnimation = _spriteAnimation('Hit', 5)..loop = false;
    gameOverAnimation = _spriteAnimation('Died', 6)..loop = false;

    animations = {
      State.idle: idleAnimation,
      State.hit: hitAnimation,
      State.gameover: gameOverAnimation,
    };

    current = State.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
        gameRef.images
            .fromCache('Main Characters/Rocket Relaxaurus/$state 32x32.png'),
        SpriteAnimationData.sequenced(
            amount: amount, stepTime: stepTime, textureSize: Vector2.all(32)));
  }

  void onMoveRight(bool hasMoved) {
    if (hasMoved) {
      direction = 1;
    }
  }

  void onMoveLeft(bool hasMoved) {
    if (hasMoved) {
      direction = -1;
    }
  }

  void onStop() {
    direction = 0;
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
      await animationTicker?.completed;
      animationTicker?.reset();

      if (remainingLives <= 0) {
        current = State.gameover;
        await animationTicker?.completed;
        animationTicker?.reset();
        gameOver = true;
        game.showRetryMenuvertical();
      }
      await Future.delayed(const Duration(milliseconds: 1500));
      isImmune = false;
      await animationTicker?.completed;
      animationTicker?.reset();
      current = State.idle;
    }
  }
}
