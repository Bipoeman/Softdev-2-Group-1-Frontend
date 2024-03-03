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
  int remainingCharacters = 0;
  final Map<String, bool> _forwho = {
    'Kid': false,
    'Handicapped': false,
  };

  Future<void> _updateData() async {
    debugPrint("Updating data");
    final url = Uri.parse("$api$restroomRoverRestroomRoute");
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

  void dispose() {
    _addressTextController.removeListener(updateRemainingCharacters);
    _addressTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _addressTextController.addListener(updateRemainingCharacters);
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
                      padding: EdgeInsets.only(
                          top: size.height * 0.03, left: size.width * 0.1),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Name',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              ClayContainer(
                                width: size.width * 0.6,
                                height: size.height * 0.032,
                                color: const Color.fromRGBO(239, 239, 239, 1),
                                borderRadius: 30,
                                depth: -20,
                                child: TextField(
                                  maxLength: 20,
                                  controller: _nameTextController,
                                  onChanged: (text) {
                                    debugPrint('Typed text: $text');
                                  },
                                  decoration: InputDecoration(
                                    counterText: "",
                                    contentPadding: EdgeInsets.only(
                                        left: 10, right: 10, bottom: 14.5),
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
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                alignment: Alignment.topRight,
                                child: ClayContainer(
                                    width: size.width * 0.6,
                                    height: size.height * 0.04,
                                    color:
                                        const Color.fromRGBO(239, 239, 239, 1),
                                    borderRadius: 30,
                                    depth: -20,
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: DropdownButton(
                                          underline: Container(),
                                          isExpanded: true,
                                          items: restroomTypes
                                              .map((type) => DropdownMenuItem(
                                                  value: type,
                                                  child: Text(type)))
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
                                    width: size.width * 0.7,
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
                                  'Address',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                              SizedBox(height: size.height * 0.015),
                              Padding(
                                padding: const EdgeInsets.only(right: 40),
                                child: ClayContainer(
                                    width: size.width * 0.8,
                                    height: size.height * 0.12,
                                    color:
                                        const Color.fromRGBO(239, 239, 239, 1),
                                    borderRadius: 30,
                                    depth: -20,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 20),
                                      //               child : Stack(
                                      //   alignment: Alignment.centerRight,
                                      //   children: [
                                      //     TextField(
                                      //       maxLength: 250,
                                      //       maxLines: 9,
                                      //       controller: _addressTextController,
                                      //       // inputFormatters: [
                                      //       //   LengthLimitingTextInputFormatter(80),
                                      //       // ],
                                      //       decoration: InputDecoration(
                                      //         // counterText: "",
                                      //         border: InputBorder.none,
                                      //         contentPadding: EdgeInsets.only(
                                      //             left: 16, right: 16, top: 20),
                                      //         // hintText: 'Write a report...',
                                      //       ),
                                      //     ),
                                      //     Positioned(
                                      //       top: 1,
                                      //       right: 16.0,
                                      //       child: Text(
                                      //         '$remainingCharacters/250',
                                      //         style: TextStyle(
                                      //           color: Colors.grey,
                                      //           fontSize: 12.0,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      child: Stack(
                                          alignment: Alignment.centerRight,
                                          children: [
                                            TextField(
                                              maxLength: 80,
                                              maxLines: 3,
                                              controller:
                                                  _addressTextController,
                                              onChanged: (text) {
                                                debugPrint('Typed text: $text');
                                                int remainningCharacters = 80 -
                                                    _addressTextController
                                                        .text.length;
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
                                            //              Positioned(
                                            //   top: 1,
                                            //   right: 16.0,
                                            //   child: Text(
                                            //     '$remainingCharacters/80',
                                            //     style: TextStyle(
                                            //       color: Colors.grey,
                                            //       fontSize: 12.0,
                                            //     ),
                                            //   ),
                                            // ),
                                          ]),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.05),
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: Row(
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
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: const Color.fromARGB(
                                              9, 0, 47, 73),
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
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.01),
                                      child: Align(
                                        //padding: const EdgeInsets.only(top: size.height * 0.0),
                                        child: Text(
                                          'Kid',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
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
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: const Color.fromARGB(
                                              9, 0, 47, 73),
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
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.01),
                                      child: Text(
                                        'HANDICAPPED',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height * 0.05),
                          Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: Row(
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
                                        side:
                                            const BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                    child: Text(
                                      "Cancel",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40.0),
                                  child: ElevatedButton(
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
                                                  'Would you like to confirm the modifications to your trash bin information?'),
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
                                                        color:
                                                            const Color.fromARGB(
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
                                                    _updateData().then((_) async {
                                                      Navigator
                                                          .pushReplacementNamed(
                                                              context,
                                                              restroomPageRoute[
                                                                  "myrestroom"]!);
                                                    }).onError(
                                                        (error, stackTrace) {
                                                      debugPrintStack(
                                                          label:
                                                              "Error updating data",
                                                          stackTrace: stackTrace);
                                                      Navigator.pop(context);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      "Failed to update data.")));
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
                                        side:
                                            const BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                    child: Text(
                                      'Submit',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     GestureDetector(
                          //       child: Container(
                          //         padding: EdgeInsets.only(
                          //             left: size.width * 0.017,
                          //             top: size.height * 0.01),
                          //         width: size.width * 0.25,
                          //         height: size.height * 0.055,
                          //         decoration: BoxDecoration(
                          //           color: const Color(0xFF547485),
                          //           borderRadius: BorderRadius.circular(30),
                          //           boxShadow: const [
                          //             BoxShadow(
                          //               blurRadius: 5,
                          //               //offset: ,
                          //               color: Color(0xFFA7A9AF),
                          //             ),
                          //           ],
                          //         ),
                          //         child: Text(
                          //           'CHANGE',
                          //           style: GoogleFonts.getFont(
                          //             "Sen",
                          //             color: const Color.fromARGB(
                          //                 255, 255, 255, 255),
                          //             fontSize: 20,
                          //             fontWeight: FontWeight.w600,
                          //           ),
                          //         ),
                          //       ),
                          //       onTap: () {
                          //         showDialog(
                          //             context: context,
                          //             builder: (context) {
                          //               return AlertDialog(
                          //                 title: Text(
                          //                   'Confirm change',
                          //                   style: Theme.of(context)
                          //                       .textTheme
                          //                       .headlineSmall,
                          //                 ),
                          //                 content: const Text(
                          //                     'Would you like to confirm the modifications to your trash bin information?'),
                          //                 actions: [
                          //                   MaterialButton(
                          //                     onPressed: () {
                          //                       _updateData().then((_) async {
                          //                         Navigator
                          //                             .pushReplacementNamed(
                          //                                 context,
                          //                                 restroomPageRoute[
                          //                                     "myrestroom"]!);
                          //                       }).onError((error, stackTrace) {
                          //                         debugPrintStack(
                          //                             label:
                          //                                 "Error updating data",
                          //                             stackTrace: stackTrace);
                          //                         Navigator.pop(context);
                          //                         ScaffoldMessenger.of(context)
                          //                             .showSnackBar(const SnackBar(
                          //                                 content: Text(
                          //                                     "Failed to update data.")));
                          //                       });
                          //                     },
                          //                     child: const Text('Confirm'),
                          //                   ),
                          //                   MaterialButton(
                          //                     color: Colors.red,
                          //                     onPressed: () {
                          //                       Navigator.of(context).pop();
                          //                     },
                          //                     child: Container(
                          //                       width: size.width * 0.2,
                          //                       height: size.height * 0.05,
                          //                       decoration: BoxDecoration(
                          //                           color: const Color.fromARGB(
                          //                               0, 244, 67, 54),
                          //                           borderRadius:
                          //                               BorderRadius.circular(
                          //                                   30)),
                          //                       child: const Center(
                          //                           child: Text('Cancel')),
                          //                     ),
                          //                   ),
                          //                 ],
                          //               );
                          //             });
                          //       },
                          //     ),
                          //     SizedBox(width: size.width * 0.25),
                          //     GestureDetector(
                          //       child: Container(
                          //         padding: EdgeInsets.only(
                          //             left: size.width * 0.024,
                          //             top: size.height * 0.01),
                          //         width: size.width * 0.25,
                          //         height: size.height * 0.055,
                          //         decoration: BoxDecoration(
                          //           color: const Color(0xFFF9957F),
                          //           borderRadius: BorderRadius.circular(30),
                          //           boxShadow: const [
                          //             BoxShadow(
                          //               blurRadius: 5,
                          //               //offset: ,
                          //               color: Color(0xFFA7A9AF),
                          //             ),
                          //           ],
                          //         ),
                          //         child: Text(
                          //           'CANCEL',
                          //           style: GoogleFonts.getFont(
                          //             "Sen",
                          //             color: const Color.fromARGB(
                          //                 255, 255, 255, 255),
                          //             fontSize: 20,
                          //             fontWeight: FontWeight.w600,
                          //           ),
                          //         ),
                          //       ),
                          //       onTap: () {
                          //         Navigator.pop(context);
                          //       },
                          //     ),
                          //   ],
                          // ),
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
