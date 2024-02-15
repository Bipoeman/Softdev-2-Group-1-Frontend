import 'package:flutter/material.dart';
import 'package:ruam_mitt/Restroom/Component/search_box.dart';
import 'package:ruam_mitt/global_const.dart';

class NavbarRestroomRover extends StatelessWidget {
  const NavbarRestroomRover({
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
    return Scaffold(
      backgroundColor: Colors.transparent.withOpacity(0.0) ,
      drawer: Drawer(
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
                Navigator.pop(context);
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
      ),
      body : Container(
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
                      Scaffold.of(context).openDrawer();
                    },
                    child: const Image(
                      image: AssetImage(
                          "assets/images/RestroomRover/Pinred.png"),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              height: 56,
              width: size.width * 0.5,
              child: const RestroomSearchBox(),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Container(
            //       margin: const EdgeInsets.only(right: 10, top: 10),
            //       alignment: Alignment.topCenter,
            //       child: Stack(
            //         children: [
            //           SizedBox(
            //             child: getAvatar(context),
            //           ),
            //           SizedBox(
            //             height: 48.5,
            //             width: 48.5,
            //             child: RawMaterialButton(
            //               shape: const CircleBorder(),
            //               onPressed: () {
            //                 showMenu(
            //                   context: context,
            //                   surfaceTintColor: Colors.white,
            //                   position:
            //                       RelativeRect.fromLTRB(size.width, 102, 0, 0),
            //                   items: [
            //                     PopupMenuItem(
            //                       child: const Row(
            //                         children: [
            //                           Icon(Icons.people),
            //                           SizedBox(width: 10),
            //                           Text("Profile"),
            //                         ],
            //                       ),
            //                       onTap: () {
            //                         Navigator.pushNamed(
            //                             context, ruamMitrPageRoute["profile"]!);
            //                       },
            //                     ),
            //                     PopupMenuItem(
            //                       child: const Row(
            //                         children: [
            //                           Icon(Icons.logout),
            //                           SizedBox(width: 10),
            //                           Text("RuamMitr"),
            //                         ],
            //                       ),
            //                       onTap: () {
            //                         Navigator.pushNamed(
            //                             context, ruamMitrPageRoute["home"]!);
            //                       },
            //                     ),
            //                   ],
            //                 );
            //               },
            //             ),
            //           ),
            //         ],
            //       ),
            //     )
            //   ],
            // ),
          ],
        ),
      )
    );
  }
}