import 'package:flutter/material.dart';

class LevelComplete extends StatelessWidget {
  const LevelComplete({
    required this.nStars,
    required this.onNextPressed,
    required this.onRetryPressed,
    required this.onExitPressed,
    super.key,
  });

  static const id = 'LevelComplete';

  final int nStars;
  final VoidCallback onNextPressed;
  final VoidCallback onRetryPressed;
  final VoidCallback onExitPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/Background/Level cleared no bg.png",
            ),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.145),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  nStars >= 1 ? Icons.star : Icons.star_border,
                  color: nStars >= 1 ? Colors.amber : Colors.grey[700],
                  size: MediaQuery.of(context).size.height * 0.2569,
                ),
                Transform.translate(
                  offset: nStars >= 2
                      ? Offset(0, -MediaQuery.of(context).size.height * 0.0869)
                      : Offset.zero,
                  child: Icon(
                    nStars >= 2 ? Icons.star : Icons.star_border,
                    color: nStars >= 2 ? Colors.amber : Colors.grey[700],
                    size: MediaQuery.of(context).size.height * 0.2569,
                  ),
                ),
                Icon(
                  nStars >= 3 ? Icons.star : Icons.star_border,
                  color: nStars >= 3 ? Colors.amber : Colors.grey[700],
                  size: MediaQuery.of(context).size.height * 0.2569,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.129),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularButton(
                  onPressed: nStars != 0 ? onNextPressed : null,
                  imagePath:
                      'assets/images/DinoDengzz Icon/Next level icon.png',
                ),
                CircularButton(
                  onPressed: onRetryPressed,
                  imagePath: 'assets/images/DinoDengzz Icon/Restart icon.png',
                ),
                CircularButton(
                  onPressed: onExitPressed,
                  imagePath:
                      'assets/images/DinoDengzz Icon/Back to level select icon.png',
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ],
        ),
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String imagePath;

  const CircularButton({
    super.key,
    required this.onPressed,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.025),
      width: MediaQuery.of(context).size.width * 0.096,
      height: MediaQuery.of(context).size.width * 0.096,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(100),
          child: Center(
            child: Image.asset(
              imagePath,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
