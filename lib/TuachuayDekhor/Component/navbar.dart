import 'package:flutter/material.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/search_box.dart';
import 'package:ruam_mitt/global_const.dart';

class NavbarTuachuayDekhor extends StatelessWidget {
  const NavbarTuachuayDekhor({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.width * 0.175,
                width: size.width * 0.175,
                child: const Image(
                  image:
                      AssetImage("assets/images/Logo/TuachuayDekhor_Light.png"),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 12.5),
            width: size.width * 0.5,
            child: const TuachuaySearchBox(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10, top: 10),
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: size.width * 0.125,
                  width: size.width * 0.125,
                  child: RawMaterialButton(
                    shape: const CircleBorder(),
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: size.width * 0.075,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ruamMitrPageRoute["profile"]!);
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
