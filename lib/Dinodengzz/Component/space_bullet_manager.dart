import 'package:flame/components.dart';
import 'package:ruam_mitt/Dinodengzz/Component/space_bullet.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

class BulletManager extends Component with HasGameRef<GameRoutes> {
  late final Vector2 position;
  late Timer bullet;
  BulletManager(this.position) : super() {
    bullet = Timer(1.5, onTick: _shootNormal, repeat: true);
  }

  void _shootNormal() {
    Bullet normalBullet = Bullet(position: position);
    add(normalBullet);
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
  }
}
