import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  final VoidCallback onLevelSelectionPressed;
  final VoidCallback onExitPressed;
  final VoidCallback onSettingPressed;

  const StartScreen({
    Key? key,
    required this.onLevelSelectionPressed,
    required this.onExitPressed,
    required this.onSettingPressed,
  }) : super(key: key);

  static const id = 'StartScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 2560 / 640, // Adjust the ratio for the left part
            child: Image.asset(
              "assets/images/Background/DinoDengzz Start Screen.png",
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.047),
              child: SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.4, // Adjust the width of the buttons
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3333,
                      height: MediaQuery.of(context).size.height *
                          0.11, // Adjust the height of the buttons
                      child: ElevatedButton(
                        onPressed: onLevelSelectionPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: const BeveledRectangleBorder(),
                        ),
                        child: null,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3333,
                      height: MediaQuery.of(context).size.height *
                          0.11, // Adjust the height of the buttons
                      child: ElevatedButton(
                        onPressed: onSettingPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: const BeveledRectangleBorder(),
                        ),
                        child: null,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3333,
                      height: MediaQuery.of(context).size.height *
                          0.11, // Adjust the height of the buttons
                      child: ElevatedButton(
                        onPressed: onExitPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: const BeveledRectangleBorder(),
                        ),
                        child: null,
                      ),
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
