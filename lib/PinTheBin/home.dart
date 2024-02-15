import "package:flutter/material.dart";
import "package:ruam_mitt/PinTheBin/navbar.dart";

class BinPage extends StatefulWidget {
  const BinPage({super.key});

  @override
  State<BinPage> createState() => _BinPageState();
}

class _BinPageState extends State<BinPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState
                        ?.openDrawer(); // เปิด Drawer เมื่อปุ่มถูกกด
                  },
                  child: Container(
                    width: 40, // ขนาดของปุ่ม
                    height: 40, // ขนาดของปุ่ม
                    decoration: BoxDecoration(
                      color: const Color(0xFFF77F00), // สี F77F00
                      borderRadius: BorderRadius.circular(15), // มุมโค้ง 23
                    ),
                    child: const Icon(Icons.menu), // ใช้ไอคอน Hamburger ในปุ่ม
                  ), // ใช้ไอคอน Hamburger ในปุ่ม
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const NavBar(),
    );
  }
}
