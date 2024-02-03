import "package:flutter/material.dart";
import 'package:ruam_mitt/RuamMitr/Component/avatar.dart';
import 'package:ruam_mitt/RuamMitr/Component/search_box.dart';
import 'package:ruam_mitt/RuamMitr/Component/home/services.dart';
import "dart:math";

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isServicesSelected = false;
  bool isContentsSelected = true;

  Widget selectionText(BuildContext context, String text, bool isSelected) {
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
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: [300.0, size.width * 0.7].reduce(min),
                  child: const SearchBox(),
                ),
                SizedBox(
                  width: [size.width * 0.8, 800.0].reduce(min),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 40, 15, 15),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer.withOpacity(0.8),
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
                                    isServicesSelected = true;
                                    isContentsSelected = false;
                                  },
                                );
                              },
                              child: selectionText(
                                context,
                                "Services",
                                isServicesSelected,
                              ),
                            ),
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
                                context,
                                "Contents",
                                isContentsSelected,
                              ),
                            ),
                          ],
                        ),
                        const ServicesWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
