import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:ruam_mitt/Dinodengzz/dinodengzz.dart';

class JumpButton extends SpriteComponent
    with HasGameRef<DinoDengzz>, TapCallbacks {
  JumpButton();

  final margin = 28;
  final buttonSize = 64;

  double previousWidth = 0;
  double previousHeight = 0;

  @override
  FutureOr<void> onLoad() {
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
    game.player.hasJumped = true;
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.player.hasJumped = false;
    super.onTapUp(event);
  }
}
