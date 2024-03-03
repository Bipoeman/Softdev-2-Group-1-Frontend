import 'package:flutter/material.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/search_box.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';

class NavbarTuachuayDekhor extends StatelessWidget {
  const NavbarTuachuayDekhor({
    super.key,
    this.username,
    this.avatarUrl,
  });
  final String? username;
  final String? avatarUrl;

  Widget getAvatar(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.white.withOpacity(0.5),
      backgroundImage: NetworkImage(profileData['imgPath']),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 68.5,
                width: 68.5,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        tuachuayDekhorPageRoute["home"]!,
                        (Route<dynamic> route) => false);
                  },
                  child: const Image(
                    image: AssetImage(
                        "assets/images/Logo/TuachuayDekhor_Light.png"),
                  ),
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
                          showMenu(
                            context: context,
                            surfaceTintColor: Colors.white,
                            position:
                                RelativeRect.fromLTRB(size.width, 102, 0, 0),
                            items: [
                              if (profileData['role'] == "Admin")
                                PopupMenuItem(
                                  child: const Row(
                                    children: [
                                      Icon(Icons.admin_panel_settings),
                                      SizedBox(width: 10),
                                      Text("Admin"),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        tuachuayDekhorPageRoute["admin"]!);
                                  },
                                ),
                              if (profileData['role'] == "User")
                                PopupMenuItem(
                                  child: const Row(
                                    children: [
                                      Icon(Icons.people),
                                      SizedBox(width: 10),
                                      Text("Profile"),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        tuachuayDekhorPageRoute["profile"]!);
                                  },
                                ),
                              PopupMenuItem(
                                child: const Row(
                                  children: [
                                    Icon(Icons.logout),
                                    SizedBox(width: 10),
                                    Text("RuamMitr"),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    ruamMitrPageRoute["home"]!,
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              ),
                            ],
                          );
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
