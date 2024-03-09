import 'dart:convert';
import 'dart:io';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:clay_containers/widgets/clay_text.dart';
import "package:flutter/material.dart" hide BoxDecoration, BoxShadow;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mime/mime.dart';
import 'package:ruam_mitt/PinTheBin/bin_drawer.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:latlong2/latlong.dart';
import 'package:ruam_mitt/PinTheBin/componant/loading.dart';
import 'package:ruam_mitt/PinTheBin/map_add_bin.dart';
import 'package:http/http.dart' as http;
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_func.dart';
import "package:ruam_mitt/global_var.dart";

class AddbinPageV2 extends StatefulWidget {
  const AddbinPageV2({super.key});

  @override
  State<AddbinPageV2> createState() => _AddbinPageV2State();
}

class _AddbinPageV2State extends State<AddbinPageV2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _NametextController = TextEditingController();
  final TextEditingController _DescriptiontextController =
      TextEditingController();
  final backgroundColor = const Color(0xFFFFFFFF);
  //final url = Uri.parse("$api");
  bool isPressed = true;
  bool isPressedWarning = false;
  bool isPressedRecycling = false;
  bool isPressedWaste = false;
  bool isPressedGeneral = false;
  LatLng? _position;
  File? _image;

  Future<void> _getImage() async {
    bool? isCamera = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Camera"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("gallery "),
            ),
          ],
        ),
      ),
    );

    if (isCamera == null) return;
    final pickedFile = await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Future<void> _addPin() async {
    await requestNewToken(context);
    debugPrint("Sending data");
    final url = Uri.parse("$api$pinTheBinaddbinRoute");
    var response = await http
        .post(url, headers: {
          "Authorization": "Bearer $publicToken",
        }, body: {
          "location": _NametextController.text,
          "description": _DescriptiontextController.text,
          "bintype": jsonEncode(_bintype),
          "latitude": _position!.latitude.toString(),
          "longitude": _position!.longitude.toString(),
        })
        .timeout(const Duration(seconds: 10))
        .onError((error, stackTrace) {
          return Future.error(error ?? {}, stackTrace);
        });

    debugPrint("Response: ${response.body}");
    if (response.statusCode != 200) {
      return Future.error(response.reasonPhrase ?? "Failed to add bin.");
    }
    int id = jsonDecode(response.body)[0]['id'];
    print("ID: $id");
    if (_image != null) {
      await _sendpic(id.toString(), _image).onError((error, stackTrace) async {
        await _delPin(id);
        return Future.error(error ?? {}, stackTrace);
      });
    }
  }

  Future<http.Response> _delPin(int id) async {
    await requestNewToken(context);
    Uri url = Uri.parse("$api$pinTheBinDeleteBinRoute/$id");
    http.Response res = await http.delete(url, headers: {
      "Authorization": "Bearer $publicToken"
    }).timeout(const Duration(seconds: 10));
    debugPrint(res.body);
    if (res.statusCode != 200) {
      return Future.error(res.reasonPhrase ?? "Failed to delete bin");
    }
    return res;
  }

  Future<http.Response> _sendpic(id, picture) async {
    debugPrint("Updating picture");
    final url = Uri.parse("$api$pinTheBinAddpicRoute");
    http.MultipartRequest request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      "Authorization": "Bearer $publicToken",
      "Content-Type": "application/json"
    });
    request.files.add(
      http.MultipartFile.fromBytes(
        "file",
        File(picture.path).readAsBytesSync(),
        filename: picture.path,
        contentType:
            MediaType.parse(lookupMimeType(picture.path) ?? "image/jpeg"),
      ),
    );
    request.fields['id'] = id;
    try {
      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) {
        return Future.error(response.reasonPhrase ?? "Failed to send report");
      }
      http.Response res = await http.Response.fromStream(response)
          .timeout(const Duration(seconds: 10));
      return res;
    } catch (e) {
      return Future.error(e);
    }
  }

  final Map<String, bool> _bintype = {
    'redbin': false,
    'greenbin': false,
    'yellowbin': false,
    'bluebin': false
  };

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
        ? const Offset(5, 5)
        : Offset(size.width * 0.008, size.height * 0.005);
    double blur = isPressed ? 5.0 : 5;

    Offset distanceWarning = isPressedWarning
        ? const Offset(5, 5)
        : Offset(size.width * 0.008, size.height * 0.005);
    double blurWarning = isPressedWarning ? 5.0 : 5;

    Offset distanceRecycling = isPressedRecycling
        ? const Offset(5, 5)
        : Offset(size.width * 0.008, size.height * 0.005);
    double blurRecycling = isPressedRecycling ? 5.0 : 5;

    Offset distanceWaste = isPressedWaste
        ? const Offset(5, 5)
        : Offset(size.width * 0.008, size.height * 0.005);
    double blurWaste = isPressedWaste ? 5.0 : 5;

    Offset distanceGeneral = isPressedGeneral
        ? const Offset(5, 5)
        : Offset(size.width * 0.008, size.height * 0.005);
    double blurGeneral = isPressedGeneral ? 5.0 : 5;
    return Theme(
      data: ThemeData(
        fontFamily: "Kodchasan",
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
          displaySmall: TextStyle(
            fontSize: 13.5,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF003049).withOpacity(0.45),
          ),
          displayLarge: const TextStyle(
            fontSize: 20,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.w300,
            color: Color.fromARGB(255, 255, 255, 255),
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
                  toolbarHeight: 90,
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
                      Stack(
                        children: [
                          ClayContainer(
                              width: size.width * 0.7,
                              height: size.height * 0.08,
                              borderRadius: 30,
                              depth: -20,
                              color: Color(0xFFF99680),
                              surfaceColor: Color.fromARGB(116, 109, 68, 58),
                              // surfaceColor: Color.fromARGB(147, 249, 150, 128),
                              // surfaceColor:
                              //     const Color.fromARGB(255, 138, 112, 112),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: size.height * 0.005,
                                    left: size.width * 0.155),
                                child: ClayText(
                                  'ADD BIN',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,

                                  emboss: true,
                                  //size: 20,
                                  color: Color(0xFFF8A88F),
                                  textColor: Color(0xFF003049),
                                  //color: Color.fromARGB(255, 234, 134, 41),
                                  depth: -100,
                                  //spread: 5,
                                ),
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                                top: size.height * 0.055,
                                left: size.width * 0.18),
                            child: Container(
                              //color: Color(0xFFF99680),
                              child: ClayText(
                                'P  I  N  T  H  E  B  I  N',
                                style: Theme.of(context).textTheme.displaySmall,
                                color: Color(0xFF003049),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Text(
                      //   "ADD BIN",
                      //   style: Theme.of(context).textTheme.headlineMedium,
                      // ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                    child: Stack(
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: const EdgeInsets.only(left: 20),
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
                            color: const Color.fromRGBO(239, 239, 239, 1),
                            borderRadius: 30,
                            depth: -20,
                            child: TextField(
                              controller: _NametextController,
                              maxLines: 1,
                              onChanged: (text) {
                                print('Typed text: $text');
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 1),
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
                            padding: const EdgeInsets.only(left: 20),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 67),
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
                                margin: const EdgeInsets.only(left: 30),
                                width: size.width * 0.165,
                                height: size.height * 0.038,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: blur,
                                      offset: distance,
                                      color: const Color(0xFFA7A9AF),
                                      inset: isPressed,
                                    ),
                                    BoxShadow(
                                      blurRadius: blur,
                                      offset: -distance,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
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
                                  color: const Color.fromRGBO(239, 239, 239, 1),
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
                                  color: const Color.fromRGBO(239, 239, 239, 1),
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
                        padding: EdgeInsets.only(top: size.height * 0.25),
                        child: InkWell(
                          onTap: () {
                            _getImage();
                          },
                          child: _image == null
                              ? Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(left: 30),
                                  width: size.width * 0.84,
                                  height: size.height * 0.1,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        const Color(0xFF292643)
                                            .withOpacity(0.46),
                                        const Color(0xFFF9A58D)
                                            .withOpacity(0.72),
                                      ],
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            right: size.width * 0.77),
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              bottom: size.height * 0.05),
                                          alignment: Alignment.topLeft,
                                          width: size.width * 0.035,
                                          height: size.height * 0.035,
                                          child: Opacity(
                                            opacity: 0.5,
                                            child: Image.asset(
                                                "assets/images/PinTheBin/corner.png"),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.77),
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              bottom: size.height * 0.05),
                                          alignment: Alignment.topLeft,
                                          width: size.width * 0.035,
                                          height: size.height * 0.035,
                                          child: Transform.rotate(
                                            angle: 90 * 3.141592653589793 / 180,
                                            child: Opacity(
                                              opacity: 0.5,
                                              child: Image.asset(
                                                  "assets/images/PinTheBin/corner.png"),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            right: size.width * 0.77,
                                            top: size.height * 0.05),

                                        child: Container(
                                          alignment: Alignment.bottomLeft,
                                          width: size.width * 0.035,
                                          height: size.height * 0.035,
                                          child: Transform.rotate(
                                            angle:
                                                270 * 3.141592653589793 / 180,
                                            child: Opacity(
                                              opacity: 0.5,
                                              child: Image.asset(
                                                  "assets/images/PinTheBin/corner.png"),
                                            ),
                                          ),
                                          // decoration: BoxDecoration(
                                          //     border: Border.all(
                                          //         color: Colors.black, width: 10)),
                                        ),
                                        //),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.77),
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: size.height * 0.05),
                                          alignment: Alignment.bottomLeft,
                                          width: size.width * 0.035,
                                          height: size.height * 0.035,
                                          child: Transform.rotate(
                                            angle:
                                                180 * 3.141592653589793 / 180,
                                            child: Opacity(
                                              opacity: 0.5,
                                              child: Image.asset(
                                                  "assets/images/PinTheBin/corner.png"),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.06,
                                            left: size.width * 0.23),
                                        child: Opacity(
                                          opacity: 0.4,
                                          child: Text(
                                            "Upload picture",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: size.height * 0.003,
                                          left: size.width * 0.35,
                                        ),
                                        child: Image.asset(
                                          "assets/images/PinTheBin/upload.png",
                                          height: size.height * 0.07,
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 0.67),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  width: size.width * 0.7,
                                  height: size.height * 0.125,
                                  child: Image.file(
                                    _image!,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                        )),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 290),
                              child: Text(
                                'Description',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        ClayContainer(
                          width: size.width * 0.8,
                          height: size.height * 0.15,
                          color: const Color.fromRGBO(239, 239, 239, 1),
                          borderRadius: 30,
                          depth: -15,
                          child: TextField(
                            maxLength: 150,
                            maxLines: 5,
                            controller: _DescriptiontextController,
                            onChanged: (text) {
                              print('Typed text: $text, ${text.length}');
                              int remainningCharacters =
                                  150 - _DescriptiontextController.text.length;
                              print(
                                  'Remaining characters: $remainningCharacters');
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.only(top: 13, left: 15, right: 15),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.05,
                                  top: size.height * 0.6),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _bintype['redbin'] = !_bintype['redbin']!;
                                    isPressedWarning = _bintype['redbin']!;
                                  });
                                  print(_bintype['redbin']);
                                },
                                child: Container(
                                  width: size.width * 0.2,
                                  height: size.height * 0.1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color.fromARGB(9, 0, 47, 73),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: blurWarning,
                                        offset: distanceWarning,
                                        color: const Color(0xFFA7A9AF),
                                        inset: isPressedWarning,
                                      ),
                                      BoxShadow(
                                        blurRadius: blurWarning,
                                        offset: -distanceWarning,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        inset: isPressedWarning,
                                      ),
                                    ],
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/images/PinTheBin/warning.png",
                                      width: size.width * 0.1,
                                      height: size.height * 0.1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: size.width * 0.05),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.015),
                                child: Text(
                                  'DANGER',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: size.height * 0.6),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _bintype['yellowbin'] =
                                        !_bintype['yellowbin']!;
                                    isPressedRecycling = _bintype['yellowbin']!;
                                  });
                                  print(_bintype['yellowbin']);
                                },
                                child: Container(
                                  width: size.width * 0.2,
                                  height: size.height * 0.1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color.fromARGB(9, 0, 47, 73),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: blurRecycling,
                                        offset: distanceRecycling,
                                        color: const Color(0xFFA7A9AF),
                                        inset: isPressedRecycling,
                                      ),
                                      BoxShadow(
                                        blurRadius: blurRecycling,
                                        offset: -distanceRecycling,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        inset: isPressedRecycling,
                                      ),
                                    ],
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/images/PinTheBin/recycling.png",
                                      width: size.width * 0.1,
                                      height: size.height * 0.1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: size.height * 0.015),
                              child: Text(
                                'RECYCLE',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: size.height * 0.6),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _bintype['greenbin'] =
                                        !_bintype['greenbin']!;
                                    isPressedWaste = _bintype['greenbin']!;
                                  });
                                  print(_bintype['greenbin']);
                                },
                                child: Container(
                                  width: size.width * 0.2,
                                  height: size.height * 0.1,
                                  //color: Colors.black,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color.fromARGB(9, 0, 47, 73),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: blurWaste,
                                        offset: distanceWaste,
                                        color: const Color(0xFFA7A9AF),
                                        inset: isPressedWaste,
                                      ),
                                      BoxShadow(
                                        blurRadius: blurWaste,
                                        offset: -distanceWaste,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        inset: isPressedWaste,
                                      ),
                                    ],
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/images/PinTheBin/compost.png",
                                      width: size.width * 0.1,
                                      height: size.height * 0.1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: size.height * 0.015),
                              child: Text(
                                'WASTE',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: size.height * 0.6),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _bintype['bluebin'] = !_bintype['bluebin']!;
                                    isPressedGeneral = _bintype['bluebin']!;
                                  });
                                  print(_bintype['bluebin']);
                                },
                                child: Container(
                                  width: size.width * 0.2,
                                  height: size.height * 0.1,
                                  //color: Colors.black,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color.fromARGB(9, 0, 47, 73),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: blurGeneral,
                                        offset: distanceGeneral,
                                        color: const Color(0xFFA7A9AF),
                                        inset: isPressedGeneral,
                                      ),
                                      BoxShadow(
                                        blurRadius: blurGeneral,
                                        offset: -distanceGeneral,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        inset: isPressedGeneral,
                                      ),
                                    ],
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/images/PinTheBin/bin.png",
                                      width: size.width * 0.1,
                                      height: size.height * 0.1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: size.height * 0.015),
                              child: Text(
                                'GENERAL',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.175,
                              top: size.height * 0.76),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Add bin Confirm',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      content: const Text(
                                          'Would you like to confirm to add a trash bin at this location?'),
                                      actions: [
                                        MaterialButton(
                                          onPressed: () {
                                            if (_position == null ||
                                                _NametextController
                                                    .text.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "Please pin the position and fill in the name.",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                              Navigator.of(context).pop(false);
                                            } else {
                                              Navigator.pop(context, true);
                                            }
                                          },
                                          child: const Text('Confirm'),
                                        ),
                                        MaterialButton(
                                          color: Colors.red,
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: size.height * 0.007,
                                                left: size.width * 0.02),
                                            width: size.width * 0.2,
                                            height: size.height * 0.05,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    0, 244, 67, 54),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Text(
                                              'cancel',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).then((confirm) => {
                                    if (confirm)
                                      {
                                        showLoadingScreen(context),
                                        _addPin().then((_) {
                                          print("Completed");
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                "Pin created",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              backgroundColor:
                                                  Colors.green[300],
                                            ),
                                          );

                                          Navigator.pushReplacementNamed(
                                              context,
                                              pinthebinPageRoute["home"]!);
                                        }).onError((error, stackTrace) {
                                          debugPrint("Error: $error");
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Failed to create pin",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        })
                                      }
                                  });
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.07,
                                  top: size.height * 0.01),
                              width: size.width * 0.25,
                              height: size.height * 0.055,
                              decoration: BoxDecoration(
                                color: const Color(0xFF547485),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 5,
                                    //offset: ,
                                    color: Color(0xFFA7A9AF),
                                  ),
                                ],
                              ),
                              child: Text(
                                'ADD',
                                style: GoogleFonts.getFont(
                                  "Sen",
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.17,
                              top: size.height * 0.755),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, pinthebinPageRoute['home']!);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: size.width * 0.25,
                              height: size.height * 0.055,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF9957F),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 5,
                                    //offset: ,
                                    color: Color(0xFFA7A9AF),
                                  ),
                                ],
                              ),
                              child: Text(
                                'CANCEL',
                                style: GoogleFonts.getFont(
                                  "Sen",
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
