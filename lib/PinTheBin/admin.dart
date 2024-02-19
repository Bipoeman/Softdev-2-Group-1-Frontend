import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/PinTheBin/navbar.dart';
import 'package:ruam_mitt/Restroom/Component/theme.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminState();
}

class _AdminState extends State<AdminPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeProvider themes = Provider.of<ThemeProvider>(context);
    ThemeData pinTheBinTheme = themes.themeFrom("PinTheBin")!.themeData;
    return Theme(
      data: pinTheBinTheme,
      child: Scaffold(
        key: _scaffoldKey,

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Container(
        //       padding: const EdgeInsets.all(5),
        //       width: [300.0, size.width * 0.65].reduce(min),
        //       child: SearchBin(
        //           binData: binData,
        //           searchBarController: searchBarController),
        //     ),
        //   ],
        // ),
        // Positioned(
        //   top: 10,
        //   left: 10,
        //   child: Center(
        //     child: GestureDetector(
        //       onTap: () {
        //         _scaffoldKey.currentState?.openDrawer();
        //       },
        //       child: Container(
        //         width: 40,
        //         height: 40,
        //         decoration: BoxDecoration(
        //           color: const Color(0xFFF77F00),
        //           borderRadius: BorderRadius.circular(15),
        //         ),
        //         child: const Icon(Icons.menu),
        //       ),
        //     ),
        //   ),
        // ),

        drawerScrimColor: Colors.transparent,
        drawer: const NavBar(),
      ),
    );
  }
}
