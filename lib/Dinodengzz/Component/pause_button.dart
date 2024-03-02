import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

class PauseButton extends SpriteComponent
    with HasGameRef<GameRoutes>, TapCallbacks {
  PauseButton();

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('HUD/Setting.png'));
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    gameRef.pauseGame();
    super.onTapDown(event);
  }
}
