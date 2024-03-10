import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ruam_mitt/Dinodengzz/Screens/gameover.dart';
import 'package:ruam_mitt/Dinodengzz/Screens/levelcomplete.dart';
import 'package:ruam_mitt/Dinodengzz/Screens/levelselect.dart';
import 'package:ruam_mitt/Dinodengzz/Screens/pause.dart';
import 'package:ruam_mitt/Dinodengzz/Screens/setting.dart';
import 'package:ruam_mitt/Dinodengzz/Screens/space_gameover.dart';
import 'package:ruam_mitt/Dinodengzz/Screens/start.dart';
import 'package:ruam_mitt/Dinodengzz/Screens/tutorial.dart';
import 'package:ruam_mitt/Dinodengzz/dinodengzz.dart';
import 'package:ruam_mitt/Dinodengzz/spacedengzz.dart';

class GameRoutes extends FlameGame
    with
        HasKeyboardHandlerComponents,
        DragCallbacks,
        HasCollisionDetection,
        PanDetector {
  List<String> levelNames = ['Level-01', 'Level-02', 'Level-03', 'Level-04'];
  String finalBoss = 'FinalBoss.wav';
  String gameOver = 'Over.wav';
  String startGame = 'Start_Screen.wav';
  String boss = 'Boss.wav';
  String gameBGM = 'Bgm.wav';
  String jumpSfx = 'Deng_Suu.wav';
  String collectSfx = 'Collect.wav';
  String shootSfx = 'laserShoot.wav';
  String hitSfx = 'Hit.wav';
  String hitStarSfx = 'StarHit.wav';
  String clearSFX = 'Disappear.wav';
  String KTSFX = 'KT.wav';
  bool playSounds = true;
  late double masterVolume = 1.0;
  late double bgmVolume = 0.6;
  late double sfxVolume = 0.6;

  late final _routes = <String, Route>{
    StartScreen.id: OverlayRoute(
      (context, game) => StartScreen(
          onLevelSelectionPressed: () => _routeById(LevelSelectionScreen.id),
          onExitPressed: () {
            FlameAudio.bgm.stop();
            Flame.device.setPortraitUpOnly();
            navigator?.pop(context);
          },
          onSettingPressed: () {
            FlameAudio.bgm.pause();
            _routeById(Settings.id);
          }),
    ),
    Settings.id: OverlayRoute(
      (context, game) => Settings(
        onBgmVolumeChanged: onBgmVolumeChanged,
        onMasterVolumeChanged: onMasterVolumeChanged,
        onSfxVolumeChanged: onSfxVolumeChanged,
        onBackPressed: _exitToMainMenu,
        masterVolume: masterVolume,
        bgmVolume: bgmVolume,
        sfxVolume: sfxVolume,
      ),
    ),
    LevelSelectionScreen.id: OverlayRoute((context, game) =>
        LevelSelectionScreen(
            levelNames: levelNames,
            onLevelSelected: _startLevel,
            onBackPressed: _popRoute,
            onTutorialPressed: () => _routeById(TutorialScreen.id),
            onBossPressed: () => startBoss())),
    PauseMenu.id: OverlayRoute(
      (context, game) => PauseMenu(
        onResumePressed: _resumeGame,
        onRetryPressed: _restartLevel,
        onExitPressed: _exitToMainMenu,
      ),
    ),
    GameOverScreen.id: OverlayRoute(
      (context, game) => GameOverScreen(
        onRetryPressed: () {
          FlameAudio.bgm.stop();
          _restartLevel();
        },
        onMainMenuPressed: () {
          FlameAudio.bgm.stop();
          _exitToMainMenu();
        },
      ),
    ),
    SpaceGameOverScreen.id: OverlayRoute(
      (context, game) => SpaceGameOverScreen(
        onRetryPressed: () {
          FlameAudio.bgm.stop();
          resumeEngine();
          startBoss();
        },
        onMainMenuPressed: () {
          FlameAudio.bgm.stop();
          resumeEngine();
          _exitToMainMenu();
        },
      ),
    ),
    TutorialScreen.id: OverlayRoute(
      (context, game) => TutorialScreen(
        onExit: _popRoute,
        onPlay: () => _startLevel(1),
      ),
    )
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
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play(startGame, volume: masterVolume * bgmVolume);
    await images.loadAllImages();
    await add(_router);
  }

  void dispose() {
    FlameAudio.bgm.dispose();
  }

  void _routeById(String id) {
    _router.pushNamed(id);
  }

  void _popRoute() {
    _router.pop();
    FlameAudio.bgm.resume();
  }

  void _startLevel(int levelIndex) {
    _router.pop();
    if (levelIndex < levelNames.length - 1) {
      FlameAudio.bgm.play(gameBGM, volume: masterVolume * bgmVolume);
    } else {
      FlameAudio.bgm.play(boss, volume: masterVolume * bgmVolume);
    }
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

  void startBoss() {
    _router.pop();
    FlameAudio.bgm.stop();
    _router.pushReplacement(
      Route(
        () => SpaceDengzz(
          onPausePressed: pauseGame,
          onLevelCompleted: showLevelCompleteMenu,
          onGameOver: showRetryMenuvertical,
          key: ComponentKey.named(SpaceDengzz.id),
        ),
      ),
      name: SpaceDengzz.id,
    );
  }

  void _restartLevel() {
    final gameplay = findByKeyName<DinoDengzz>(DinoDengzz.id);
    final bossplay = findByKeyName<SpaceDengzz>(SpaceDengzz.id);
    if (bossplay != null) {
      startBoss();
      resumeEngine();
    } else if (gameplay != null) {
      _startLevel(gameplay.currentLevel);
      resumeEngine();
    }
  }

  void _startNextLevel() {
    final gameplay = findByKeyName<DinoDengzz>(DinoDengzz.id);
    FlameAudio.bgm.stop();
    if (gameplay != null) {
      if (gameplay.currentLevel == levelNames.length - 1) {
        _exitToMainMenu();
      } else {
        if (gameplay.currentLevel < levelNames.length) {
          FlameAudio.bgm.play(gameBGM, volume: masterVolume * bgmVolume);
        } else {
          FlameAudio.bgm.play(boss, volume: masterVolume * bgmVolume);
        }
        _startLevel(gameplay.currentLevel + 1);
      }
    }
  }

  void pauseGame() {
    _router.pushNamed(PauseMenu.id);
    FlameAudio.bgm.pause();
    pauseEngine();
  }

  void _resumeGame() {
    _router.pop();
    FlameAudio.bgm.resume();
    resumeEngine();
  }

  Future<void> _exitToMainMenu() async {
    _resumeGame();
    FlameAudio.bgm.stop();
    await Flame.device.setLandscape();
    _router.pushReplacementNamed(StartScreen.id);
    FlameAudio.bgm.play(startGame, volume: masterVolume * bgmVolume);
  }

  void showLevelCompleteMenu(int nStars) {
    _router.pushNamed('${LevelComplete.id}/$nStars');
  }

  void showRetryMenu() {
    FlameAudio.bgm.play(gameOver, volume: masterVolume * bgmVolume);
    _router.pushNamed(GameOverScreen.id);
  }

  void showRetryMenuvertical() {
    FlameAudio.bgm.play(gameOver, volume: masterVolume * bgmVolume);
    _router.pushNamed(SpaceGameOverScreen.id);
  }

  void onMasterVolumeChanged(double volume) {
    masterVolume = (volume / 100);
  }

  void onBgmVolumeChanged(double volume) {
    bgmVolume = (volume / 100);
  }

  void onSfxVolumeChanged(double volume) {
    sfxVolume = (volume / 100);
  }

  void stopBGMInApp() {
    FlameAudio.bgm.stop();
  }
}
