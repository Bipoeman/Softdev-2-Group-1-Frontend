import 'dart:convert';
import 'dart:math';
import 'package:bottom_bar_matu/bottom_bar_double_bullet/bottom_bar_double_bullet.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/RuamMitr/home_v2.dart';
import 'package:ruam_mitt/RuamMitr/profile_v2.dart';
import 'package:ruam_mitt/RuamMitr/settings_v2.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:http/http.dart' as http;

class HomePageV2 extends StatefulWidget {
  const HomePageV2({super.key});

  @override
  State<HomePageV2> createState() => _HomePageV2State();
}

class _HomePageV2State extends State<HomePageV2> {
  int pageIndex = 1;
  PageController pageController = PageController(initialPage: 1);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("Home Ruammitr InitState");
    Uri uri = Uri.parse("$api$userDataRequestRoute");
    setState(() {});
    http.get(uri, headers: {"Authorization": "Bearer $publicToken"}).then(
        (http.Response res) {
      profileData = jsonDecode(res.body);

      setState(() {});
      // print("Requested Data : ${profileData}");
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ThemeProvider themes = Provider.of<ThemeProvider>(context);
    
    // String avatarTextBackgroundColorString = theme.colorScheme.primaryContainer
    //     .toString()
    //     .replaceAll("Color(", "")
    //     .replaceAll(")", "")+
    //     .substring(4);
    // String avatarTextColorString = theme.colorScheme.onPrimaryContainer
    //     .toString()
    //     .replaceAll("Color(", "")
    //     .replaceAll(")", "")
    //     .substring(4);
    var nowParam = DateFormat('yyyyddMMHHmm').format(DateTime.now());
    if (profileData['profile'] != null) {
      profileData['imgPath'] = "${profileData['profile']}#$nowParam";
    } else {
      profileData['imgPath'] =
          "https://api.multiavatar.com/${(profileData['fullname'] ?? "").replaceAll(" ", "+")}.png";
    }
    // profileData['imgPath'] = "${profileData['profile']}" ??
    //     // "https://ui-avatars.com/api/?background=$avatarTextBackgroundColorString&color=$avatarTextColorString&size=512&name=${profileData['fullname'].replaceAll(" ", "+")}";
    //     "https://api.multiavatar.com/${(profileData['fullname'] ?? "").replaceAll(" ", "+")}.png";
    
    return Container(
      decoration: ruamMitrBackgroundGradient(themes),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomBarDoubleBullet(
          color: theme.colorScheme.primary,
          backgroundColor: theme.colorScheme.primaryContainer,
          selectedIndex: pageIndex,
          items: [
            BottomBarItem(iconData: Icons.person),
            BottomBarItem(iconData: Icons.home),
            BottomBarItem(iconData: Icons.settings),
          ],
          onSelect: (index) {
            pageController.animateToPage(
              index,
              duration: const Duration(seconds: 1),
              curve: const Tanh(),
            );
          },
        ),
        body: SafeArea(
          child: PageView(
            controller: pageController,
            onPageChanged: (pageChanged) {
              setState(() => pageIndex = pageChanged);
            },
            children: [
              profileData['fullname'] == null
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
                  : ProfileWidgetV2(),
              profileData['fullname'] == null
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
                  : HomeWidgetV2(),
              SettingsWidgetV2()
            ],
          ),
        ),
      ),
    );
  }
}

class Tanh extends Curve {
  final double count;

  const Tanh({this.count = 3});

  // t = x
  @override
  double transformInternal(double t) {
    t *= 3.5;
    var val = (exp(t) - exp(-t)) / (exp(t) + exp(-t));
    return val; //f(x)
  }
}
