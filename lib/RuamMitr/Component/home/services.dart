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
            appDescription: "A community's portal for Uni student",
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
            appDescription: "Use the restroom with confidence",
            width: size.width,
            height: size.height * 0.1,
            appIconPath: "assets/Logo/restroom_home_logo.png",
            appRoute: () {
              Navigator.pushNamed(context, restroomPageRoute["home"]!);

              // Navigator.popAndPushNamed(context, restroomPageRoute["home"]!);
            },
          ),
          AppBox(
            appName: "PinTheBin",
            appDescription: "Properly dispose your trash",
            width: size.width,
            height: size.height * 0.1,
            appIconPath: "assets/Logo/bin_portal_color.png",
            appRoute: () {
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //     pinthebinPageRoute["home"]!, (Route<dynamic> route) => false);
              Navigator.pushNamed(context, pinthebinPageRoute["home"]!);
            },
          ),
          AppBox(
            appName: "Dinodengzz",
            appDescription: "A musicwriter who barely able to make a game",
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
