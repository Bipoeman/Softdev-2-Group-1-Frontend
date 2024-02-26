import "package:flutter/material.dart";
import "package:ruam_mitt/PinTheBin/bin_drawer.dart";
import "package:ruam_mitt/PinTheBin/pin_the_bin_theme.dart";

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Theme(
      data: pinTheBinThemeData,
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xFFF9957F),
                  Color(0xFFE69FA1),
                  Color(0xFFF3F6D1),
                ],
              ),
            ),
          ),
          ReportAppBar(scaffoldKey: _scaffoldKey),
        ]),
        drawerScrimColor: Colors.transparent,
        drawer: const BinDrawer(),
      ),
    );
  }
}

class ReportAppBar extends StatelessWidget {
  const ReportAppBar({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFFF99680),
            Color(0xFFF8A88F),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              GestureDetector(
                child: Icon(
                  Icons.menu_rounded,
                  size: Theme.of(context).appBarTheme.iconTheme!.size,
                  color: Theme.of(context).appBarTheme.iconTheme!.color,
                ),
                onTap: () {
                  debugPrint("Open Drawer");
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              const SizedBox(width: 10),
              Text(
                "REPORT",
                style: TextStyle(
                  fontSize:
                      Theme.of(context).textTheme.headlineMedium!.fontSize,
                  fontWeight:
                      Theme.of(context).textTheme.headlineMedium!.fontWeight,
                  color: Theme.of(context).textTheme.headlineMedium!.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
