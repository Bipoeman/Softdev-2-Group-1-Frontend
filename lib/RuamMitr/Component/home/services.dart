import 'package:flutter/material.dart';
import 'package:ruam_mitt/RuamMitr/Component/home/app_box.dart';

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({super.key});
  final double size = 200;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          AppBox(
            appName: "Tuachuay",
            width: size,
            height: size,
          ),
          AppBox(
            appName: "Market",
            width: size,
            height: size,
          ),
          AppBox(
            appName: "Restroom",
            width: size,
            height: size,
          ),
          AppBox(
            appName: "Bin",
            width: size,
            height: size,
          ),
          AppBox(
            appName: "DinoDengzz",
            width: size,
            height: size,
            appRoute: () {
              Navigator.pushNamed(context, "/game");
            },
          ),
        ],
      ),
    );
  }
}
