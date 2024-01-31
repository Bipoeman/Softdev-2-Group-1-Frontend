// ignore_for_file: use_super_parameters

import 'package:flame/components.dart';

class CollisionBlock extends PositionComponent {
  bool isPlatform;
  CollisionBlock({
    position,
    size,
    this.isPlatform = false,
  }) : super(position: position, size: size) {
    //debugMode = true;
  }
}
