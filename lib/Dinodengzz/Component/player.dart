// ignore_for_file: use_super_parameters
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:ruam_mitt/Dinodengzz/Component/checkpoint.dart';
import 'package:ruam_mitt/Dinodengzz/Component/collision_block.dart';
import 'package:ruam_mitt/Dinodengzz/Component/custom_hitbox.dart';
import 'package:ruam_mitt/Dinodengzz/Component/patrick.dart';
import 'package:ruam_mitt/Dinodengzz/Component/saw.dart';
import 'package:ruam_mitt/Dinodengzz/Component/utils.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

enum PlayerState {
  idle,
  running,
  jumping,
  falling,
  hit,
  appearing,
  dissappering,
  gameover,
}

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<GameRoutes>, KeyboardHandler, CollisionCallbacks {
  String character;
  BuildContext? context;
  Player({
    this.character = 'Relaxaurus',
    position,
  }) : super(position: position);

  final double stepTime = 0.025;
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  late final SpriteAnimation jumpingAnimation;
  late final SpriteAnimation fallingAnimation;
  late final SpriteAnimation hitAnimation;
  late final SpriteAnimation appearingAnimation;
  late final SpriteAnimation dissappearingAnimation;

  final double _gravity = 9.82;
  final double _jumpForce = 300;
  final double _terminalVelocity = 300;
  Vector2 startingPos = Vector2.zero();
  double horizontalMovement = 0;
  double movespeed = 100;
  Vector2 velocity = Vector2.zero();
  bool isPause = false;
  bool isOnGround = false;
  bool hasJumped = false;
  bool gotHit = false;
  bool isGameOver = false;
  bool reachedCheckpoint = false;
  bool noodleCollected = false;
  int fruitHave = 0;
  int fruitCount = 0;
  int remainingLives = 3;

  AudioPlayer? gameOverPlayer;

  List<CollisionBlock> collisionBlocks = [];
  CustomHitBox hitbox = CustomHitBox(
    offsetX: 12,
    offsetY: 4,
    width: 16,
    height: 28,
  );
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;

  @override
  FutureOr<void> onLoad() async {
    _loadAllAnimation();
    //debugMode = true;
    priority = 10;
    startingPos = Vector2(position.x, position.y);
    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
      isSolid: true,
    ));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (isPause) {
      gameRef.pauseGame();
    }
    accumulatedTime += dt;
    while (accumulatedTime >= fixedDeltaTime) {
      if (!gotHit && !reachedCheckpoint) {
        _updatePlayerState();
        _updatePlayerMovement(fixedDeltaTime);
        _checkHorizontalCollisions();
        _applyGravity(fixedDeltaTime);
        _checkVerticalCollisions();
      }

      accumulatedTime -= fixedDeltaTime;
    }
    super.update(dt);
  }

  @override
  bool onKeyEvent(event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalMovement = 0;
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    isPause = keysPressed.contains(LogicalKeyboardKey.escape);
    horizontalMovement += isLeftKeyPressed ? -1 : 0;
    horizontalMovement += isRightKeyPressed ? 1 : 0;

    hasJumped = keysPressed.contains(LogicalKeyboardKey.space) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp) ||
        keysPressed.contains(LogicalKeyboardKey.keyW);

    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (!reachedCheckpoint) {
      if (other is Patrick) other.collidedWithPlayer();
      if (other is Saw) _respawn();
      if (other is Checkpoint && noodleCollected) _reachCheckpoint();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void _loadAllAnimation() {
    idleAnimation = _spriteAnimation('Idle', 11);
    runningAnimation = _spriteAnimation('Run', 12);
    jumpingAnimation = _spriteAnimation('Jump', 1);
    fallingAnimation = _spriteAnimation('Fall', 2);
    hitAnimation = _spriteAnimation('Hit', 7)..loop = false;
    appearingAnimation = _speacialspriteAnimation('Appearing', 7);
    dissappearingAnimation = _speacialspriteAnimation('Desappearing', 7);

    //list of all animation
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
      PlayerState.jumping: jumpingAnimation,
      PlayerState.falling: fallingAnimation,
      PlayerState.hit: hitAnimation,
      PlayerState.appearing: appearingAnimation,
      PlayerState.dissappering: dissappearingAnimation,
    };

    //Set current animation
    current = PlayerState.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
        gameRef.images
            .fromCache('Main Characters/$character/$state (32x32).png'),
        SpriteAnimationData.sequenced(
            amount: amount, stepTime: stepTime, textureSize: Vector2.all(32)));
  }

  SpriteAnimation _speacialspriteAnimation(String state, int amount) {
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
  void onRemove() {
    gameOverPlayer?.dispose();
    super.onRemove();
  }

  void _updatePlayerMovement(double dt) {
    if (hasJumped && isOnGround) _playerJump(dt);

    if (velocity.y > _gravity) isOnGround = false;
    velocity.x = horizontalMovement * movespeed;
    position.x += velocity.x * dt;
  }

  void _playerJump(double dt) {
    FlameAudio.playLongAudio(game.jumpSfx,
        volume: game.masterVolume * game.sfxVolume);
    velocity.y = -_jumpForce;
    position.y += velocity.y * dt;
    isOnGround = false;
    hasJumped = false;
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;

    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    //checking running
    if (velocity.x > 0 || velocity.x < 0) playerState = PlayerState.running;

    //checking falling
    if (velocity.y > 0) playerState = PlayerState.falling;

    //checking jumping
    if (velocity.y < 0) playerState = PlayerState.jumping;

    current = playerState;
  }

  void _checkHorizontalCollisions() {
    for (final block in collisionBlocks) {
      if (!block.isPlatform) {
        if (checkCollision(this, block)) {
          if (velocity.x > 0) {
            velocity.x = 0;
            position.x = block.x - hitbox.offsetX - hitbox.width;
            break;
          }
          if (velocity.x < 0) {
            velocity.x = 0;
            position.x = block.x + block.width + hitbox.width + hitbox.offsetX;
            break;
          }
        }
      }
    }
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(-_jumpForce, _terminalVelocity);
    position.y += velocity.y * dt;
  }

  void _checkVerticalCollisions() {
    for (final block in collisionBlocks) {
      if (block.isPlatform) {
        if (checkCollision(this, block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - hitbox.height - hitbox.offsetY;
            isOnGround = true;
            break;
          }
        }
      } else {
        if (checkCollision(this, block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - hitbox.height - hitbox.offsetY;
            isOnGround = true;
            break;
          }
          if (velocity.y < 0) {
            velocity.y = 0;
            position.y = block.y + hitbox.height - hitbox.offsetY;
          }
        }
      }
    }
  }

  void _respawn() async {
    const moveDelay = Duration(milliseconds: 350);
    FlameAudio.play(game.hitSfx, volume: game.masterVolume * game.sfxVolume);
    gotHit = true;
    current = PlayerState.hit;

    await animationTicker?.completed;
    animationTicker?.reset();

    remainingLives--;

    if (remainingLives <= 0) {
      isGameOver = true;
      gameRef.showRetryMenu();
    }
    scale.x = 1;
    position = startingPos - Vector2.all(32);
    current = PlayerState.appearing;

    await animationTicker?.completed;
    animationTicker?.reset();

    velocity = Vector2.zero();
    position = startingPos;
    _updatePlayerState();
    Future.delayed(moveDelay, () {
      gotHit = false;
      if (!isGameOver) {
        current = PlayerState.idle;
      }
    });
  }

  void _reachCheckpoint() async {
    FlameAudio.play(game.clearSFX, volume: game.masterVolume * game.sfxVolume);
    reachedCheckpoint = true;
    if (scale.x > 0) {
      position = position - Vector2.all(32);
    } else if (scale.x < 0) {
      position = position - Vector2(-32, 32);
    }
    current = PlayerState.dissappering;

    await animationTicker?.completed;
    animationTicker?.reset();

    reachedCheckpoint = false;
    noodleCollected = false;
    position = Vector2.all(-640);
  }

  void collidedwithEnemy() {
    _respawn();
  }

  void gotNoodle() {
    FlameAudio.play(game.ktSFX, volume: game.masterVolume * game.sfxVolume);
    noodleCollected = true;
  }
}
