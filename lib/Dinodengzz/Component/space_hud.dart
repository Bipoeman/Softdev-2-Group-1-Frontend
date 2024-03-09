import 'dart:async';
import 'package:flame/components.dart';
import 'package:ruam_mitt/Dinodengzz/Component/pause_button.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

class SpaceHud extends PositionComponent with HasGameReference<GameRoutes> {
  SpaceHud(this.camWidth, this.camHeight);

  final PauseButton _pauseButton = PauseButton();
  final double camWidth;
  final double camHeight;

  @override
  Future<void> onLoad() async {
    _pauseButton.position
        .setValues(camWidth - (camWidth * 0.1), camHeight * 0.025);

    add(_pauseButton);
  }
}
