import 'package:flutter/material.dart';

class LevelSelectionScreen extends StatelessWidget {
  final List<String> levelNames;
  final ValueChanged<int> onLevelSelected;
  final VoidCallback onBackPressed;
  final VoidCallback onTutorialPressed;
  final VoidCallback onBossPressed;

  const LevelSelectionScreen({
    super.key,
    required this.levelNames,
    required this.onLevelSelected,
    required this.onBackPressed,
    required this.onTutorialPressed,
    required this.onBossPressed,
  });

  static const id = 'LevelSelection';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final buttonWidth = screenWidth * 0.212;
    final buttonHeight = screenHeight * 0.151;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/images/DinoDengzz Icon/Select Level Screen.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.0015,
                    left: MediaQuery.of(context).size.width * 0.0015),
                child: InkWell(
                  onTap: onBackPressed,
                  child: CircleAvatar(
                    radius: screenWidth * 0.045,
                    backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.02,
                    right: MediaQuery.of(context).size.width * 0.01),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextButton(
                    onPressed: onTutorialPressed,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.4,
              left: screenWidth * 0.2,
              child: SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: ElevatedButton(
                  onPressed: () {
                    onLevelSelected(0);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    elevation: MaterialStateProperty.all<double>(0),
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: const SizedBox(),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.39,
              left: screenWidth * 0.525,
              child: SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: ElevatedButton(
                  onPressed: () {
                    onLevelSelected(1);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    elevation: MaterialStateProperty.all<double>(0),
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: const SizedBox(),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.65,
              left: screenWidth * 0.2,
              child: SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: ElevatedButton(
                  onPressed: () {
                    onLevelSelected(2);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    elevation: MaterialStateProperty.all<double>(0),
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: const SizedBox(),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.65,
              left: screenWidth * 0.52,
              child: SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: ElevatedButton(
                  onPressed: () {
                    onLevelSelected(3);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    elevation: MaterialStateProperty.all<double>(0),
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: const SizedBox(),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.2,
              right: screenWidth * 0.07,
              width: screenWidth * 0.169,
              height: screenWidth * 0.169,
              child: BossButton(
                onPressed: onBossPressed,
                imagePath:
                    'assets/images/DinoDengzz Icon/Boss level button enraged.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BossButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String imagePath;

  const BossButton({
    super.key,
    required this.onPressed,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.width * 0.69),
        child: ClipOval(
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
