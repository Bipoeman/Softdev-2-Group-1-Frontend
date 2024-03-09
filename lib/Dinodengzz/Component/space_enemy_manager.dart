import 'dart:math';

import 'package:flame/components.dart';
import 'package:ruam_mitt/Dinodengzz/Component/space_enemy.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

class EnemyManager extends Component with HasGameRef<GameRoutes> {
  late Timer enemy;
  Random random = Random();
  EnemyManager() : super() {
    enemy = Timer(1, onTick: _spawnEnemy, repeat: true);
  }

  void _spawnEnemy() {
    Vector2 position =
        Vector2((random.nextDouble() * game.size.x), game.size.y * 0.1);

    Enemy enemies = Enemy();
    enemies.position = position;
    add(enemies);
  }

  @override
  void onMount() {
    super.onMount();
    enemy.start();
  }

  @override
  void onRemove() {
    super.onRemove();
    enemy.stop();
  }

  @override
  void update(double dt) {
    super.update(dt);
    enemy.update(dt);
  }
}
