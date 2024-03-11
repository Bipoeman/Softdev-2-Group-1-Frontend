import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

class JumpButton extends SpriteComponent
    with HasGameRef<GameRoutes>, TapCallbacks {
  JumpButton();

  bool hasJumped = false;
  bool hasmove = false;

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('HUD/JumpButton.png'));
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    hasJumped = true;
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    hasJumped = false;
    hasmove = false;
    super.onTapUp(event);
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    hasmove = true;
    super.onLongTapDown(event);
  }
}
