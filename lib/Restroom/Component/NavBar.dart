import 'package:flutter/material.dart';
import 'package:ruam_mitt/global_const.dart';
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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFFFB703),
            ),
            accountName: Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Kasidit sud smart',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              radius: 30, // กำหนดรัศมีของวงกลม
              backgroundImage:
                  AssetImage("assets/images/RestroomRover/Kasidit.jpeg"),
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
              child: Image.asset(
                "assets/images/RestroomRover/Icon_pinnoback.png",
              ),
            ),
            title: Text('Pin restroom'),
            onTap: () {
              Navigator.pushNamed(context, restroomPageRoute["findposition"]!);
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
              child: Icon(Icons.edit_location_alt_sharp, color: Colors.black, size: 30,),
            ),
            title: Text('Edit pin'),
            onTap: () {
              // เมื่อเลือกรายการเมนู
              // ปิดเมนูสไลด์
              // Navigator.pushNamed(context, restroomPageRoute["review"]!);
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
              child: Icon(
                Icons.report,
                color: Colors.black,
                size: 30.0,
              )
            ),
            title: Text('Report'),
            onTap: () {
              // เมื่อเลือกรายการเมนู
              // ปิดเมนูสไลด์
              // Navigator.pushNamed(context, restroomPageRoute["review"]!);
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
              )
            ),
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
  }
}
