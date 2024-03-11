import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class BackgroundTile extends ParallaxComponent with HasGameRef {
  BackgroundTile(
    position,
  ) : super(
          position: position,
        );

  final double scrollSpeed = 40;

  @override
  FutureOr<void> onLoad() async {
    priority = -20;
    size = Vector2(128, 64);
    parallax = await gameRef.loadParallax(
      [ParallaxImageData('Background/Space(64 x 64).png')],
      baseVelocity: Vector2(0, -scrollSpeed),
      repeat: ImageRepeat.repeat,
      fill: LayerFill.none,
    );
    return super.onLoad();
  }
}
