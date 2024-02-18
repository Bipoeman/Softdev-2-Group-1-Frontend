import "package:flutter/material.dart";
import "package:ruam_mitt/global_const.dart";

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.8),
      child: Stack(
        children: [
          ListView(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      child: Text("Avatar"),
                      // backgroundImage: AssetImage(
                      //     'path_to_your_image.jpg'), // รูปเราดึงจากbackend
                    ),
                  ],
                ),
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                tileColor: const Color(0xFF1E1E1E),
                title: const Text(
                  'Home',
                  style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.85)),
                ),
                onTap: () {
                  Navigator.pushNamed(context, pinthebinPageRoute["home"]!);
                },
                trailing: const Icon(
                  Icons.double_arrow,
                  color: Color.fromRGBO(255, 255, 255, 0.42),
                ),
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                tileColor: const Color(0xFF1E1E1E),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                tileColor: const Color(0xFF1E1E1E),
                title: const Text(
                  'Edit Bin',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.85),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, pinthebinPageRoute["editbin"]!);
                },
                trailing: const Icon(Icons.double_arrow,
                    color: Color.fromRGBO(255, 255, 255, 0.42)),
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                tileColor: const Color(0xFF1E1E1E),
                title: const Text(
                  'Report',
                  style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.85)),
                ),
                onTap: () {
                  Navigator.pushNamed(context, pinthebinPageRoute["report"]!);
                },
                trailing: const Icon(
                  Icons.double_arrow,
                  color: Color.fromRGBO(255, 255, 255, 0.42),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: size.height * 0.05,
            left: size.width * 0.05,
            child: GestureDetector(
              child: Container(
                height: size.height * 0.05,
                width: size.height * 0.05,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                print("Back to Home");
                Navigator.popAndPushNamed(context, ruamMitrPageRoute['home']!);
              },
            ),
          )
        ],
      ),
    );
  }
}
