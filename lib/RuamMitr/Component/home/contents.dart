import 'package:flutter/material.dart';

Widget AppContent(
    {required String title,
    required Color color,
    required Size screenSize,
    Widget? contentBox}) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(
            top: screenSize.height * 0.03, bottom: screenSize.height * 0.01),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: screenSize.width * 0.03),
              width: screenSize.width * 0.06,
              height: screenSize.width * 0.06,
              decoration: BoxDecoration(color: color),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      contentBox ?? const Text("No Content")
    ],
  );
}

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    super.key,
    required this.size,
    this.dekhorContent,
    this.pinTheBinContent,
    this.restroomContent,
    this.dinodengzzContent,
  });
  final Widget? dekhorContent;
  final Widget? pinTheBinContent;
  final Widget? restroomContent;
  final Widget? dinodengzzContent;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        children: [
          AppContent(
            title: "Dekhor",
            color: const Color(0xFF003049),
            screenSize: size,
            contentBox: dekhorContent,
          ),
          AppContent(
            title: "PinTheBin",
            color: const Color(0xFFF77F00),
            screenSize: size,
            contentBox: pinTheBinContent,
          ),
          AppContent(
            title: "Restroom",
            color: const Color(0xFFFFB703),
            screenSize: size,
            contentBox: restroomContent,
          ),
          AppContent(
            title: "Dinodengzz",
            color: const Color(0xFF0A9396),
            screenSize: size,
            contentBox: dinodengzzContent,
          ),
        ],
      ),
    );
  }
}
