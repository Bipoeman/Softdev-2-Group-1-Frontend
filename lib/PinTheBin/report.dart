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

  TextEditingController _ReporttextController = TextEditingController();
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
        body: SingleChildScrollView(
          child: Stack(children: [
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.2, left: size.width * 0.1),
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
                    padding: EdgeInsets.only(top: size.height * 0.02),
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.02),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Report",
                            style: textStyle(
                              context,
                              Color.fromRGBO(0, 30, 49, 0.67),
                              "Report",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.01, right: size.width * 0.1),
                          child: ClayContainer(
                            width: size.width * 0.7,
                            height: size.height * 0.15,
                            color: Color(0xFFEBEBEB),
                            borderRadius: 30,
                            depth: -20,
                            child: Padding(
                              padding: EdgeInsets.only(left: size.width * 0.02),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                controller: _ReporttextController,
                                onChanged: (text) {
                                  print('Typed text: $text , ${text.length}');
                                },
                                maxLength: 80,
                                maxLines: 3,
                                style: textStyle(
                                  context,
                                  Color.fromRGBO(0, 30, 49, 0.67),
                                  (_ReporttextController.text),
                                ),
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.02, right: size.width * 0.1),
                    child: InkWell(
                      onTap: () {
                        print("1");
                      },
                      child: Container(
                        width: size.width * 0.7,
                        height: size.height * 0.15,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color(0xFF292643).withOpacity(0.46),
                              Color(0xFFF9A58D).withOpacity(0.72),
                            ],
                          ),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.01,
                                left: size.width * 0.01,
                              ),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Opacity(
                                  opacity: 0.5,
                                  child: Image.asset(
                                      "assets/images/PinTheBin/corner.png"),
                                ),
                                width: size.width * 0.035,
                                height: size.height * 0.035,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.01,
                                left: size.width * 0.65,
                              ),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Transform.rotate(
                                  angle: 90 * 3.141592653589793 / 180,
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: Image.asset(
                                        "assets/images/PinTheBin/corner.png"),
                                  ),
                                ),
                                width: size.width * 0.035,
                                height: size.height * 0.035,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.105,
                                left: size.width * 0.01,
                              ),
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                child: Transform.rotate(
                                  angle: 270 * 3.141592653589793 / 180,
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: Image.asset(
                                        "assets/images/PinTheBin/corner.png"),
                                  ),
                                ),
                                width: size.width * 0.035,
                                height: size.height * 0.035,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.105,
                                left: size.width * 0.65,
                              ),
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                child: Transform.rotate(
                                  angle: 180 * 3.141592653589793 / 180,
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: Image.asset(
                                        "assets/images/PinTheBin/corner.png"),
                                  ),
                                ),
                                width: size.width * 0.035,
                                height: size.height * 0.035,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: size.height * 0.1),
                              child: Container(
                                alignment: Alignment.topCenter,
                                child: Opacity(
                                  opacity: 0.4,
                                  child: Text(
                                    "Upload picture",
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.03,
                                left: size.width * 0.27,
                              ),
                              child: Image.asset(
                                "assets/images/PinTheBin/upload.png",
                                height: size.height * 0.075,
                                color: Color.fromRGBO(255, 255, 255, 0.67),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ReportAppBar(scaffoldKey: _scaffoldKey),
          ]),
        ),
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
