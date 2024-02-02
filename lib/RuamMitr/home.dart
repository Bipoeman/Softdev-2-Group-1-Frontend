import "package:flutter/material.dart";
import 'package:ruam_mitt/RuamMitr/Component/avatar.dart';
import 'package:ruam_mitt/RuamMitr/Component/search_box.dart';
import "dart:math";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Container(
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
            child: IntrinsicHeight(
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 35,
                    width: [size.width * 0.8, 800.0].reduce(min),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(15, 40, 15, 15),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  debugPrint("Contents");
                                },
                                child: Text(
                                  "Contents",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: theme.colorScheme.onBackground,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  debugPrint("Services");
                                },
                                child: Text(
                                  "Services",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: theme.colorScheme.onBackground,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
          ),
        ],
      ),
    );
  }
}
