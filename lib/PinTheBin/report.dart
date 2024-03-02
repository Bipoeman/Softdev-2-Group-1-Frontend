import "dart:convert";
import "dart:io";
import "package:http/http.dart" as http;
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:ruam_mitt/PinTheBin/bin_drawer.dart";
import "package:ruam_mitt/PinTheBin/pin_the_bin_theme.dart";
import 'package:clay_containers/widgets/clay_container.dart';
import "package:ruam_mitt/global_const.dart";
import "package:ruam_mitt/global_var.dart";

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _ReporttextController = TextEditingController();
  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<http.Response> _sendreport(id, data) async {
    final url = Uri.parse("$api$pinTheBinReportBinRoute");
    print("Report has been sent");
    return await http.post(url, headers: {
      "Authorization": "Bearer $publicToken"
    }, body: {
      "binId": id,
      "description": _ReporttextController.text,
      "header": data,
    });
  }

  Future<http.Response> _addpicturereport(id, picture) async {
    final url = Uri.parse("$api$pinTheBinReportPictureBinRoute");
    print("Report has been sent");
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
    return res;
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
                        child: const Text(
                          "Name",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(0, 30, 49, 67),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.05),
                        child: ClayContainer(
                          height: size.height * 0.03,
                          width: size.width * 0.6,
                          color: const Color.fromRGBO(239, 239, 239, 1),
                          borderRadius: 30,
                          depth: -20,
                          child: Padding(
                            padding: EdgeInsets.only(left: size.width * 0.02),
                            child: Text(
                              data['Bininfo']["location"],
                              style: TextStyle(
                                  fontFamily:
                                      data['Bininfo']["location"].contains(
                                    RegExp("[ก-๛]"),
                                  )
                                          ? "THSarabunPSK"
                                          : Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .fontFamily,
                                  fontSize:
                                      data['Bininfo']["location"].contains(
                                    RegExp("[ก-๛]"),
                                  )
                                          ? 22
                                          : 16,
                                  fontWeight:
                                      data['Bininfo']["location"].contains(
                                    RegExp("[ก-๛]"),
                                  )
                                          ? FontWeight.w700
                                          : FontWeight.normal,
                                  color: const Color.fromRGBO(0, 30, 49, 67)),
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
                        child: const Text(
                          "Position",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(0, 30, 49, 67),
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
                          color: const Color(0xFFEBEBEB),
                          borderRadius: 30,
                          depth: -20,
                          child: Padding(
                            padding: EdgeInsets.only(left: size.width * 0.02),
                            child: Text(
                              "Latitude : ${data['Bininfo']['latitude']}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(0, 30, 49, 67),
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
                          color: const Color(0xFFEBEBEB),
                          borderRadius: 30,
                          depth: -20,
                          child: Padding(
                            padding: EdgeInsets.only(left: size.width * 0.02),
                            child: Text(
                              "Longitude : ${data['Bininfo']['longitude']}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(0, 30, 49, 67),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.02),
                        ),
                        SizedBox(
                          width: size.width * 0.7,
                          height: size.height * 0.15,
                          child: data['Bininfo']['picture'] == null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    "assets/images/PinTheBin/bin_null.png",
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    data['Bininfo']['picture'],
                                    fit: BoxFit.contain,
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
                          child: const Text(
                            "Report",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(0, 30, 49, 67),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.01, right: size.width * 0.1),
                          child: ClayContainer(
                            width: size.width * 0.7,
                            height: size.height * 0.125,
                            color: const Color(0xFFEBEBEB),
                            borderRadius: 30,
                            depth: -20,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.width * 0.02,
                                  right: size.width * 0.02),
                              child: TextField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                controller: _ReporttextController,
                                onChanged: (text) {
                                  print('Typed text: $text , ${text.length}');
                                },
                                maxLength: 80,
                                maxLines: 3,
                                style: TextStyle(
                                    fontFamily:
                                        _ReporttextController.text.contains(
                                      RegExp("[ก-๛]"),
                                    )
                                            ? "THSarabunPSK"
                                            : Theme.of(context)
                                                .textTheme
                                                .headlineMedium!
                                                .fontFamily,
                                    fontSize:
                                        _ReporttextController.text.contains(
                                      RegExp("[ก-๛]"),
                                    )
                                            ? 22
                                            : 16,
                                    fontWeight:
                                        _ReporttextController.text.contains(
                                      RegExp("[ก-๛]"),
                                    )
                                            ? FontWeight.w700
                                            : FontWeight.normal,
                                    color: const Color.fromRGBO(0, 30, 49, 67)),
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
                        _getImage();
                      },
                      child: _image == null
                          ? Container(
                              width: size.width * 0.7,
                              height: size.height * 0.125,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    const Color(0xFF292643).withOpacity(0.46),
                                    const Color(0xFFF9A58D).withOpacity(0.72),
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
                                      width: size.width * 0.035,
                                      height: size.height * 0.035,
                                      child: Opacity(
                                        opacity: 0.5,
                                        child: Image.asset(
                                            "assets/images/PinTheBin/corner.png"),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: size.height * 0.01,
                                      left: size.width * 0.65,
                                    ),
                                    child: Container(
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
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: size.height * 0.08,
                                      left: size.width * 0.01,
                                    ),
                                    child: Container(
                                      alignment: Alignment.bottomLeft,
                                      width: size.width * 0.035,
                                      height: size.height * 0.035,
                                      child: Transform.rotate(
                                        angle: 270 * 3.141592653589793 / 180,
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
                                      top: size.height * 0.08,
                                      left: size.width * 0.65,
                                    ),
                                    child: Container(
                                      alignment: Alignment.bottomLeft,
                                      width: size.width * 0.035,
                                      height: size.height * 0.035,
                                      child: Transform.rotate(
                                        angle: 180 * 3.141592653589793 / 180,
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
                                      left: size.width * 0.3,
                                    ),
                                    child: Image.asset(
                                      "assets/images/PinTheBin/upload.png",
                                      height: size.height * 0.05,
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 0.67),
                                    ),
                                  ),
                                ],
                              ))
                          : SizedBox(
                              width: size.width * 0.7,
                              height: size.height * 0.125,
                              child: Image.file(
                                _image!,
                                fit: BoxFit.contain,
                              ),
                            ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.02, right: size.width * 0.1),
                    child: SizedBox(
                      height: size.height * 0.1,
                      width: size.width * 0.7,
                      child: Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.3,
                            height: size.height * 0.05,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  pinthebinPageRoute["home"]!,
                                );
                              },
                              child: Ink(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color(0xFFF79F8A),
                                ),
                                child: const Center(
                                  child: Text(
                                    "CANCEL",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFEBEBEB),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.1),
                            child: SizedBox(
                              width: size.width * 0.3,
                              height: size.height * 0.05,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () async {
                                  http.Response res = await _sendreport(
                                      '${data['Bininfo']["id"]}',
                                      data['Bininfo']['location']);
                                  print("res : ${res.body}");

                                  res = await _addpicturereport(
                                      '${jsonDecode(res.body)[0]["id"]}',
                                      _image!);
                                  print("response : ${res.body}");
                                  if (res.statusCode == 200) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                          "Registration successful.",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        backgroundColor: Colors.green[300],
                                      ),
                                    );
                                    Navigator.pushNamed(
                                      context,
                                      pinthebinPageRoute["home"]!,
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Registration failed.",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                child: Ink(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color(0xFF547485),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "SUMMIT",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFEBEBEB),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
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
