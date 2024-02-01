import 'package:flutter/material.dart';
import 'package:ruam_mitt/RuamMitr/home.dart';
import 'package:ruam_mitt/RuamMitr/profile.dart';
import 'package:ruam_mitt/RuamMitr/settings.dart';
import 'dart:math';

class PortalPage extends StatefulWidget {
  const PortalPage({super.key});

  @override
  State<PortalPage> createState() => _PortalPageState();
}

class _PortalPageState extends State<PortalPage> {
  late Widget navController;
  String _selectedPage = "home";
  Widget _selectedWidget() {
    switch (_selectedPage) {
      case "home":
        return const HomePage();
      case "profile":
        return const ProfilePage();
      case "settings":
        return const SettingsPage();
      default:
        return const HomePage();
    }
  }

  @override
  void initState() {
    super.initState();
    navController = MainNavigator(
      onHome: () {
        setPage("home");
      },
      onProfile: () {
        setPage("profile");
      },
      onSettings: () {
        setPage("settings");
      },
    );
  }

  void setPage(String page) {
    _selectedPage = page;
    setState(() {});
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
            child: _selectedWidget(),
          ),
        ),
      ),
    );
  }
}

class MainNavigator extends StatelessWidget {
  const MainNavigator({
    super.key,
    required this.onProfile,
    required this.onHome,
    required this.onSettings,
  });

  final VoidCallback onProfile;
  final VoidCallback onHome;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return Container(
      height: [size.width * 0.4, 100.0].reduce(min),
      width: size.width,
      color: theme.colorScheme.primaryContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: RawMaterialButton(
              shape: const CircleBorder(),
              constraints: BoxConstraints.tight(
                Size(
                  [size.width * 0.3, 90.0].reduce(min),
                  [size.width * 0.3, 90.0].reduce(min),
                ),
              ),
              onPressed: onProfile,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 30,
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: RawMaterialButton(
              shape: CircleBorder(
                side: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 5,
                ),
              ),
              fillColor: theme.colorScheme.primary.withBlue(66).withGreen(66),
              constraints: BoxConstraints.tight(
                Size(
                  [size.width * 0.3, 90.0].reduce(min),
                  [size.width * 0.3, 90.0].reduce(min),
                ),
              ),
              onPressed: onHome,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home,
                    size: 30,
                    color: theme.colorScheme.onPrimary,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: RawMaterialButton(
              shape: const CircleBorder(),
              constraints: BoxConstraints.tight(
                Size(
                  [size.width * 0.3, 90.0].reduce(min),
                  [size.width * 0.3, 90.0].reduce(min),
                ),
              ),
              onPressed: onSettings,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings,
                    size: 30,
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
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
