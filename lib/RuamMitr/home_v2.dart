import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/avatar.dart';
import 'package:ruam_mitt/RuamMitr/Component/home/contents.dart';
import 'package:ruam_mitt/RuamMitr/Component/home/services.dart';
import 'package:ruam_mitt/RuamMitr/Component/search_box.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/RuamMitr/contact_us.dart';

class HomeWidgetV2 extends StatefulWidget {
  const HomeWidgetV2({super.key});

  @override
  State<HomeWidgetV2> createState() => _HomeWidgetV2State();
}

class _HomeWidgetV2State extends State<HomeWidgetV2> {
  bool isServicesSelected = true;
  bool isContentsSelected = false;

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
    Size size = MediaQuery.of(context).size;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    CustomThemes ruammitrTheme = themeProvider.themeFrom("RuamMitr")!;
    return SingleChildScrollView(
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [AvatarViewer(size: size), ContactUs(themeProvider)],
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
                        padding: const EdgeInsets.fromLTRB(15, 40, 15, 15),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              ruammitrTheme.customColors["oddContainer"]!,
                              ruammitrTheme.customColors["oddContainer"]!.withOpacity(0),
                            ],
                          ),
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
                            isServicesSelected
                                ? ServicesWidget(size: size)
                                : ContentWidget(size: size),
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
    );
  }
}
