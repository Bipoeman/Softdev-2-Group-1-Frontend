import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:ruam_mitt/Dinodengzz/Component/space_bullet.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

class BulletManager extends Component with HasGameRef<GameRoutes> {
  late Timer bullet;
  late Timer counter;
  late Vector2 position;
  late int count = 0;

  late bool gameOver = false;
  BulletManager(this.position, this.gameOver) : super() {
    counter = Timer(1, onTick: () => count++, repeat: true);
    bullet = Timer(1.5, onTick: _shootNormal, repeat: true);
  }

  void _shootNormal() {
    Bullet normalBullet = Bullet();
    normalBullet.gameOver = gameOver;
    normalBullet.position = position;
    add(normalBullet);
    if (!gameOver) {
      FlameAudio.play(game.shootSfx,
          volume: game.masterVolume * game.sfxVolume);
    } else {
      bullet.stop();
    }
  }

  @override
  void onMount() {
    super.onMount();
    bullet.start();
  }

  @override
  void onRemove() {
    super.onRemove();
    bullet.stop();
  }

  @override
  void update(double dt) {
    super.update(dt);
    bullet.update(dt);
    if (count >= 222) bullet.stop();
  }
}
