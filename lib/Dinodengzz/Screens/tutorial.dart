import 'package:flutter/material.dart';
import 'package:ruam_mitt/Dinodengzz/Screens/start.dart';

class TutorialScreen extends StatelessWidget {
  final VoidCallback onExit;
  final VoidCallback onPlay;

  const TutorialScreen({
    super.key,
    required this.onExit,
    required this.onPlay,
  });

  static const id = 'Tutorial';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FractionallySizedBox(
            alignment: Alignment.center,
            widthFactor: 1,
            child: Image.asset(
              "assets/images/DinoDengzz Icon/Tutorial.png",
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
                          "assets/images/DinoDengzz Icon/Exit button.png",
                      onPressed: onExit,
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
