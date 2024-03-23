import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ruam_mitt/Dinodengzz/Component/jump_button.dart';
import 'package:ruam_mitt/Dinodengzz/Component/pause_button.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';
import 'package:flutter/services.dart';

class Hud extends PositionComponent with HasGameReference<GameRoutes> {
  Hud(this.camWidth, this.camHeight);

  final JumpButton _jumpButton = JumpButton();
  final PauseButton _pauseButton = PauseButton();
  final double camWidth;
  final double camHeight;
  final keyboardInstance = HardwareKeyboard.instance;
  late bool hasJumped = false;
  late double horizontalMovement = 0;
  late JoystickComponent joystick = JoystickComponent(
    knob: CircleComponent(
        radius: 20, paint: Paint()..color = const Color.fromARGB(205, 246, 241, 241)),
    background:
        CircleComponent(radius: 40, paint: Paint()..color = const Color.fromARGB(123, 43, 41, 41)),
    anchor: Anchor.topCenter,
  );

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
    _life.position.setValues(24, 24);
    _jumpButton.position.setValues(camWidth - 84, camHeight - 104);
    _pauseButton.position.setValues(camWidth - 72, 12);
    joystick.position.setValues(72, camHeight - 104);
    addAll([_life, _jumpButton, _pauseButton, joystick]);
  }

  void updateLifeCount(int count) {
    _life.text = '\u2665×$count';
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

    if (keyboardInstance.logicalKeysPressed.isNotEmpty) {
      if (keyboardInstance.isLogicalKeyPressed(
        LogicalKeyboardKey.space,
      )) {
        hasJumped = true;
      } else {
        hasJumped = false;
      }

      if (keyboardInstance.isLogicalKeyPressed(
        LogicalKeyboardKey.keyD,
      )) {
        horizontalMovement = 1;
      } else if (keyboardInstance.isLogicalKeyPressed(
        LogicalKeyboardKey.keyA,
      )) {
        horizontalMovement = -1;
      } else {
        horizontalMovement = 0;
      }
    }
  }
}
