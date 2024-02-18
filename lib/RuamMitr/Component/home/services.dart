import 'package:flutter/material.dart';
import 'package:ruam_mitt/RuamMitr/Component/home/app_box.dart';
import 'package:ruam_mitt/global_const.dart';

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({super.key, required this.size});
  final Size size;

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
            width: size.width,
            height: size.height * 0.1,
          ),
          // AppBox(
          //   appName: "Market",
          //   width: size.width,
          //   height: size.height * 0.1,
          // ),
          AppBox(
            appName: "Restroom",
            width: size.width,
            height: size.height * 0.1,
            appRoute: () {
              Navigator.popAndPushNamed(context, restroomPageRoute["home"]!);
            },
          ),
          AppBox(
            appName: "Bin",
            width: size.width,
            height: size.height * 0.1,
          ),
          AppBox(
            appName: "DinoDengzz",
            width: size.width,
            height: size.height * 0.1,
            appIconPath: "assets/Logo/dino_portal_colored_bg.png",
            appRoute: () {
              Navigator.pushNamed(context, "/game");
            },
          ),
        ],
      ),
    );
  }
}
