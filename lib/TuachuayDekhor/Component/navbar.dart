import 'package:flutter/material.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/search_box.dart';
import 'package:ruam_mitt/global_const.dart';

class NavbarTuachuayDekhor extends StatelessWidget {
  const NavbarTuachuayDekhor({
    super.key,
    this.username,
    this.avatarUrl,
  });
  final String? username;
  final String? avatarUrl;

  Widget getAvatar(BuildContext context) {
    if (avatarUrl != null) {
      try {
        return CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(avatarUrl!),
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return const CircleAvatar(
      radius: 24,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.person,
        size: 23,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 68.5,
                width: 68.5,
                child: Image(
                  image:
                      AssetImage("assets/images/Logo/TuachuayDekhor_Light.png"),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 15),
            height: 56,
            width: size.width * 0.5,
            child: const TuachuaySearchBox(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10, top: 10),
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    SizedBox(
                      child: getAvatar(context),
                    ),
                    SizedBox(
                      height: 48.5,
                      width: 48.5,
                      child: RawMaterialButton(
                        shape: const CircleBorder(),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, tuachuayDekhorPageRoute["profile"]!);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
