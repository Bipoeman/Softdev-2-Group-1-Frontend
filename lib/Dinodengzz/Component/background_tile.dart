// ignore_for_file: use_super_parameters

import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class BackgroundTile extends ParallaxComponent with HasGameRef {
  final String color;
  BackgroundTile({
    this.color = 'Blue',
    position,
  }) : super(
          position: position,
        );

  final double scrollSpeed = 40;

  @override
  FutureOr<void> onLoad() async {
    priority = -20;
    size = Vector2.all(64);
    parallax = await gameRef.loadParallax(
      [ParallaxImageData('Background/$color.png')],
      baseVelocity: Vector2(0, -scrollSpeed),
      repeat: ImageRepeat.repeat,
      fill: LayerFill.none,
    );
    return super.onLoad();
  }
}
