import 'package:flutter/material.dart';

Future<void> showRestroomLoadingScreen(context) async {
  return Future.delayed(Duration.zero, () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const RestroomLoadingScreen();
      },
    );
  });
}

class RestroomLoadingScreen extends StatelessWidget {
  const RestroomLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: Dialog.fullscreen(
        backgroundColor: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
