import 'package:clay_containers/widgets/clay_container.dart';
import "package:flutter/material.dart" hide BoxDecoration, BoxShadow;
import 'package:ruam_mitt/PinTheBin/pin_the_bin_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ruam_mitt/PinTheBin/bin_drawer.dart';
import 'package:neumorphic_button/neumorphic_button.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:latlong2/latlong.dart';
import 'package:ruam_mitt/PinTheBin/map_add_bin.dart';

class AddbinPageV2 extends StatefulWidget {
  const AddbinPageV2({super.key});

  @override
  State<AddbinPageV2> createState() => _AddbinPageV2State();
}

class _AddbinPageV2State extends State<AddbinPageV2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _NametextController = TextEditingController();
  final backgroundColor = const Color(0xFFFFFFFF);
  bool isPressed = true;

  LatLng? _position;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Offset distance = isPressed
        ? Offset(5, 5)
        : Offset(size.width * 0.008, size.height * 0.005);
    double blur = isPressed ? 5.0 : 5;

    return Theme(
      data: ThemeData(
        fontFamily: "Sen",
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF9957F),
          background: const Color(0xFFFFFFFF),
        ),
        textTheme: TextTheme(
          headlineMedium: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          headlineSmall: TextStyle(
            fontSize: 30,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF003049),
            shadows: [
              Shadow(
                blurRadius: 20,
                offset: const Offset(0, 3),
                color: const Color(0xFF003049).withOpacity(0.3),
              ),
            ],
          ),
          displayMedium: TextStyle(
            fontSize: 20,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF003049).withOpacity(0.67),
          ),
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white,
            size: 35,
          ),
        ),
        drawerTheme: const DrawerThemeData(
          scrimColor: Colors.transparent,
          backgroundColor: Color(0xFFF9957F),
        ),
      ),
      child: Builder(
        builder: (context) {
          return Stack(
            children: [
              Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  leading: GestureDetector(
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.menu_rounded),
                        SizedBox(height: 15)
                      ],
                    ),
                    onTap: () => _scaffoldKey.currentState?.openDrawer(),
                  ),
                  toolbarHeight: 120,
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Color(0xFFF99680),
                          Color(0xFFF8A88F),
                        ],
                      ),
                    ),
                  ),
                  title: Column(
                    children: [
                      Text(
                        "ADD BIN",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
                body: SafeArea(
                    child: Stack(
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Text(
                                'Name',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: size.height * 0.035),
                          child: ClayContainer(
                            width: size.width * 0.65,
                            height: size.height * 0.032,
                            color: Color.fromRGBO(239, 239, 239, 1),
                            borderRadius: 30,
                            depth: -20,
                            child: TextField(
                              controller: _NametextController,
                              onChanged: (text) {
                                print('Typed text: $text');
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 76),
                              child: Text(
                                'Position',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                setState(() => isPressed = !isPressed);
                                LatLng getPosResult = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MapaddBinPage()),
                                );
                                print("Result $getPosResult");
                                setState(() {
                                  _position = getPosResult;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 100),
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 30),
                                width: size.width * 0.165,
                                height: size.height * 0.038,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: blur,
                                      offset: distance,
                                      color: Color(0xFFA7A9AF),
                                      inset: isPressed,
                                    ),
                                    BoxShadow(
                                      blurRadius: blur,
                                      offset: -distance,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      inset: isPressed,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'select',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.05,
                            ),
                            Column(
                              children: [
                                ClayContainer(
                                  width: size.width * 0.6,
                                  height: size.height * 0.032,
                                  color: Color.fromRGBO(239, 239, 239, 1),
                                  borderRadius: 30,
                                  depth: -20,
                                  child: Text(
                                    'Lat: ${_position?.latitude ?? ()}',
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                ClayContainer(
                                  width: size.width * 0.6,
                                  height: size.height * 0.032,
                                  color: Color.fromRGBO(239, 239, 239, 1),
                                  borderRadius: 30,
                                  depth: -20,
                                  child: Text(
                                    'Lng: ${_position?.longitude ?? ()}',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.265),
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 30),
                        width: size.width * 0.84,
                        height: size.height * 0.1,
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
                            Container(
                              padding:
                                  EdgeInsets.only(right: size.width * 0.77),
                              child: Container(
                                margin:
                                    EdgeInsets.only(bottom: size.height * 0.05),
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
                            Container(
                              padding: EdgeInsets.only(left: size.width * 0.77),
                              child: Container(
                                margin:
                                    EdgeInsets.only(bottom: size.height * 0.05),
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
                            Container(
                              padding: EdgeInsets.only(
                                  right: size.width * 0.77,
                                  top: size.height * 0.05),

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
                                // decoration: BoxDecoration(
                                //     border: Border.all(
                                //         color: Colors.black, width: 10)),
                              ),
                              //),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: size.width * 0.77),
                              child: Container(
                                margin:
                                    EdgeInsets.only(top: size.height * 0.05),
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
                              padding: EdgeInsets.only(
                                  top: size.height * 0.055,
                                  left: size.width * 0.23),
                              child: Opacity(
                                opacity: 0.4,
                                child: Text(
                                  "Upload picture",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                            )
                            // itemSelection(title: 'upload', image: Image.asset("assets/images/PinTheBin/upload.png"), onTap: , context: context)
                          ],
                        ),
                      ),
                    ),
                    Column(),
                  ],
                )),
                drawerScrimColor: Colors.transparent,
                drawer: const BinDrawer(),
              )
            ],
          );
        },
      ),
    );
  }
}