import "dart:convert";
import "package:flutter/material.dart";
// import "package:flutter_sliding_box/flutter_sliding_box.dart";
import "package:http/http.dart" as http;
import "package:provider/provider.dart";
import "package:ruam_mitt/PinTheBin/navbar.dart";
import "package:ruam_mitt/RuamMitr/Component/theme.dart";
import "package:ruam_mitt/global_const.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:ruam_mitt/global_var.dart';

class MyBinPage extends StatefulWidget {
  const MyBinPage({super.key});

  @override
  State<MyBinPage> createState() => _MyBinState();
}

class _MyBinState extends State<MyBinPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic binData = [];

  Future<http.Response> myBinInfo() async {
    Uri url = Uri.parse("$api$pinTheBinMyBinRoute");
    http.Response res =
        await http.get(url, headers: {"Authorization": "Bearer $publicToken"});
    print(res.body);
    return res;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Init Bin Page");
    myBinInfo().then((response) {
      // print("Response");
      // print(response.body);
      setState(() {
        binData = jsonDecode(response.body);
      });
      // print(binData);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // BoxController binInfoController = BoxController();
    ThemeProvider themes = Provider.of<ThemeProvider>(context);
    ThemeData pinTheBinTheme = themes.themeFrom("PinTheBin")!.themeData;
    return Theme(
      data: pinTheBinTheme,
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Stack(children: [
            Positioned(
              top: size.height * 0.01,
              left: size.width * 0.025,
              child: GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                child: Container(
                  width: size.width * 0.1,
                  height: size.height * 0.05,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF77F00),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.menu),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  size.width * 0.36, size.height * 0.01, 0, 0),
              child: Text(
                "My Bin",
                style: GoogleFonts.getFont(
                  'Sen',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: binData.isEmpty
                  ? [
                      Center(
                          heightFactor: size.height * 0.02,
                          child: Text(
                            'No Bin Found!',
                            style: GoogleFonts.getFont(
                              'Sen',
                              color: Color(0xFFF77F00),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                    ]
                  : [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.1,
                          left: size.width * 0.05,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: binData.map<Widget>((data) {
                              return Container(
                                  width: size.width * 0.9,
                                  height: size.height * 0.3,
                                  margin: EdgeInsets.symmetric(vertical: 5.0),
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Bin Name: ${data["location"]}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Type: ${data["bintype"]["redbin"] ? "\nDanger" : ""} ${data["bintype"]["greenbin"] ? "\nWaste" : ""} ${data["bintype"]["yellow"] ? "\nRecycle" : ""} ${data["bintype"]["bluebin"] ? "\nGeneral" : ""}',
                                          ),
                                          Row(
                                            // verticalDirection:
                                            //     VerticalDirection.down,
                                            children: [
                                              ElevatedButton.icon(
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  size: 30.0,
                                                ),
                                                label: Text('Edit'),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    pinthebinPageRoute[
                                                        "editbin"]!,
                                                    arguments: {
                                                      'Bininfo':
                                                          '${data["id"]}',
                                                    },
                                                  );
                                                },
                                              ),
                                              const SizedBox(width: 10),
                                              ElevatedButton.icon(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  size: 30.0,
                                                ),
                                                label: Text('Delete'),
                                                onPressed: () {
                                                  print('Delete');
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.6),
                                        child: data["picture"] == null
                                            ? Image.asset(
                                                "assets/images/PinTheBin/bin_null.png",
                                                fit: BoxFit.cover,
                                                width: size.width * 0.2,
                                                height: size.width * 0.2,
                                              )
                                            : Image.network(data["picture"]),
                                      )
                                    ],
                                  ));
                            }).toList(),
                          ),
                        ),
                      ))
                    ],
            )
          ]),
        ),
        drawerScrimColor: Colors.transparent,
        drawer: const NavBar(),
      ),
    );
  }
}
