import 'dart:async';

import 'package:flame/components.dart';
import 'package:ruam_mitt/Dinodengzz/Component/checkpoint.dart';
import 'package:ruam_mitt/Dinodengzz/Component/collision_block.dart';
import 'package:ruam_mitt/Dinodengzz/Component/fruit.dart';
import 'package:ruam_mitt/Dinodengzz/Component/patrick.dart';
import 'package:ruam_mitt/Dinodengzz/Component/player.dart';
import 'package:ruam_mitt/Dinodengzz/Component/saw.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

class Level extends World with HasGameRef<GameRoutes> {
  final String levelName;
  final Player player;
  Level({required this.levelName, required this.player});
  late TiledComponent level;
  late int fruitAmount = 0;
  List<CollisionBlock> collisionBlocks = [];

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(16));
    add(level);
    _spawningObject();
    player.fruitHave = fruitAmount;
    _addCollision();

    player.collisionBlocks = collisionBlocks;

    return super.onLoad();
  }

  void _spawningObject() {
    final spawnPointLayer = level.tileMap.getLayer<ObjectGroup>('Spawn');

    if (spawnPointLayer != null) {
      for (final spawnPoint in spawnPointLayer.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            player.scale.x = 1;
            add(player);
            break;
          case 'Fruit':
            final fruit = Fruit(
              fruit: spawnPoint.name,
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(spawnPoint.width, spawnPoint.height),
            );
            add(fruit);
            if (fruit.fruit != 'kuayteaw') ++fruitAmount;
            break;
          case 'Saw':
            final isVertical = spawnPoint.properties.getValue('isVertical');
            final offNeg = spawnPoint.properties.getValue('offNeg');
            final offPos = spawnPoint.properties.getValue('offPos');
            final saw = Saw(
              isVertical: isVertical,
              offNeg: offNeg,
              offPos: offPos,
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(spawnPoint.width, spawnPoint.height),
            );
            add(saw);
            break;
          case 'Checkpoint':
            final checkpoint = Checkpoint(
                position: Vector2(spawnPoint.x, spawnPoint.y),
                size: Vector2(spawnPoint.width, spawnPoint.height));
            add(checkpoint);
            break;
          case 'Star':
            final offNeg = spawnPoint.properties.getValue('offNeg');
            final offPos = spawnPoint.properties.getValue('offPos');
            final patrix = Patrick(
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(spawnPoint.width, spawnPoint.height),
              offNeg: offNeg,
              offPos: offPos,
              player: player,
            );
            patrix.collisionBlocks = collisionBlocks;
            add(patrix);
            break;
          default:
        }
      }
    }
  }

  void _addCollision() {
    final collisionlayer = level.tileMap.getLayer<ObjectGroup>('Collision');

    if (collisionlayer != null) {
      for (final collision in collisionlayer.objects) {
        switch (collision.class_) {
          case 'Platform':
            final platform = CollisionBlock(
                position: Vector2(collision.x, collision.y),
                size: Vector2(collision.width, collision.height),
                isPlatform: true);
            collisionBlocks.add(platform);
            add(platform);
            break;
          default:
            final block = CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
            );
            collisionBlocks.add(block);
            add(block);
        }
      }
    }
  }
}
