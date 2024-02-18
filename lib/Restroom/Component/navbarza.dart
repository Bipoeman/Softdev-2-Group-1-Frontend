import 'package:flutter/material.dart';
import 'package:ruam_mitt/Restroom/Component/search_box.dart';
import 'package:ruam_mitt/global_const.dart';

class Navbar2RestroomRover extends StatelessWidget {
  const Navbar2RestroomRover({
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
          // AppBar(
          //   backgroundColor: Color(0xFFFFB703),
          //   automaticallyImplyLeading: false, // ไม่แสดงปุ่ม "back" อัตโนมัติ
          //   actions: [
          //     IconButton(
          //       icon: Icon(Icons.arrow_back),
          //       onPressed: () {
          //         Navigator.pop(context);
          //       },
          //     ),
          //   ],
          // ),
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFFFB703),
            ),
            accountName: Text(
              'Kasidit sud smart',
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text('lilpakinwza007_69@gmail.com',
                style: TextStyle(color: Colors.black)),
            currentAccountPicture: CircleAvatar(
              radius: 30, // กำหนดรัศมีของวงกลม
              backgroundImage:
                  AssetImage("assets/images/RestroomRover/Kasidit.jpeg"),
            ),
            // actions: [
            //   IconButton(
            //     icon: Icon(Icons.close),
            //     onPressed: () {
            //       Navigator.pop(context);
            //     },
            //   ),
            // ],
          ),
          // DrawerHeader(
          //   decoration: BoxDecoration(
          //     color: Color(0xFFFFB703),
          //   ),
          //   child: Text('Drawer Header'),
          // ),
          // DrawerHeader(
          //   decoration: BoxDecoration(
          //     color: Color(0xFFFFB703),
          //   ),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text(
          //               'Kasidit sud smart',
          //               style: TextStyle(color: Colors.black),
          //             ),
          //             Text(
          //               'lilpakinwza007_69@gmail.com',
          //               style: TextStyle(color: Colors.black),
          //             ),
          //           ],
          //         ),
          //       ),
          //       IconButton(
          //         icon: Icon(Icons.arrow_back),
          //         onPressed: () {
          //           Navigator.pop(context);
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          // ListTile(
          //   contentPadding: EdgeInsets.zero,
          //   tileColor: Color(0xFFFFB703),
          //   leading: CircleAvatar(
          //     radius: 30,
          //     backgroundImage:
          //         AssetImage("assets/images/RestroomRover/Kasidit.jpeg"),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Text(
          //           'Kasidit sud smart',
          //           style: TextStyle(color: Colors.black),
          //         ),
          //         Text(
          //           'lilpakinwza007_69@gmail.com',
          //           style: TextStyle(color: Colors.black),
          //         ),
          //       ],
          //     ),
          //   ),
          //   trailing: IconButton(
          //     icon: Icon(Icons.arrow_back),
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //   ),
          // ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 50.0, top: 20.0),
            leading: Image.asset(
              "assets/images/RestroomRover/Icon_pintrestroom.png",
              width: 50,
              height: 50,
            ),
            title: Text('Pin Restroom'),
            onTap: () {
              // เมื่อเลือกรายการเมนู
              // ปิดเมนูสไลด์
              // Navigator.pushNamed(context, restroomPageRoute["review"]!);
              // สามารถเพิ่มโค้ดเมนูเมื่อเลือกรายการได้ที่นี่
            },
          ),
          SizedBox(height: 20),
          ListTile(
            contentPadding: EdgeInsets.only(left: 50.0, top: 20.0),
            leading: Image.asset(
                "assets/images/RestroomRover/Icon_contactsupport.png",
                width: 50,
                height: 50),
            title: Text('Contact support'),
            onTap: () {
              // เมื่อเลือกรายการเมนู
              // ปิดเมนูสไลด์
              Navigator.pop(context);
              // สามารถเพิ่มโค้ดเมนูเมื่อเลือกรายการได้ที่นี่
            },
          ),
          // ListTile(
          //   contentPadding: EdgeInsets.only(left: 50.0, top: 20.0),
          //   leading: Icon(Icons.arrow_back),
          //   title: Text('Back'),
          //   onTap: () {
          //     // ปิดเมนูสไลด์เมื่อกดปุ่มย้อนกลับ
          //     Navigator.pop(context);
          //   },
          // ),
        ],
      ),
    );
  }
}
