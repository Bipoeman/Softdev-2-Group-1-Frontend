import 'package:flutter/material.dart';
import 'package:ruam_mitt/RuamMitr/home.dart';
import 'package:ruam_mitt/RuamMitr/profile.dart';
import 'package:ruam_mitt/RuamMitr/settings.dart';
import 'package:ruam_mitt/RuamMitr/Component/main_navigator.dart';
import 'package:ruam_mitt/RuamMitr/Component/page_route_animation.dart';
import 'dart:math';

class PortalPage extends StatefulWidget {
  const PortalPage({super.key, this.page});
  final Widget? page;

  @override
  State<PortalPage> createState() => _PortalPageState();
}

class _PortalPageState extends State<PortalPage> {
  late Widget navController;

  @override
  void initState() {
    super.initState();
    navController = MainNavigator(
      onHome: () {
        if (widget.page.runtimeType != HomePage) {
          Navigator.popUntil(context, (route) => false);
          Navigator.push(
            context,
            NoAnimationMaterialPageRoute(
              builder: (context) => const PortalPage(
                page: HomePage(),
              ),
            ),
          );
        }
      },
      onProfile: () {
        if (widget.page.runtimeType != ProfilePage) {
          Navigator.push(
            context,
            NoAnimationMaterialPageRoute(
              builder: (context) {
                return const PortalPage(
                  page: ProfilePage(),
                );
              },
            ),
          );
        }
      },
      onSettings: () {
        if (widget.page.runtimeType != SettingsPage) {
          Navigator.push(
            context,
            NoAnimationMaterialPageRoute(
              builder: (context) {
                return const PortalPage(
                  page: SettingsPage(),
                );
              },
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      bottomNavigationBar: navController,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height -
                  [size.width * 0.4, 100.0].reduce(min) -
                  MediaQuery.of(context).padding.top,
            ),
            child: widget.page ?? const HomePage(),
          ),
        ),
      ),
    );
  }
}
