import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ruam_mitt/Dinodengzz/Component/jump_button.dart';

class Hud extends PositionComponent with HasGameReference {
  Hud();

  final JumpButton _jumpButton = JumpButton();
  late bool hasJumped;

  final _life = TextComponent(
    text: 'x3',
    anchor: Anchor.centerLeft,
    textRenderer: TextPaint(
      style: const TextStyle(
        color: Color.fromARGB(255, 197, 59, 21),
        fontSize: 35,
      ),
    ),
  );

  @override
  Future<void> onLoad() async {
    _life.position.setValues(24, 24);
    _jumpButton.position.setValues(566, 286);
    addAll([_life, _jumpButton]);
  }

  void updateLifeCount(int count) {
    _life.text = 'x$count';
    hasJumped = _jumpButton.hasJumped;
  }
}
