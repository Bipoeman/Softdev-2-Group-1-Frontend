import "package:flutter/material.dart";
import "package:ruam_mitt/PinTheBin/bin_drawer.dart";
import "package:ruam_mitt/PinTheBin/pin_the_bin_theme.dart";
import 'package:clay_containers/widgets/clay_container.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextStyle textStyle(context, Color color, String data) {
    return TextStyle(
        fontFamily: data.contains(
          RegExp("[ก-๛]"),
        )
            ? "THSarabunPSK"
            : Theme.of(context).textTheme.labelMedium!.fontFamily,
        fontSize: data.contains(
          RegExp("[ก-๛]"),
        )
            ? 22
            : 16,
        fontWeight: data.contains(
          RegExp("[ก-๛]"),
        )
            ? FontWeight.w700
            : FontWeight.normal,
        color: color);
  }

  @override
  Widget build(BuildContext context) {
    final data = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    Size size = MediaQuery.of(context).size;

    return Theme(
      data: pinTheBinThemeData,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Stack(children: [
          Padding(
            padding:
                EdgeInsets.only(top: size.height * 0.2, left: size.width * 0.1),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: size.height * 0.03,
                      alignment: Alignment.bottomLeft,
                      child: Text("Name",
                          style: textStyle(
                            context,
                            Color.fromRGBO(0, 30, 49, 67),
                            "Name",
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      // child: Container(
                      //   padding: EdgeInsets.only(left: size.width * 0.02),
                      //   height: size.height * 0.03,
                      //   width: size.width * 0.6,
                      //   decoration: const BoxDecoration(
                      //     borderRadius: BorderRadius.all(Radius.circular(15)),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Color.fromRGBO(0, 0, 0, 0.25),
                      //       ),
                      //       BoxShadow(
                      //         color: Color(0xFFEBEBEB),
                      //         offset: const Offset(0, 4),
                      //         spreadRadius: 0,
                      //         blurRadius: 4.0,
                      //       ),
                      //     ],
                      //   ),
                      child: ClayContainer(
                        height: size.height * 0.03,
                        width: size.width * 0.6,
                        color: Color.fromRGBO(239, 239, 239, 1),
                        borderRadius: 30,
                        depth: -20,
                        child: Padding(
                          padding: EdgeInsets.only(left: size.width * 0.02),
                          child: Text(
                            data['Bininfo']["location"],
                            style: textStyle(
                              context,
                              Color.fromRGBO(0, 30, 49, 67),
                              data['Bininfo']['location'],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.04),
                  child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Position",
                        style: textStyle(
                          context,
                          Color.fromRGBO(0, 30, 49, 0.67),
                          "Position",
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.01, right: size.width * 0.1),
                  child: Column(
                    children: [
                      ClayContainer(
                        width: size.width * 0.6,
                        height: size.height * 0.03,
                        color: Color(0xFFEBEBEB),
                        borderRadius: 30,
                        depth: -20,
                        child: Padding(
                          padding: EdgeInsets.only(left: size.width * 0.02),
                          child: Text(
                            "Latitude : ${data['Bininfo']['latitude']}",
                            style: textStyle(
                              context,
                              Color.fromRGBO(0, 30, 49, 0.67),
                              ("Latitude"),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.01),
                      ),
                      ClayContainer(
                        width: size.width * 0.6,
                        height: size.height * 0.03,
                        color: Color(0xFFEBEBEB),
                        borderRadius: 30,
                        depth: -20,
                        child: Padding(
                          padding: EdgeInsets.only(left: size.width * 0.02),
                          child: Text(
                            "Longitude : ${data['Bininfo']['longitude']}",
                            style: textStyle(
                              context,
                              Color.fromRGBO(0, 30, 49, 0.67),
                              ("Longitude"),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.02),
                      ),
                      Container(
                        width: size.width * 0.7,
                        height: size.height * 0.15,
                        child: data['Bininfo']['picture'] == null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  "assets/images/PinTheBin/bin_null.png",
                                  fit: BoxFit.fill,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  data['Bininfo']['picture'],
                                  fit: BoxFit.fill,
                                ),
                              ),
                      )
                    ],
                  ),
                )
              ],
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
