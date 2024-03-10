import 'package:flutter/material.dart';

class LevelCompleteBoss extends StatelessWidget {
  final VoidCallback onExitPressed;

  const LevelCompleteBoss({
    required this.onExitPressed,
    super.key,
  });

  static const id = 'LevelCompleteBoss';

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
                  onPressed: onExitPressed,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size.zero,
                  ),
                  child: Image.asset(
                    'assets/images/DinoDengzz Icon/Quit button 2.0.png',
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height * 0.1269420,
                    width: MediaQuery.of(context).size.width * 0.69420,
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
