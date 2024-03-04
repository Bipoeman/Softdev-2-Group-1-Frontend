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
            appName: "Dekhor",
            width: size.width,
            height: size.height * 0.1,
            appIconPath: "assets/Logo/dekhor_portal_color.png",
            appRoute: () {
              Navigator.pushNamed(context, tuachuayDekhorPageRoute["home"]!);
            },
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
            appIconPath: "assets/Logo/restroom_home_logo.png",
            appRoute: () {
              Navigator.popAndPushNamed(context, restroomPageRoute["home"]!);
            },
          ),
          AppBox(
            appName: "PinTheBin",
            width: size.width,
            height: size.height * 0.1,
            appIconPath: "assets/Logo/bin_portal_color.png",
            appRoute: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  pinthebinPageRoute["home"]!, (Route<dynamic> route) => false);
            },
          ),
          AppBox(
            appName: "DinoDengzz",
            width: size.width,
            height: size.height * 0.1,
            appIconPath: "assets/Logo/Dino_Portal_Sakura_bg.png",
            appRoute: () {
              Navigator.pushNamed(context, dinodengzzPageRoute);
            },
          ),
        ],
      ),
    );
  }
}
