import 'package:flutter/material.dart';
import 'package:ruam_mitt/Restroom/Component/theme.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';

class RestroomRoverNavbar extends StatelessWidget {
  const RestroomRoverNavbar({
    super.key,
    this.username,
    this.avatarUrl,
  });
  final String? username;
  final String? avatarUrl;

  // Widget getAvatar(BuildContext context) {
  //   if (avatarUrl != null) {
  //     try {
  //       return CircleAvatar(
  //         radius: 24,
  //         backgroundImage: NetworkImage(avatarUrl!),
  //       );
  //     } catch (e) {
  //       debugPrint(e.toString());
  //     }
  //   }
  //   return const CircleAvatar(
  //     radius: 24,
  //     backgroundColor: Colors.white,
  //     child: Icon(
  //       Icons.person,
  //       size: 23,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Theme(
      data: RestroomThemeData,
      child: Builder(
        builder: (context) {
          return Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color(0xFFFFB330),
                    Color(0xFFFFCC74),
                  ],
                ),
              ),
              accountName: Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Text(
                    profileData["username"],
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                radius: 30, // กำหนดรัศมีของวงกลม
                backgroundImage: NetworkImage(profileData["imgPath"]),
              ),
            ),
            ListTile(
              leading: Container(
                // ใส่พื้นหลังด้วย Image.asset
                decoration: BoxDecoration(
                  color: Color(0xFFFFB703),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: size.width * 0.1,
                height: size.height * 0.05,
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Icon(
                  Icons.home,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              title: Text('Home',style: Theme.of(context).textTheme.titleMedium,),
              onTap: () {
                // เมื่อเลือกรายการเมนู
                // ปิดเมนูสไลด์
                Navigator.pushNamed(context, restroomPageRoute["home"]!);
                // สามารถเพิ่มโค้ดเมนูเมื่อเลือกรายการได้ที่นี่
              },
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Container(
                // ใส่พื้นหลังด้วย Image.asset
                decoration: BoxDecoration(
                  color: Color(0xFFFFB703),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: size.width * 0.1,
                height: size.height * 0.05,
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Image.asset(
                  "assets/images/RestroomRover/Icon_pinnoback.png",
                ),
              ),
              title: Text('Pin restroom',style: Theme.of(context).textTheme.titleMedium,),
              onTap: () {
                Navigator.pushNamed(context, restroomPageRoute["addrestroom"]!);
              },
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Container(
                // ใส่พื้นหลังด้วย Image.asset
                decoration: BoxDecoration(
                  color: Color(0xFFFFB703),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: size.width * 0.1,
                height: size.height * 0.05,
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Icon(
                  Icons.edit_location_alt_sharp,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              title: Text('Edit pin',style: Theme.of(context).textTheme.titleMedium,),
              onTap: () {
                Navigator.pushNamed(context, restroomPageRoute["myrestroom"]!);
              },
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Container(
                  // ใส่พื้นหลังด้วย Image.asset
                  decoration: BoxDecoration(
                    color: Color(0xFFFFB703),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: size.width * 0.1,
                  height: size.height * 0.05,
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Icon(
                    Icons.report,
                    color: Colors.black,
                    size: 30.0,
                  )),
              title: Text('Report',style: Theme.of(context).textTheme.titleMedium,),
              onTap: () {
                // เมื่อเลือกรายการเมนู
                // ปิดเมนูสไลด์
                Navigator.pushNamed(context, restroomPageRoute["report"]!);
                // สามารถเพิ่มโค้ดเมนูเมื่อเลือกรายการได้ที่นี่
              },
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Container(
                  // ใส่พื้นหลังด้วย Image.asset
                  decoration: BoxDecoration(
                    color: Color(0xFFFFB703),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: size.width * 0.1,
                  height: size.height * 0.05,
                  padding: EdgeInsets.only(left: 2.0, right: 2.0),
                  // child: Image.asset(
                  //   "assets/images/RestroomRover/Icon_pinnoback.png",
                  // ),
                  child: Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                    size: 27.0,
                  )),
              title: Text('Exit'),
              onTap: () {
                // เมื่อเลือกรายการเมนู
                // ปิดเมนูสไลด์
                Navigator.pushNamed(context, ruamMitrPageRoute["home"]!);
                // สามารถเพิ่มโค้ดเมนูเมื่อเลือกรายการได้ที่นี่
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      );
      },)
    );
  }
}
