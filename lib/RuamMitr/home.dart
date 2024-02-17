import 'dart:convert';

import "package:flutter/material.dart";
import 'package:http/http.dart';
import 'package:ruam_mitt/RuamMitr/Component/avatar.dart';
import 'package:ruam_mitt/RuamMitr/Component/search_box.dart';
import 'package:ruam_mitt/RuamMitr/Component/home/services.dart';
import 'package:ruam_mitt/RuamMitr/Component/main_navigator.dart';
import "dart:math";

import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isServicesSelected = true;
  bool isContentsSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Uri uri = Uri.parse("$api$userDataRequestRoute");
    setState(() {});
    get(uri, headers: {"Authorization": "Bearer $publicToken"})
        .then((Response res) {
      profileData = jsonDecode(res.body);
      setState(() {});
      print(profileData);
    });
  }

  Widget selectionText(String text, bool isSelected) {
    ThemeData theme = Theme.of(context);

    return Container(
      decoration: isSelected
          ? UnderlineTabIndicator(
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 3,
              ),
            )
          : null,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onBackground,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      bottomNavigationBar: MainNavigator(pageIndex: 1),
      body: SafeArea(
        child: profileData['fullname'] == null
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Divider(),
                    Text("Loading user data"),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: size.height -
                        [size.width * 0.4, 100.0].reduce(min) -
                        MediaQuery.of(context).padding.top,
                  ),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AvatarViewer(),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(32),
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: AlignmentDirectional.topCenter,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 35),
                                width: [size.width * 0.8, 800.0].reduce(min),
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 40, 15, 15),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primaryContainer
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Wrap(
                                        spacing: 20,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              setState(
                                                () {
                                                  isServicesSelected = false;
                                                  isContentsSelected = true;
                                                },
                                              );
                                            },
                                            child: selectionText(
                                              "Contents",
                                              isContentsSelected,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(
                                                () {
                                                  isServicesSelected = true;
                                                  isContentsSelected = false;
                                                },
                                              );
                                            },
                                            child: selectionText(
                                              "Services",
                                              isServicesSelected,
                                            ),
                                          ),
                                        ],
                                      ),
                                      ServicesWidget(size: size),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                width: [300.0, size.width * 0.7].reduce(min),
                                child: const SearchBox(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
