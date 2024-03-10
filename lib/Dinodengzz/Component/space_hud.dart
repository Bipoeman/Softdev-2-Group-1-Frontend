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

  double enemyHealthPercentage = 1.0; // Full health initially

  @override
  Future<void> onLoad() async {
    priority = 10;
    _pauseButton.position
        .setValues(camWidth - (camWidth * 0.1), camHeight * 0.025);
    _playerLife.position.setValues((camWidth * 0.1), camHeight * 0.025);

    addAll([_playerLife, _pauseButton]);
  }

  void updateLifeCount(int count) {
    _playerLife.text = '\u2665×$count';
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

    // Draw background bar
    canvas.drawRect(Rect.fromLTWH(x, y, barWidth, game.size.y * 0.7), bgPaint);

    // Draw health bar with decreasing height from top to bottom
    canvas.drawRect(
        Rect.fromLTWH(
            x, y + (game.size.y * 0.7 - barHeight), barWidth, barHeight),
        healthPaint);

    // Calculate text position
    final double textX = x + barWidth / 2;
    final double textY = y + (game.size.y * 0.7 - barHeight) + barHeight / 2;

    // Rotate canvas by 90 degrees
    canvas.save();
    canvas.translate(textX, textY);
    canvas.rotate(-90 * 3.14 / 180);

    // Draw text
    final textStyle = TextStyle(color: Colors.white, fontSize: 14);
    final textSpan = TextSpan(
      text: '${enemyHealthPercentage * 100 ~/ 1}%', // Display health percentage
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
        minWidth: 0, maxWidth: barHeight); // Width and height swapped
    textPainter.paint(
        canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));

    // Restore canvas to its original state
    canvas.restore();
  }
}