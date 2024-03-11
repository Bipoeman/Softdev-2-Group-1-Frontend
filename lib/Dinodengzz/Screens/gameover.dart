import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final VoidCallback onRetryPressed;
  final VoidCallback onMainMenuPressed;

  const GameOverScreen({
    super.key,
    required this.onRetryPressed,
    required this.onMainMenuPressed,
  });

  static const id = 'GameOver';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/Background/DinoDengzz Game Over Screen.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                ElevatedButton(
                  onPressed: onRetryPressed,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size.zero,
                  ),
                  child: Image.asset(
                    'assets/images/DinoDengzz Icon/Red restart button.png',
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height * 0.13,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                ElevatedButton(
                  onPressed: onMainMenuPressed,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size.zero,
                  ),
                  child: Image.asset(
                    'assets/images/DinoDengzz Icon/Quit button 2.0.png',
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height * 0.13,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
