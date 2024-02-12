import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

class JumpButton extends SpriteComponent
    with HasGameRef<GameRoutes>, TapCallbacks {
  JumpButton();

  final margin = 28;
  final buttonSize = 64;

  double previousWidth = 0;
  double previousHeight = 0;
  bool hasJumped = false;
  @override
  FutureOr<void> onLoad() {
    priority = 10;
    sprite = Sprite(game.images.fromCache('HUD/JumpButton.png'));
    updatePosition();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (game.size.x != previousWidth || game.size.y != previousHeight) {
      updatePosition();
      previousWidth = game.size.x;
      previousHeight = game.size.y;
    }
  }

  void updatePosition() {
    position = Vector2(
      game.size.x - margin - buttonSize,
      game.size.y - margin - buttonSize,
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    hasJumped = true;
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    hasJumped = false;
    super.onTapUp(event);
  }
}
