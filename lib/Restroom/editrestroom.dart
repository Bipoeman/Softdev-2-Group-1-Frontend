import 'dart:convert';
import "dart:io";
import 'package:clay_containers/widgets/clay_container.dart';
import "package:flutter/material.dart" hide BoxDecoration, BoxShadow;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import "package:image_picker/image_picker.dart";
import 'package:http/http.dart' as http;
import 'package:ruam_mitt/Restroom/Component/navbar.dart';
import 'package:ruam_mitt/Restroom/Component/theme.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';

Color colorbackground = const Color(0x00000000);
List<String> restroomTypes = ["Free", "Must Paid", "Toilet In Stores"];

class EditRestroomPage extends StatefulWidget {
  const EditRestroomPage({super.key, required this.restroomData});
  final Map<String, dynamic> restroomData;

  @override
  State<EditRestroomPage> createState() => _EditRestroomPageState();
}

class _EditRestroomPageState extends State<EditRestroomPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _addressTextController = TextEditingController();
  File? _image;
  String _type = restroomTypes.first;

  final Map<String, bool> _forwho = {
    'Kid': false,
    'Handicapped': false,
  };

  Future<void> _updateData() async {
    debugPrint("Updating data");
    final url = Uri.parse("$api$restroomRoverEditRoute");
    await http
        .post(url, headers: {
          "Authorization": "Bearer $publicToken",
        }, body: {
          "id": widget.restroomData['id'].toString(),
          "name": _nameTextController.text,
          "type": _type,
          "address": _addressTextController.text,
          "for_who": jsonEncode(_forwho)
        })
        .timeout(Durations.extralong4)
        .onError((error, stackTrace) {
          return Future.error(error ?? {}, stackTrace);
        });
    if (_image != null) {
      await _updatePicture(widget.restroomData['id'].toString(), _image)
          .onError((error, stackTrace) {
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
    http.StreamedResponse response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    if (res.statusCode != 200) {
      throw Exception("Failed to upload picture ${res.body}");
    }
    return res;
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _nameTextController =
          TextEditingController(text: widget.restroomData['name']);
      _addressTextController =
          TextEditingController(text: widget.restroomData['address']);
      _forwho["Kid"] = widget.restroomData["for_who"]["Kid"];
      _forwho["Handicapped"] = widget.restroomData["for_who"]["Handicapped"];
      _type = widget.restroomData["type"];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                      Text(
                        "EDIT",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Name',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          ClayContainer(
                            width: size.width * 0.65,
                            height: size.height * 0.06,
                            color: const Color.fromRGBO(239, 239, 239, 1),
                            borderRadius: 30,
                            depth: -20,
                            child: TextField(
                              controller: _nameTextController,
                              onChanged: (text) {
                                debugPrint('Typed text: $text');
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 5, right: 5, bottom: 5),
                                border: InputBorder.none,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: size.height * 0.025),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Type',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: ClayContainer(
                                width: size.width * 0.65,
                                height: size.height * 0.06,
                                color: const Color.fromRGBO(239, 239, 239, 1),
                                borderRadius: 30,
                                depth: -20,
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: DropdownButton(
                                      underline: Container(),
                                      isExpanded: true,
                                      items: restroomTypes
                                          .map((type) => DropdownMenuItem(
                                              value: type, child: Text(type)))
                                          .toList(),
                                      value: _type,
                                      onChanged: (value) {
                                        setState(() {
                                          _type = value ?? restroomTypes.first;
                                        });
                                      },
                                    ))),
                          )
                        ],
                      ),
                      SizedBox(height: size.height * 0.025),
                      GestureDetector(
                        child: Stack(
                          fit: StackFit.loose,
                          alignment: Alignment.bottomCenter,
                          children: [
                            SizedBox(
                                width: size.width * 0.7,
                                height: size.height * 0.15,
                                child: _image == null
                                    ? widget.restroomData['picture'] == null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.asset(
                                              "assets/images/PinTheBin/bin_null.png",
                                              fit: BoxFit.contain,
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              widget.restroomData['picture'],
                                              fit: BoxFit.contain,
                                            ),
                                          )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.file(
                                          _image!,
                                          fit: BoxFit.contain,
                                        ),
                                      )),
                            IntrinsicWidth(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: Colors.black54.withOpacity(0.2)),
                                child: const Row(
                                  children: [
                                    Text(
                                      'Upload',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.upload_file,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          _getImage();
                        },
                      ),
                      SizedBox(height: size.height * 0.025),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Address',
                              style: Theme.of(context).textTheme.displayMedium,
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
                                padding: const EdgeInsets.only(left: 5),
                                child: TextField(
                                  maxLength: 80,
                                  maxLines: 2,
                                  controller: _addressTextController,
                                  onChanged: (text) {
                                    debugPrint('Typed text: $text');
                                    int remainningCharacters =
                                        80 - _addressTextController.text.length;
                                    debugPrint(
                                        'Remaining characters: $remainningCharacters');
                                  },
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              )),
                        ],
                      ),
                      SizedBox(height: size.height * 0.025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _forwho['Handicapped'] =
                                        !_forwho['Handicapped']!;
                                  });
                                  debugPrint(_forwho['Handicapped'].toString());
                                },
                                child: Container(
                                  width: size.width * 0.2,
                                  height: size.height * 0.13,
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
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.accessible_sharp,
                                        size: size.width * 0.1),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.01),
                                child: Text(
                                  'HANDICAPPED',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
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
                                  height: size.height * 0.13,
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
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.baby_changing_station,
                                        size: size.width * 0.1),
                                  ),
                                ),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.01),
                                child: Align(
                                  //padding: const EdgeInsets.only(top: size.height * 0.0),
                                  child: Text(
                                    'BABY',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.017,
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
                                'CHANGE',
                                style: GoogleFonts.getFont(
                                  "Sen",
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Confirm change',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      content: const Text(
                                          'Would you like to confirm the modifications to your trash bin information?'),
                                      actions: [
                                        MaterialButton(
                                          onPressed: () {
                                            _updateData().then((_) async {
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  restroomPageRoute[
                                                      "myrestroom"]!);
                                            }).onError((error, stackTrace) {
                                              debugPrintStack(
                                                  label: "Error updating data",
                                                  stackTrace: stackTrace);
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Failed to update data.")));
                                            });
                                          },
                                          child: const Text('Confirm'),
                                        ),
                                        MaterialButton(
                                          color: Colors.red,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            width: size.width * 0.2,
                                            height: size.height * 0.05,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    0, 244, 67, 54),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: const Center(
                                                child: Text('Cancel')),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                          ),
                          SizedBox(width: size.width * 0.25),
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.024,
                                  top: size.height * 0.01),
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
                drawerScrimColor: Colors.transparent,
                drawer: const RestroomRoverNavbar(),
              ),
            ],
          );
        },
      ),
    );
  }
}
