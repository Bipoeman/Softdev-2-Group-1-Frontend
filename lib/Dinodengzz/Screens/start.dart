import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  final VoidCallback onLevelSelectionPressed;
  final VoidCallback onExitPressed;
  final VoidCallback onSettingPressed;

  const StartScreen({
    super.key,
    required this.onLevelSelectionPressed,
    required this.onExitPressed,
    required this.onSettingPressed,
  });

  static const id = 'StartScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FractionallySizedBox(
            alignment: Alignment.center,
            widthFactor: 1,
            child: Image.asset(
              "assets/images/DinoDengzz Icon/Plain background.png",
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.047),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomIconButton(
                      imagePath:
                          "assets/images/DinoDengzz Icon/Start button.png",
                      onPressed: onLevelSelectionPressed,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    CustomIconButton(
                      imagePath:
                          "assets/images/DinoDengzz Icon/Setting button.png",
                      onPressed: onSettingPressed,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    CustomIconButton(
                      imagePath:
                          "assets/images/DinoDengzz Icon/Exit button.png",
                      onPressed: onExitPressed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const CustomIconButton({
    super.key,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.3;
    double buttonHeight = MediaQuery.of(context).size.height * 0.11;

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: const BeveledRectangleBorder(),
        ),
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
