import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:clay_containers/widgets/clay_container.dart';
import "package:flutter/material.dart" hide BoxDecoration, BoxShadow;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:latlong2/latlong.dart';
import 'package:ruam_mitt/Restroom/Component/font.dart';
import 'package:ruam_mitt/Restroom/Component/navbar.dart';
import 'package:ruam_mitt/Restroom/Component/theme.dart';
import 'package:ruam_mitt/Restroom/findposition.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';

List<String> restroomTypes = ["Free", "Must Paid", "Toilet In Stores"];

class RestroomRoverAddrestroom extends StatefulWidget {
  const RestroomRoverAddrestroom({super.key});

  @override
  State<RestroomRoverAddrestroom> createState() =>
      _RestroomRoverAddrestroomState();
}

class _RestroomRoverAddrestroomState extends State<RestroomRoverAddrestroom> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _addressTextController = TextEditingController();
  final backgroundColor = const Color(0xFFFFFFFF);
  int remainingCharacters = 0;
  int nameTextLength = 0;
  File? _image;
  String _type = restroomTypes.first;
  LatLng? _position;

  final Map<String, bool> _forwho = {
    'Kid': false,
    'Handicapped': false,
  };

  Future<void> _createPin() async {
    ThemeData theme = Theme.of(context);
    debugPrint("Sending data");
    if (_position == null || _nameTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please fill in all the required fields",
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
            ),
          ),
          backgroundColor: theme.colorScheme.primary,
        ),
      );
      return Future.error("Please fill in all the required fields");
    }
    final url = Uri.parse("$api$restroomRoverRestroomRoute");
    var response = await http
        .post(url, headers: {
          "Authorization": "Bearer $publicToken",
        }, body: {
          "name": _nameTextController.text,
          "type": _type,
          "address": _addressTextController.text,
          "for_who": jsonEncode(_forwho),
          "latitude": _position!.latitude.toString(),
          "longitude": _position!.longitude.toString(),
        })
        .timeout(const Duration(seconds: 10))
        .onError((error, stackTrace) {
          return Future.error(error ?? {}, stackTrace);
        });

    debugPrint("Response: ${response.body}");
    if (response.statusCode != 200) {
      return Future.error(response.reasonPhrase ?? "Failed to add restroom.");
    }
    int id = jsonDecode(response.body)['id'];
    if (_image != null) {
      await _updatePicture(id.toString(), _image).onError((error, stackTrace) {
        return Future.error(error ?? {}, stackTrace);
      });
    }
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Future<http.Response> _updatePicture(id, picture) async {
    debugPrint("Updating picture");
    final url = Uri.parse("$api$restroomRoverUploadToiletPictureRoute");
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

  void updateRemainingCharacters() {
    setState(() {
      remainingCharacters = _addressTextController.text.length;
    });
  }

  @override
  void initState() {
    super.initState();
    debugPrint("init");
    _addressTextController.addListener(updateRemainingCharacters);
  }

  void dispose() {
    _addressTextController.removeListener(updateRemainingCharacters);
    _addressTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    Offset distanceWarning = _forwho["Kid"]!
        ? const Offset(5, 5)
        : Offset(size.width * 0.008, size.height * 0.005);
    double blurWarning = _forwho["Kid"]! ? 5.0 : 5;

    Offset distanceRecycling = _forwho["Handicapped"]!
        ? const Offset(5, 5)
        : Offset(size.width * 0.008, size.height * 0.005);
    double blurRecycling = _forwho["Handicapped"]! ? 5.0 : 5;

    return Theme(
      data: RestroomThemeData,
      child: Builder(
        builder: (context) {
          return Scaffold(
            key: _scaffoldKey,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  RestroomAppBar(scaffoldKey: _scaffoldKey),
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.025,
                        horizontal: size.width * 0.05),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Name *',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            ClayContainer(
                              width: size.width * 0.6,
                              height: size.height * 0.06,
                              color: const Color.fromRGBO(239, 239, 239, 1),
                              borderRadius: 30,
                              depth: -20,
                              child: TextField(
                                style: text_input(
                                    _nameTextController.text, context),
                                maxLength: 20,
                                controller: _nameTextController,
                                onChanged: (text) {
                                  setState(() {
                                    nameTextLength = text.length;
                                  });
                                  debugPrint('Typed text: $text');
                                },
                                decoration: InputDecoration(
                                  counterText: "",
                                  suffixText: "$nameTextLength/20",
                                  contentPadding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Type',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              child: ClayContainer(
                                  width: size.width * 0.6,
                                  height: size.height * 0.06,
                                  color: const Color.fromRGBO(239, 239, 239, 1),
                                  borderRadius: 30,
                                  depth: -20,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: DropdownButton(
                                        underline: Container(),
                                        isExpanded: true,
                                        items: restroomTypes
                                            .map((type) => DropdownMenuItem(
                                                value: type,
                                                child: Text(
                                                  type,
                                                  style:
                                                      text_input(type, context),
                                                )))
                                            .toList(),
                                        value: _type,
                                        onChanged: (value) {
                                          setState(() {
                                            _type =
                                                value ?? restroomTypes.first;
                                          });
                                        },
                                      ))),
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Position *',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            SizedBox(height: size.height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    LatLng getPosResult = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RestroomRoverFindPosition()),
                                    );
                                    debugPrint("Result $getPosResult");
                                    setState(() {
                                      _position = getPosResult;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      boxShadow: [
                                        const BoxShadow(
                                          blurRadius: 5,
                                          offset: Offset(5, 5),
                                          color: Color(0xFFA7A9AF),
                                        ),
                                        BoxShadow(
                                          blurRadius: 5,
                                          offset: Offset(size.width * -0.008,
                                              size.height * -0.005),
                                          color: const Color(0xFFA7A9AF),
                                          inset: true,
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      'SELECT',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    ClayContainer(
                                      width: size.width * 0.5,
                                      height: size.height * 0.032,
                                      color: const Color.fromRGBO(
                                          239, 239, 239, 1),
                                      borderRadius: 30,
                                      depth: -20,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        child: Text(
                                            'Lat: ${_position?.latitude.toStringAsFixed(5) ?? ()}',
                                            style: text_input(
                                                _position?.latitude
                                                        .toString() ??
                                                    "",
                                                context)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    ClayContainer(
                                      width: size.width * 0.5,
                                      height: size.height * 0.032,
                                      color: const Color.fromRGBO(
                                          239, 239, 239, 1),
                                      borderRadius: 30,
                                      depth: -20,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        child: Text(
                                            'Lng: ${_position?.longitude.toStringAsFixed(5) ?? ()}',
                                            style: text_input(
                                                _position?.longitude
                                                        .toString() ??
                                                    "",
                                                context)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        InkWell(
                          onTap: () {
                            _getImage();
                          },
                          child: _image == null
                              ? Container(
                                  width: size.width * 0.8,
                                  height: size.height * 0.125,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        const Color(0xFFFFB432)
                                            .withOpacity(0.9),
                                        const Color(0xFFFFFCCE).withOpacity(1),
                                      ],
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.035,
                                        height: size.height * 0.035,
                                        child: Opacity(
                                          opacity: 0.5,
                                          child: Image.asset(
                                              "assets/images/PinTheBin/corner.png"),
                                        ),
                                      ),
                                      SizedBox(
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
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: size.height * 0.085,
                                          left: size.width * 0.01,
                                        ),
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
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: size.height * 0.085,
                                          left: size.width * 0.75,
                                        ),
                                        child: Container(
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
                                            top: size.height * 0.075),
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          child: Opacity(
                                            opacity: 0.4,
                                            child: Text(
                                              "Upload picture",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: size.height * 0.03,
                                          left: size.width * 0.35,
                                        ),
                                        child: Image.asset(
                                          "assets/images/PinTheBin/upload.png",
                                          height: size.height * 0.05,
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 0.67),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                    width: size.width * 0.8,
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Address',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            SizedBox(height: size.height * 0.015),
                            ClayContainer(
                                width: size.width * 0.8,
                                height: size.height * 0.12,
                                color: const Color.fromRGBO(239, 239, 239, 1),
                                borderRadius: 30,
                                depth: -20,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: TextField(
                                      maxLength: 80,
                                      maxLines: null,
                                      controller: _addressTextController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r"\n"))
                                      ],
                                      onChanged: (text) {
                                        debugPrint('Typed text: $text');
                                        int remainningCharacters = 80 -
                                            _addressTextController.text.length;
                                        debugPrint(
                                            'Remaining characters: $remainningCharacters');
                                      },
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      style: text_input(
                                          _addressTextController.text,
                                          context)),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _forwho['Kid'] = !_forwho['Kid']!;
                                    });
                                    debugPrint(_forwho['Kid'].toString());
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
                                          inset: _forwho["Kid"]!,
                                        ),
                                        BoxShadow(
                                          blurRadius: blurWarning,
                                          offset: -distanceWarning,
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          inset: _forwho["Kid"]!,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                        Icons.baby_changing_station,
                                        size: 50),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.01),
                                Align(
                                  child: Text('BABIES',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _forwho['Handicapped'] =
                                          !_forwho['Handicapped']!;
                                    });
                                    debugPrint(
                                        _forwho['Handicapped'].toString());
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
                                          inset: _forwho["Handicapped"]!,
                                        ),
                                        BoxShadow(
                                          blurRadius: blurRecycling,
                                          offset: -distanceRecycling,
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          inset: _forwho["Handicapped"]!,
                                        ),
                                      ],
                                    ),
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Icon(Icons.accessible_sharp,
                                          size: 50),
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.01),
                                Text(
                                  'DISABLED',
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 40.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.grey[300],
                                  surfaceTintColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    side: const BorderSide(color: Colors.grey),
                                  ),
                                ),
                                child: Text(
                                  "Cancel",
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  _createPin().then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Pin created"),
                                      ),
                                    );
                                    Navigator.pushReplacementNamed(
                                        context, restroomPageRoute["home"]!);
                                  }).onError((error, stackTrace) {
                                    debugPrint("Error: $error");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Failed to create pin"),
                                      ),
                                    );
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.amber,
                                  surfaceTintColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    side: const BorderSide(color: Colors.grey),
                                  ),
                                ),
                                child: Text(
                                  'Submit',
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: size.height * 0.035)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            drawerScrimColor: Colors.transparent,
            drawer: const RestroomRoverNavbar(),
          );
        },
      ),
    );
  }
}

class RestroomAppBar extends StatelessWidget {
  const RestroomAppBar({
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
            Color(0xFFFFB330),
            Color(0xFFFFE9A6),
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
                "Pin Restroom",
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
