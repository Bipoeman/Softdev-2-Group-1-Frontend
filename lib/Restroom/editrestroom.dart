import 'dart:convert';
import "dart:io";
import 'package:clay_containers/widgets/clay_container.dart';
import "package:flutter/material.dart" hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import "package:image_picker/image_picker.dart";
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:ruam_mitt/Restroom/Component/font.dart';
import 'package:ruam_mitt/Restroom/Component/loading_screen.dart';
import 'package:ruam_mitt/Restroom/Component/navbar.dart';
import 'package:ruam_mitt/Restroom/Component/theme.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_func.dart';
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
  int addressTextLength = 0;
  int nameTextLength = 0;
  final Map<String, bool> _forwho = {
    'Kid': false,
    'Handicapped': false,
  };

  Future<void> _updateData() async {
    ThemeData theme = Theme.of(context);
    if (_nameTextController.text.isEmpty) {
      setState(() {
        _nameTextController.text = widget.restroomData['name'];
        nameTextLength = widget.restroomData['name'].length;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Name cannot be empty.",
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
            ),
          ),
          backgroundColor: theme.colorScheme.primary,
        ),
      );
      return Future.error("Name cannot be empty.");
    }
    await requestNewToken(context);
    debugPrint("Updating data");
    final url = Uri.parse(
        "$api$restroomRoverRestroomRoute/${widget.restroomData['id']}");
    var response = await http
        .put(url, headers: {
          "Authorization": "Bearer $publicToken",
        }, body: {
          "name": _nameTextController.text,
          "type": _type,
          "address": _addressTextController.text,
          "for_who": jsonEncode(_forwho)
        })
        .timeout(const Duration(seconds: 10))
        .onError((error, stackTrace) {
          return Future.error(error ?? {}, stackTrace);
        });
    if (response.statusCode != 200) {
      return Future.error(response.reasonPhrase ?? "Failed to send report");
    }
    if (_image != null) {
      await _updatePicture(widget.restroomData['id'].toString(), _image!)
          .onError((error, stackTrace) {
        return Future.error(error ?? {}, stackTrace);
      });
    }
  }

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

  Future<http.Response> _updatePicture(id, File picture) async {
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
      nameTextLength = widget.restroomData['name'].length;
      addressTextLength = widget.restroomData['address'].length;
    });
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
          return Stack(
            children: [
              Scaffold(
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
                                'Name',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
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
                                    color:
                                        const Color.fromRGBO(239, 239, 239, 1),
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
                                                    style: text_input(
                                                        type, context),
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
                          SizedBox(height: size.height * 0.025),
                          GestureDetector(
                            child: Stack(
                              fit: StackFit.loose,
                              alignment: Alignment.bottomCenter,
                              children: [
                                SizedBox(
                                    height: size.height * 0.15,
                                    child: _image == null
                                        ? widget.restroomData['picture'] == null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.network(
                                                  "https://media.discordapp.net/attachments/1033741246683942932/1213677182161920020/toilet_sign.png?ex=65f657f5&is=65e3e2f5&hm=69aa24e997ae288613645b0c45363aea72cdb7d9f0cbabacbfe7a3f04d6047ea&=&format=webp&quality=lossless&width=702&height=702",
                                                  fit: BoxFit.contain,
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.network(
                                                  widget
                                                      .restroomData['picture'],
                                                  fit: BoxFit.contain,
                                                ),
                                              )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
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
                                  'Description',
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextField(
                                        maxLength: 80,
                                        maxLines: null,
                                        controller: _addressTextController,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(
                                              RegExp(r"\n"))
                                        ],
                                        onChanged: (text) {
                                          setState(() {
                                            addressTextLength = text.length;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          counterText: "",
                                          border: InputBorder.none,
                                        ),
                                        style: text_input(
                                            _addressTextController.text,
                                            context)),
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: size.width * 0.05),
                                    child: IntrinsicWidth(
                                      child: Text(
                                        "$addressTextLength/80",
                                        style: text_input("", context),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: size.height * 0.05),
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
                                        color:
                                            const Color.fromARGB(9, 0, 47, 73),
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
                                        color:
                                            const Color.fromARGB(9, 0, 47, 73),
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.05),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
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
                              ElevatedButton(
                                onPressed: () {
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
                                              'Would you like to confirm the modifications to your restroom information?'),
                                          actions: [
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
                                                        BorderRadius.circular(
                                                            30)),
                                                child: const Center(
                                                    child: Text('Cancel')),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                showRestroomLoadingScreen(
                                                    context);
                                                _updateData().then((_) async {
                                                  Navigator.pop(context);
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context,
                                                          restroomPageRoute[
                                                              "myrestroom"]!);
                                                }).onError((error, stackTrace) {
                                                  debugPrint(
                                                      "Failed to update data: $error");
                                                  Navigator.popUntil(
                                                      context,
                                                      ModalRoute.withName(
                                                          restroomPageRoute[
                                                              "editrestroom"]!));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        "Failed to update data.",
                                                        style: TextStyle(
                                                          color: theme
                                                              .colorScheme
                                                              .onPrimary,
                                                        ),
                                                      ),
                                                      backgroundColor: theme
                                                          .colorScheme.primary,
                                                    ),
                                                  );
                                                });
                                              },
                                              child: const Text('Confirm'),
                                            ),
                                          ],
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
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
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
                "Edit Restroom",
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
