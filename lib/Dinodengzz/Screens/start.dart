import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  final VoidCallback? onLevelSelectionPressed;
  final VoidCallback? onExitPressed;
  final VoidCallback? onSettingPressed;

  const StartScreen({
    super.key,
    this.onLevelSelectionPressed,
    this.onExitPressed,
    this.onSettingPressed,
  });

  static const id = 'StartScreen';
  final _scaleValue = 0.8;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: Image.asset(
              "assets/images/DinoDengzz Icon/Plain background.png",
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: 300 * _scaleValue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    onLevelSelectionPressed == null
                        ? const SizedBox()
                        :
                    CustomIconButton(
                      imagePath: "assets/images/DinoDengzz Icon/Start button.png",
                      onPressed: onLevelSelectionPressed ?? () {},
                    ),
                    const SizedBox(height: 20),
                    onSettingPressed == null
                        ? const SizedBox()
                        :
                    CustomIconButton(
                      imagePath: "assets/images/DinoDengzz Icon/Setting button.png",
                      onPressed: onSettingPressed ?? () {},
                    ),
                    const SizedBox(height: 20),
                    onExitPressed == null
                        ? const SizedBox()
                        :
                    CustomIconButton(
                      imagePath: "assets/images/DinoDengzz Icon/Quit button 2.0.png",
                      onPressed: onExitPressed ?? () {},
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
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            shape: const BeveledRectangleBorder(),
          ),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
