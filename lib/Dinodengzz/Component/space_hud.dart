import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ruam_mitt/Dinodengzz/Component/jump_button.dart';
import 'package:ruam_mitt/Dinodengzz/Component/pause_button.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

class SpaceHud extends PositionComponent with HasGameReference<GameRoutes> {
  SpaceHud(this.camWidth, this.camHeight);

  final PauseButton _pauseButton = PauseButton();
  final double camWidth;
  final double camHeight;
  late bool moveLeft = false;
  late bool moveRight = false;

  final JumpButton _jumpButtonLeft = JumpButton();
  final JumpButton _jumpButtonRight = JumpButton();

  final _playerLife = TextComponent(
    text: '\u2665×3',
    anchor: Anchor.centerLeft,
    textRenderer: TextPaint(
      style: const TextStyle(
        color: Color.fromARGB(255, 197, 59, 21),
        fontSize: 30,
      ),
    ),
  );

  double enemyHealthPercentage = 1.0;

  @override
  Future<void> onLoad() async {
    priority = 10;
    _jumpButtonLeft.position.setValues((camWidth * 0.02), camHeight * 0.9);
    _jumpButtonLeft.angle = 150;
    _jumpButtonRight.position.setValues(camWidth, camHeight * 0.9);
    _jumpButtonRight.angle = -150;
    _jumpButtonRight.flipHorizontally();
    _pauseButton.position
        .setValues(camWidth - (camWidth * 0.12), camHeight * 0.025);
    _pauseButton.size.setValues(camWidth * 0.1, camWidth * 0.08);
    _playerLife.position.setValues((camWidth * 0.1), camHeight * 0.04);

    addAll([_playerLife, _pauseButton, _jumpButtonLeft, _jumpButtonRight]);
  }

  void updateLifeCount(int count) {
    _playerLife.text = '\u2665×$count';
    moveLeft = _jumpButtonLeft.hasmove;
    moveRight = _jumpButtonRight.hasmove;
  }

  void updateEnemyHealth(double percentage) {
    enemyHealthPercentage = percentage.clamp(0.0, 1.0);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final Paint bgPaint = Paint()..color = Colors.grey;
    final Paint healthPaint = Paint()..color = Colors.red;

    final double barWidth = game.size.x / 14;
    final double barHeight = game.size.y * 0.7 * enemyHealthPercentage;

    final double x = camWidth - (camWidth * 0.025) - barWidth;
    final double y = camHeight * 0.075;

    canvas.drawRect(Rect.fromLTWH(x, y, barWidth, game.size.y * 0.7), bgPaint);

    canvas.drawRect(
        Rect.fromLTWH(
            x, y + (game.size.y * 0.7 - barHeight), barWidth, barHeight),
        healthPaint);

    final double textX = x + barWidth / 2;
    // Adjusting textY to position the text below the health bar
    final double textY =
        y + (game.size.y * 0.7) + 10; // Adjust the 10 as needed

    canvas.save();
    canvas.translate(textX, textY);

    const textStyle =
        TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Kanit');
    final textSpan = TextSpan(
      text: '${enemyHealthPercentage * 100 ~/ 1}%',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: barHeight);
    textPainter.paint(
        canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));

    canvas.restore();
  }
}
