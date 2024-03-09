import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ruam_mitt/Dinodengzz/Component/pause_button.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

class SpaceHud extends PositionComponent with HasGameReference<GameRoutes> {
  SpaceHud(this.camWidth, this.camHeight);

  final PauseButton _pauseButton = PauseButton();
  final double camWidth;
  final double camHeight;

  final _life = TextComponent(
    text: '\u2665×3',
    anchor: Anchor.centerLeft,
    textRenderer: TextPaint(
      style: const TextStyle(
        color: Color.fromARGB(255, 197, 59, 21),
        fontSize: 30,
      ),
    ),
  );

  @override
  Future<void> onLoad() async {
    _pauseButton.position
        .setValues(camWidth - (camWidth * 0.1), camHeight * 0.025);
    _life.position.setValues((camWidth * 0.1), camHeight * 0.025);

    addAll([_life, _pauseButton]);
  }

  void updateLifeCount(int count) {
    _life.text = '\u2665×$count';
  }
}
