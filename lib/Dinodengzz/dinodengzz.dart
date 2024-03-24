import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:ruam_mitt/Dinodengzz/Component/hud.dart';
import 'package:ruam_mitt/Dinodengzz/Component/level.dart';
import 'package:ruam_mitt/Dinodengzz/Component/player.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class DinoDengzz extends Component with HasGameReference<GameRoutes> {
  DinoDengzz(
    this.currentLevel, {
    super.key,
    required this.onPausePressed,
    required this.onLevelCompleted,
    required this.onGameOver,
  });

  static const id = 'Gameplay';

  final int currentLevel;
  final VoidCallback onPausePressed;
  final ValueChanged<int> onLevelCompleted;
  final VoidCallback onGameOver;

  late CameraComponent cam;
  Player player = Player(character: 'Relaxaurus');
  late double cameraWidth = 660;
  late double cameraHeight;

  late JoystickComponent joystick;
  late Hud hud;
  bool joyControls = true;
  bool levelComplete = false;

  Color backgroundColor() => const Color.fromARGB(255, 30, 28, 45);

  @override
  FutureOr<void> onLoad() async {
    await Flame.device.fullScreen();
    _loadLevel();
    if (game.playDialog) {
      if (currentLevel == 0) showFirstLevelDialog(game.buildContext);
      if (currentLevel == 1) showSecondLevelDialog(game.buildContext);
      if (currentLevel == 2) showThirdLevelDialog(game.buildContext);
      if (currentLevel == 3) showFourthLevelDialog(game.buildContext);
    }
  }

  @override
  void update(double dt) {
    hud.updateLifeCount(player.remainingLives);
    if (joyControls) {
      player.hasJumped = hud.hasJumped;
      player.horizontalMovement = hud.horizontalMovement;
    }
    super.update(dt);
  }

  void _loadLevel() {
    Level world = Level(
      levelName: game.levelNames[currentLevel],
      player: player,
    );
    double screenWidth = game.size.x;
    double screenHeight = game.size.y;
    double aspectRatio = screenWidth / screenHeight;
    cameraHeight = cameraWidth / aspectRatio;
    hud = Hud(cameraWidth, cameraHeight);

    cam = CameraComponent.withFixedResolution(
      world: world,
      width: cameraWidth,
      height: cameraHeight,
      hudComponents: [hud],
    );
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([world, cam]);
  }

  void showFirstLevelDialog(BuildContext? context) {
    if (context == null) {
      return;
    }

    String title = "ใครอะ";

    List<String> contents = [
      "สวัสดีนะคู่หู!ก่อนจะเริ่มเรื่องราวนี้กับฉัน นายเข้าใจพื้นฐานของโลกนี้หรือยังล่ะ?",
      "ถ้ายัง...ฉันแนะนำให้นายเข้าไปดู Tutorial ก่อนเริ่มเรื่องราวนี้นะ",
      "เอาล่ะ! นายพร้อมแล้วใช่ไหม งั้นมาเริ่มจากด่านพื้นฐานกันก่อนเลย!"
    ];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(219, 255, 192, 136),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(width: 16.0, color: Color.fromARGB(255, 70, 24, 6)),
          ),
          contentPadding: const EdgeInsets.all(24.0),
          title: Text(
            title,
            style: const TextStyle(
              color: Color.fromARGB(255, 206, 63, 89),
              fontFamily: 'Kanit',
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    textStyle: const TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 20,
                      color: Color.fromARGB(255, 58, 52, 52),
                    ),
                    contents[0],
                    speed: const Duration(milliseconds: 55),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: Colors.red.withOpacity(0.5),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "แล้วนายเป็นใคร",
                      style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  color: Colors.blue.withOpacity(0.5),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showThirdDialogFirstLevel(context, title, contents, 2);
                    },
                    child: const Text(
                      "รู้แล้วละ ขอบคุณ",
                      style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  color: Colors.green.withOpacity(0.5),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showSecondDialogFirstLevel(context, title, contents, 1);
                    },
                    child: const Text(
                      "ไม่รู้เลย",
                      style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void showSecondDialogFirstLevel(
      BuildContext context, String title, List<String> contents, int index) {
    if (index >= contents.length) {
      return; // Reached the end
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(219, 255, 192, 136),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(width: 16.0, color: Color.fromARGB(255, 70, 24, 6)),
          ),
          contentPadding: const EdgeInsets.all(24.0),
          title: Text(
            title,
            style: const TextStyle(
              color: Color.fromARGB(255, 206, 63, 89),
              fontFamily: 'Kanit',
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    contents[index],
                    textStyle: const TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 20,
                      color: Color.fromARGB(255, 58, 52, 52),
                    ),
                    speed: const Duration(milliseconds: 50),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ],
          ),
          actions: [
            Container(
              color: Colors.blue.withOpacity(0.5),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showThirdDialogFirstLevel(context, title, contents, index + 1);
                },
                child: const Text(
                  "โอเค",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Kanit',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8), // Add spacing between buttons
            Container(
              color: Colors.green.withOpacity(0.5),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "ใครสนละ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Kanit',
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showThirdDialogFirstLevel(
      BuildContext context, String title, List<String> contents, int index) {
    if (index >= contents.length) {
      return; // Reached the end
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(219, 255, 192, 136),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(width: 16.0, color: Color.fromARGB(255, 70, 24, 6)),
          ),
          contentPadding: const EdgeInsets.all(24.0),
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Kanit',
              color: Color.fromARGB(255, 206, 63, 89),
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    contents[index],
                    textStyle: const TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 20,
                      color: Color.fromARGB(255, 58, 52, 52),
                    ),
                    speed: const Duration(milliseconds: 50),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ],
          ),
          actions: [
            Container(
              color: Colors.blue.withOpacity(0.5),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "โอเค",
                  style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showSecondLevelDialog(BuildContext? context) {
    if (context == null) {
      return;
    }
    String title = "ใครอะ";

    List<String> contents = [
      "เยี่ยมเลย! นายเข้าใจเรื่องพื้นฐานแล้วสินะ",
      "คราวนี้มาลองดูอะไรที่มันยากขึ้นมาหน่อยละกัน แน่นอนว่าในการผจญภัยน่ะ การสังเกตสิ่งต่างๆ รอบตัวรวมถึงรายละเอียดเล็กๆ น้อยๆ ก็เป็นสิ่งสำคัญนะ!"
    ];

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(219, 255, 192, 136),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(width: 16.0, color: Color.fromARGB(255, 70, 24, 6)),
          ),
          contentPadding: const EdgeInsets.all(24.0),
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Kanit',
              color: Color.fromARGB(255, 206, 63, 89),
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    contents[0],
                    textStyle: const TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 20,
                      color: Color.fromARGB(255, 58, 52, 52),
                    ),
                    speed: const Duration(milliseconds: 50),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ],
          ),
          actions: [
            Container(
              color: Colors.blue.withOpacity(0.5),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showSecondDialogSecondLevel(context, title, contents, 1);
                },
                child: const Text(
                  "น่าจะนะ",
                  style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: 8), // Add spacing between buttons
            Container(
              color: Colors.red.withOpacity(0.5),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "นายเป็นใครนะ",
                  style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showSecondDialogSecondLevel(
      BuildContext context, String title, List<String> contents, int index) {
    if (index >= contents.length) {
      return;
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(219, 255, 192, 136),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(width: 16.0, color: Color.fromARGB(255, 70, 24, 6)),
          ),
          contentPadding: const EdgeInsets.all(24.0),
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Kanit',
              color: Color.fromARGB(255, 206, 63, 89),
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    contents[index],
                    textStyle: const TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 20,
                      color: Color.fromARGB(255, 58, 52, 52),
                    ),
                    speed: const Duration(milliseconds: 10),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ],
          ),
          actions: [
            Container(
              color: Colors.blue.withOpacity(0.5),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showThirdDialogFirstLevel(context, title, contents, index + 1);
                },
                child: const Text(
                  "โอเค",
                  style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: 8), // Add spacing between buttons
            Container(
              color: Colors.green.withOpacity(0.5),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "ห่ะ! อะไรนะ",
                  style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showThirdLevelDialog(BuildContext? context) {
    if (context == null) {
      return;
    }

    String title = "สรุปใครนะ";

    List<String> contents = [
      "เป็นไงบ้างล่ะคู่หู? 2 ด่านก่อนหน้านี้น่ะ ง่ายใช่ไหมล่ะ?",
      "แต่ดูเหมือนด่านนี้กับดักจะเยอะเป็นพิเศษนะ",
      "เดาว่าผู้พัฒนาคงจะคิดว่าเธอผ่านด่านก่อนๆมาง่ายไปสินะ? เอาเถอะ เรารีบไปเอาก๊วยเตี๋ยวตรงนั้นแล้วไปด่านต่อไปกันเถอะ!"
    ];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(219, 255, 192, 136),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(width: 16.0, color: Color.fromARGB(255, 70, 24, 6)),
          ),
          contentPadding: const EdgeInsets.all(24.0),
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Kanit',
              color: Color.fromARGB(255, 206, 63, 89),
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    textStyle: const TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 20,
                      color: Color.fromARGB(255, 58, 52, 52),
                    ),
                    contents[0],
                    speed: const Duration(milliseconds: 55),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: Colors.red.withOpacity(0.5),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "แล้วสรุปนายเป็นใครกันอะ",
                      style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  color: Colors.blue.withOpacity(0.5),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showSecondDialogThirdLevel(context, title, contents, 1);
                    },
                    child: const Text(
                      "ก็เฉยๆนะ",
                      style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  color: Colors.green.withOpacity(0.5),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showSecondDialogThirdLevel(context, title, contents, 1);
                    },
                    child: const Text(
                      "กระจอกเกินอะบอกตรง",
                      style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void showSecondDialogThirdLevel(
      BuildContext context, String title, List<String> contents, int index) {
    if (index >= contents.length) {
      return;
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(219, 255, 192, 136),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(width: 16.0, color: Color.fromARGB(255, 70, 24, 6)),
          ),
          contentPadding: const EdgeInsets.all(24.0),
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Kanit',
              color: Color.fromARGB(255, 206, 63, 89),
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    contents[index],
                    textStyle: const TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 20,
                      color: Color.fromARGB(255, 58, 52, 52),
                    ),
                    speed: const Duration(milliseconds: 50),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ],
          ),
          actions: [
            Container(
              color: Colors.blue.withOpacity(0.5),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showThirdDialogThirdLevel(context, title, contents, index + 1);
                },
                child: const Text(
                  "จริงด้วย",
                  style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              color: Colors.green.withOpacity(0.5),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showThirdDialogThirdLevel(context, title, contents, index + 1);
                },
                child: const Text(
                  "กะจะให้ผ่านบ้างมั้ยห่ะ!",
                  style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showThirdDialogThirdLevel(
      BuildContext context, String title, List<String> contents, int index) {
    if (index >= contents.length) {
      return;
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(219, 255, 192, 136),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(width: 16.0, color: Color.fromARGB(255, 70, 24, 6)),
          ),
          contentPadding: const EdgeInsets.all(24.0),
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Kanit',
              color: Color.fromARGB(255, 206, 63, 89),
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    contents[index],
                    textStyle: const TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 20,
                      color: Color.fromARGB(255, 58, 52, 52),
                    ),
                    speed: const Duration(milliseconds: 5),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ],
          ),
          actions: [
            Container(
              color: Colors.blue.withOpacity(0.5),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "โอเคเลย",
                  style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              color: Colors.green.withOpacity(0.5),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "ผู้พัฒนาอยากหาที่ระบายนะสิไม่ว่า",
                  style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showFourthLevelDialog(BuildContext? context) {
    if (context == null) {
      return;
    }

    String title = "ก็ยังไม่รู้ว่าใครอยู่ดี";

    List<String> contents = [
      "โอ้! เธอผ่านด่าน \"ง่ายๆ\" ทั้ง 3 ด่านมาได้แล้วสินะ",
      "เอาล่ะ! เธอน่าจะฝึกฝนมาพอแล้วล่ะ คราวนี้ถึงตาเธอลุยของจริงแล้ว!",
      "เธอเห็นดาวพวกนั้นไหม ฉันเรียกพวกมันว่า \"PATRIK\" ล่ะ",
      "และก็พวกมันนี่แหละที่เป็นคนเริ่มเรื่องราวทั้งหมดนี้ จัดการมันเลยสิ!",
    ];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(219, 255, 192, 136),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(width: 16.0, color: Color.fromARGB(255, 70, 24, 6)),
          ),
          contentPadding: const EdgeInsets.all(24.0),
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Kanit',
              color: Color.fromARGB(255, 206, 63, 89),
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    textStyle: const TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 20,
                      color: Color.fromARGB(255, 58, 52, 52),
                    ),
                    contents[0],
                    speed: const Duration(milliseconds: 55),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: Colors.red.withOpacity(0.5),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showSecondDialogFourthLevel(context, title, contents, 1);
                    },
                    child: const Text(
                      "จะบอกยังว่าเป็นใคร",
                      style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  color: Colors.blue.withOpacity(0.5),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showSecondDialogFourthLevel(context, title, contents, 1);
                    },
                    child: const Text(
                      "หมายถึง 2 หรือเปล่า",
                      style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  color: Colors.green.withOpacity(0.5),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showSecondDialogFourthLevel(context, title, contents, 1);
                    },
                    child: const Text(
                      "ง่ายเกิ้น",
                      style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void showSecondDialogFourthLevel(
      BuildContext context, String title, List<String> contents, int index) {
    if (index >= contents.length) {
      return; // Reached the end
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(219, 255, 192, 136),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(width: 16.0, color: Color.fromARGB(255, 70, 24, 6)),
          ),
          contentPadding: const EdgeInsets.all(24.0),
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Kanit',
              color: Color.fromARGB(255, 206, 63, 89),
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    contents[index],
                    textStyle: const TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 20,
                      color: Color.fromARGB(255, 58, 52, 52),
                    ),
                    speed: const Duration(milliseconds: 50),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ],
          ),
          actions: [
            Container(
              color: Colors.blue.withOpacity(0.5),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showThirdDialogFourthLevel(context, title, contents, index + 1);
                },
                child: const Text(
                  "ของจริง?",
                  style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: 8), // Add spacing between buttons
            Container(
              color: Colors.green.withOpacity(0.5),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showThirdDialogFourthLevel(context, title, contents, index + 1);
                },
                child: const Text(
                  "จิงโจ้หรือเปล่า?",
                  style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: 8), // Add spacing between buttons
            Container(
              color: Colors.pink.withOpacity(0.5),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showThirdDialogFourthLevel(context, title, contents, index + 1);
                },
                child: const Text(
                  "จริงใจได้มั้ย?",
                  style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showThirdDialogFourthLevel(
      BuildContext context, String title, List<String> contents, int index) {
    if (index >= contents.length) {
      return; // Reached the end
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(219, 255, 192, 136),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(width: 16.0, color: Color.fromARGB(255, 70, 24, 6)),
          ),
          contentPadding: const EdgeInsets.all(24.0),
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Kanit',
              color: Color.fromARGB(255, 206, 63, 89),
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    contents[index],
                    textStyle: const TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 20,
                      color: Color.fromARGB(255, 58, 52, 52),
                    ),
                    speed: const Duration(milliseconds: 50),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.blue.withOpacity(0.5),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showFourthDialogFourthLevel(context, title, contents, index + 1);
                    },
                    child: const Text(
                      "ทำไมชื่อคุ้นๆจังนะ",
                      style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  color: Colors.green.withOpacity(0.5),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showFourthDialogFourthLevel(context, title, contents, index + 1);
                    },
                    child: const Text(
                      "ไม่กลัวเลยจริงดิ",
                      style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  color: Colors.pink.withOpacity(0.5),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showFourthDialogFourthLevel(context, title, contents, index + 1);
                    },
                    child: const Text(
                      "โอโห้ PATRICK",
                      style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void showFourthDialogFourthLevel(
      BuildContext context, String title, List<String> contents, int index) {
    if (index >= contents.length) {
      return;
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(219, 255, 192, 136),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(width: 16.0, color: Color.fromARGB(255, 70, 24, 6)),
          ),
          contentPadding: const EdgeInsets.all(24.0),
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Kanit',
              color: Color.fromARGB(255, 206, 63, 89),
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    contents[index],
                    textStyle: const TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 20,
                      color: Color.fromARGB(255, 58, 52, 52),
                    ),
                    speed: const Duration(milliseconds: 50),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ],
          ),
          actions: [
            Container(
              color: Colors.blue.withOpacity(0.5),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "เข้ามาเลย!!",
                  style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              color: Colors.green.withOpacity(0.5),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "แล้วสู้ไงนะ",
                  style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
