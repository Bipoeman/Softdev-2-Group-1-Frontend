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
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // เมื่อเลือกรายการเมนู
                // ปิดเมนูสไลด์
                Navigator.pushNamed(context, restroomPageRoute["review"]!);
                // สามารถเพิ่มโค้ดเมนูเมื่อเลือกรายการได้ที่นี่
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // เมื่อเลือกรายการเมนู
                // ปิดเมนูสไลด์
                Navigator.pop(context);
                // สามารถเพิ่มโค้ดเมนูเมื่อเลือกรายการได้ที่นี่
              },
            ),
          ],
        ),
      );
      
    
  }
}