import "package:flutter/material.dart";
import "package:ruam_mitt/global_const.dart";

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.8),
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                      'path_to_your_image.jpg'), // รูปเราดึงจากbackend
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text(
              'Home',
              style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.85)),
            ),
            onTap: () {
              Navigator.pushNamed(context, pinthebinPageRoute["home"]!);
            },
            trailing: const Icon(Icons.double_arrow,
                color: Color.fromRGBO(255, 255, 255, 0.42)),
          ),
          ListTile(
            title: const Text(
              'Add Bin',
              style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.85)),
            ),
            onTap: () {
              Navigator.pushNamed(context, pinthebinPageRoute["addbin"]!);
            },
            trailing: const Icon(Icons.double_arrow,
                color: Color.fromRGBO(255, 255, 255, 0.42)),
          ),
          ListTile(
            title: const Text(
              'Edit Bin',
              style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.85)),
            ),
            onTap: () {
              Navigator.pushNamed(context, pinthebinPageRoute["editbin"]!);
            },
            trailing: const Icon(Icons.double_arrow,
                color: Color.fromRGBO(255, 255, 255, 0.42)),
          ),
          ListTile(
            title: const Text(
              'Report',
              style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.85)),
            ),
            onTap: () {
              Navigator.pushNamed(context, pinthebinPageRoute["report"]!);
            },
            trailing: const Icon(Icons.double_arrow,
                color: Color.fromRGBO(255, 255, 255, 0.42)),
          ),
        ],
      ),
    );
  }
}
