import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ruam_mitt/Dinodengzz/Component/jump_button.dart';

class Hud extends PositionComponent with HasGameReference {
  Hud(this.camHeight);

  final JumpButton _jumpButton = JumpButton();
  final double camHeight;
  late bool hasJumped = false;
  late double horizontalMovement = 0;
  late JoystickComponent joystick = JoystickComponent(
    knob: CircleComponent(
        radius: 16, paint: Paint()..color = Color.fromARGB(205, 246, 241, 241)),
    background: CircleComponent(
        radius: 32, paint: Paint()..color = Color.fromARGB(123, 43, 41, 41)),
    anchor: Anchor.topCenter,
  );

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
    _jumpButton.position.setValues(576, camHeight - 86);
    joystick.position.setValues(48, camHeight - 86);
    addAll([_life, _jumpButton, joystick]);
  }

  void updateLifeCount(int count) {
    _life.text = 'x$count';
    hasJumped = _jumpButton.hasJumped;
    updateJoystick();
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        horizontalMovement = 1;
        break;
      default:
        horizontalMovement = 0;
        break;
    }
  }
}
