import 'package:flutter/material.dart';

class ExitDialog extends StatelessWidget {
  final VoidCallback onExitPressed;

  const ExitDialog({
    required this.onExitPressed,
    super.key,
  });

  static const id = 'ExitDialog';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: Colors.black,
        title: const Text(
          'Exit Game',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Kanit',
          ),
        ),
        content: const Text(
          'Are you sure you want to exit the game?',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Kanit',
          ),
        ),
        actions: [
          TextButton(
            onPressed: onExitPressed,
            child: Text(
              'Yes',
              style: TextStyle(
                color: Colors.red[300],
                fontFamily: 'Kanit',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'No',
              style: TextStyle(
                color: Colors.yellow[300],
                fontFamily: 'Kanit',
              ),
            )
          ),
        ],
      ),
    );
  }
}
