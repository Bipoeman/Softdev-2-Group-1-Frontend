import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:get/get.dart';
import 'package:ruam_mitt/Dinodengzz/Screens/gameover.dart';
import 'package:ruam_mitt/Dinodengzz/Screens/levelcomplete.dart';
import 'package:ruam_mitt/Dinodengzz/Screens/levelselect.dart';
import 'package:ruam_mitt/Dinodengzz/Screens/pause.dart';
import 'package:ruam_mitt/Dinodengzz/Screens/setting.dart';
import 'package:ruam_mitt/Dinodengzz/Screens/start.dart';
import 'package:ruam_mitt/Dinodengzz/dinodengzz.dart';

class GameRoutes extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks, HasCollisionDetection {
  List<String> levelNames = ['Level-01', 'Level-02', 'Level-03'];

  late final _routes = <String, Route>{
    StartScreen.id: OverlayRoute(
      (context, game) => StartScreen(
          onLevelSelectionPressed: () => _routeById(LevelSelectionScreen.id),
          onExitPressed: () => Get.toNamed('/login'),
          onSettingPressed: () => _routeById(Settings.id)),
    ),
    Settings.id: OverlayRoute(
      (context, game) => Settings(
        onBackPressed: _popRoute,
      ),
    ),
    LevelSelectionScreen.id:
        OverlayRoute((context, game) => LevelSelectionScreen(
              levelNames: levelNames,
              onLevelSelected: _startLevel,
              onBackPressed: _popRoute,
            )),
    PauseMenu.id: OverlayRoute(
      (context, game) => PauseMenu(
        onResumePressed: _resumeGame,
        onSettingPressed: () => _routeById(Settings.id),
        onExitPressed: _exitToMainMenu,
      ),
    ),
    GameOverScreen.id: OverlayRoute(
      (context, game) => GameOverScreen(
        onRetryPressed: _restartLevel,
        onMainMenuPressed: () => _exitToMainMenu(),
      ),
    ),
  };

  late final _routeFactories = <String, Route Function(String)>{
    LevelComplete.id: (argument) => OverlayRoute(
          (context, game) => LevelComplete(
            nStars: int.parse(argument),
            onNextPressed: _startNextLevel,
            onRetryPressed: _restartLevel,
            onExitPressed: _exitToMainMenu,
          ),
        ),
  };

  late final _router = RouterComponent(
    initialRoute: StartScreen.id,
    routes: _routes,
    routeFactories: _routeFactories,
  );

  @override
  Future<void> onLoad() async {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
    await images.loadAllImages();
    await add(_router);
  }

  void _routeById(String id) {
    _router.pushNamed(id);
  }

  void _popRoute() {
    _router.pop();
  }

  void _startLevel(int levelIndex) {
    _router.pop();
    _router.pushReplacement(
      Route(
        () => DinoDengzz(
          levelIndex,
          onPausePressed: pauseGame,
          onLevelCompleted: showLevelCompleteMenu,
          onGameOver: showRetryMenu,
          key: ComponentKey.named(DinoDengzz.id),
        ),
      ),
      name: DinoDengzz.id,
    );
  }

  void _restartLevel() {
    final gameplay = findByKeyName<DinoDengzz>(DinoDengzz.id);

    if (gameplay != null) {
      _startLevel(gameplay.currentLevel);
      resumeEngine();
    }
  }

  void _startNextLevel() {
    final gameplay = findByKeyName<DinoDengzz>(DinoDengzz.id);

    if (gameplay != null) {
      if (gameplay.currentLevel == levelNames.length - 1) {
        _exitToMainMenu();
      } else {
        _startLevel(gameplay.currentLevel + 1);
      }
    }
  }

  void pauseGame() {
    _router.pushNamed(PauseMenu.id);
    pauseEngine();
  }

  void _resumeGame() {
    _router.pop();
    resumeEngine();
  }

  void _exitToMainMenu() {
    _resumeGame();
    _router.pushReplacementNamed(StartScreen.id);
  }

  void showLevelCompleteMenu(int nStars) {
    _router.pushNamed('${LevelComplete.id}/$nStars');
  }

  void showRetryMenu() {
    _router.pushNamed(GameOverScreen.id);
  }
}
