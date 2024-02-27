import "package:flutter/material.dart";
import "package:ruam_mitt/PinTheBin/bin_drawer.dart";
import "package:ruam_mitt/PinTheBin/pin_the_bin_theme.dart";

class ReportPage extends StatefulWidget {
  // ReportPage({required this.data, Key? key}) : super(key: key);
  const ReportPage({super.key});

  // late Map<String, dynamic> data;

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic>? _useData;

  @override
  void initState() {
    super.initState();
    // _useData = widget.data;
  }

  TextStyle textStyle(context, color) {
    return TextStyle(
        fontFamily: context.contains(
          RegExp("[ก-๛]"),
        )
            ? "THSarabunPSK"
            : Theme.of(context).textTheme.labelMedium!.fontFamily,
        fontSize: context.contains(
          RegExp("[ก-๛]"),
        )
            ? 24
            : 16,
        fontWeight: context.contains(
          RegExp("[ก-๛]"),
        )
            ? FontWeight.w700
            : FontWeight.normal,
        color: color);
  }

  @override
  Widget build(BuildContext context) {
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
                              context, Color.fromRGBO(0, 30, 49, 67))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      child: Container(
                        padding: EdgeInsets.only(left: size.width * 0.02),
                        height: size.height * 0.03,
                        width: size.width * 0.6,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                            ),
                            BoxShadow(
                              color: Color(0xFFEBEBEB),
                              offset: const Offset(0, 4),
                              spreadRadius: 0,
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                        child: Text(
                          _useData!["location"],
                          style: textStyle(
                            context,
                            Color.fromRGBO(0, 30, 49, 67),
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
                        style:
                            textStyle(context, Color.fromRGBO(0, 30, 49, 0.67)),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.01, right: size.width * 0.1),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        width: size.width * 0.6,
                        height: size.height * 0.03,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                            ),
                            BoxShadow(
                              color: Color(0xFFEBEBEB),
                              offset: const Offset(0, 4),
                              spreadRadius: 0,
                              blurRadius: 4.0,
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(left: size.width * 0.02),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Latitude : ",
                            style: textStyle(
                                context, Color.fromRGBO(0, 30, 49, 0.67)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.01),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        width: size.width * 0.6,
                        height: size.height * 0.03,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                            ),
                            BoxShadow(
                              color: Color(0xFFEBEBEB),
                              offset: const Offset(0, 4),
                              spreadRadius: 0,
                              blurRadius: 4.0,
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(left: size.width * 0.02),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Longitude : ",
                            style: textStyle(
                                context, Color.fromRGBO(0, 30, 49, 0.67)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.02),
                      ),
                      Container(
                        width: size.width * 0.7,
                        height: size.height * 0.15,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEBEBEB),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        // child: data["picture"] == null
                        // ? Image.asset(
                        //     "assets/images/PinTheBin/bin_null.png",
                        //     width: size.width * 0.4,
                        //     height: size.width * 0.4,
                        //   )
                        // : Image.network(
                        //     data["picture"],
                        //     width: size.width * 0.4,
                        //     height: size.width * 0.4,
                        // ),
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
