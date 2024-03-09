import 'dart:math';

import 'package:flame/components.dart';
import 'package:ruam_mitt/Dinodengzz/Component/space_enemy.dart';
import 'package:ruam_mitt/Dinodengzz/Component/space_kuayteaw.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

class EnemyManager extends Component with HasGameRef<GameRoutes> {
  late int count = 0;
  late Timer counter, damage;
  late Timer enemy_1, enemy_2, enemy_3, enemy_4;

  Random random = Random();
  EnemyManager() : super() {
    damage = Timer(1, onTick: _bossHit, repeat: true);
    counter = Timer(1, onTick: () => count++, repeat: true);
    enemy_1 = Timer(1, onTick: _spawnEnemyPhase1, repeat: true);
    enemy_2 = Timer(0.75, onTick: () {
      _spawnEnemyPhase2();
    }, repeat: true);
    enemy_3 = Timer(0.25, onTick: () {
      _spawnEnemyPhase3();
    }, repeat: true);
    enemy_4 = Timer(0.25, onTick: () {
      _spawnEnemyPhase4();
    }, repeat: true);
  }

  void _spawnEnemyPhase1() {
    Vector2 position =
        Vector2((random.nextDouble() * game.size.x), game.size.y * 0.1);

    Enemy enemies = Enemy();
    enemies.position = position;
    add(enemies);
  }

  void _spawnEnemyPhase2() {
    Vector2 position_1 =
        Vector2((random.nextDouble() * game.size.x), game.size.y * 0.1);
    Vector2 position_2 =
        Vector2((random.nextDouble() * game.size.x), game.size.y * 0.1);

    Enemy enemies1 = Enemy();
    Enemy enemies2 = Enemy();
    enemies1.position = position_1;
    enemies2.position = position_2;
    addAll([enemies1, enemies2]);
  }

  void _spawnEnemyPhase3() {
    Vector2 position_1 =
        Vector2((random.nextDouble() * game.size.x), game.size.y * 0.1);
    Vector2 position_2 =
        Vector2((random.nextDouble() * game.size.x), game.size.y * 0.1);

    Enemy enemies1 = Enemy();
    Enemy enemies2 = Enemy();
    enemies1.position = position_1;
    enemies2.position = position_2;
    addAll([enemies1, enemies2]);
  }

  void _spawnEnemyPhase4() {
    Vector2 position_1 =
        Vector2((random.nextDouble() * game.size.x), game.size.y * 0.1);
    Vector2 position_2 =
        Vector2((random.nextDouble() * game.size.x), game.size.y * 0.1);
    Vector2 position_3 =
        Vector2((random.nextDouble() * game.size.x), game.size.y * 0.1);

    Enemy enemies1 = Enemy();
    Enemy enemies2 = Enemy();
    Enemy enemies3 = Enemy();
    enemies1.position = position_1;
    enemies2.position = position_2;
    enemies3.position = position_3;
    addAll([enemies1, enemies2, enemies3]);
  }

  void _bossHit() {
    Kuayteaw kuayteaw = Kuayteaw();
    add(kuayteaw);
  }

  @override
  void onMount() {
    super.onMount();
    counter.start();
  }

  @override
  void onRemove() {
    super.onRemove();
    counter.stop();
  }

  @override
  void update(double dt) {
    counter.update(dt);
    print(count);
    if (count >= 11) {
      enemy_1.update(dt);
    }
    if (count == 5) {
      damage.update(dt);
    }
    if (count >= 15) {
      enemy_1.stop();
      enemy_2.update(dt);
    }
    if (count == 20) {
      damage.update(dt);
    }
    if (count >= 90) {
      enemy_2.stop();
      enemy_3.update(dt);
    }
    if (count >= 130) {
      enemy_3.stop();
      enemy_4.update(dt);
    }
    if (count >= 220) {
      enemy_4.stop();
      counter.stop();
    }
    super.update(dt);
  }
}
