import 'package:flutter/material.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'dart:math';
import "package:ruam_mitt/TuachuayDekhor/Component/avatar.dart";
import "package:ruam_mitt/global_const.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class TuachuayDekhorBloggerPage extends StatefulWidget {
  const TuachuayDekhorBloggerPage({super.key});

  @override
  State<TuachuayDekhorBloggerPage> createState() =>
      _TuachuayDekhorBloggerPageState();
}

class _TuachuayDekhorBloggerPageState extends State<TuachuayDekhorBloggerPage> {
  var blogger = [];
  final bloggerurl = Uri.parse("$api$dekhorSearchBloggerRoute");

  @override
  void initState() {
    super.initState();
    showblogger();
  }

  Future<void> showblogger() async {
    var response = await http.get(
      bloggerurl,
    );
    if (response.statusCode == 200) {
      setState(() {
        blogger = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: size.height -
                      [size.width * 0.4, 100.0].reduce(min) -
                      MediaQuery.of(context).padding.top,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.12,
                        left: size.width * 0.04,
                      ),
                      child: GestureDetector(
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_back_outlined),
                            SizedBox(width: 5),
                            Text("Back")
                          ],
                        ),
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: size.width * 0.1,
                        right: size.width * 0.1,
                        top: size.width * 0.03,
                        bottom: size.width * 0.05,
                      ),
                      height: size.width * 0.2,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Blogger',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width * 0.8,
                      height: size.width * 0.02,
                      color: const Color.fromRGBO(0, 48, 73, 1),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: size.width * 0.05,
                        top: size.width * 0.03,
                      ),
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: List.generate(
                          blogger.length,
                          (index) {
                            return TuachuayDekhorAvatarViewer(
                              username: blogger[index]['user']['fullname'],
                              avatarUrl: blogger[index]['profile'] ??
                                  "https://api.multiavatar.com/${(blogger[index]['user']['fullname']).replaceAll(" ", "+")}.png",
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const NavbarTuachuayDekhor(),
          ],
        ),
      ),
    );
  }
}
