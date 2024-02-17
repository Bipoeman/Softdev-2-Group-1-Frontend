import 'package:flutter/material.dart';
import 'package:ruam_mitt/global_const.dart';
import 'dart:math';

class MainNavigator extends StatelessWidget {
  MainNavigator({super.key, this.pageIndex});
  final pageIndex;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    int num = 0;
    return num == 0
        ? NavigationBar(
            selectedIndex: pageIndex ?? 1,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
              NavigationDestination(icon: Icon(Icons.home), label: "Home"),
              NavigationDestination(
                  icon: Icon(Icons.settings), label: "Settings")
            ],
            onDestinationSelected: (int index) {
              print(index);
              // String routeToNavigate = "";
              if (index == 0) {
                Navigator.pushNamed(
                  context,
                  ruamMitrPageRoute["profile"]!,
                );
              } else if (index == 2) {
                Navigator.pushNamed(
                  context,
                  ruamMitrPageRoute["settings"]!,
                );
              } else {
                if (ModalRoute.of(context)?.settings.name !=
                    ruamMitrPageRoute["home"]!) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    ruamMitrPageRoute["home"]!,
                    (route) => false,
                  );
                }
              }
            },
          )
        : Container(
            height: [size.width * 0.4, 80.0].reduce(min),
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
                    onPressed: () {
                      if (ModalRoute.of(context)?.settings.name !=
                          ruamMitrPageRoute["profile"]!) {
                        Navigator.pushNamed(
                          context,
                          ruamMitrPageRoute["profile"]!,
                        );
                      }
                    },
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
                    fillColor:
                        theme.colorScheme.primary.withBlue(66).withGreen(66),
                    constraints: BoxConstraints.tight(
                      Size(
                        [size.width * 0.3, 90.0].reduce(min),
                        [size.width * 0.3, 90.0].reduce(min),
                      ),
                    ),
                    onPressed: () {
                      if (ModalRoute.of(context)?.settings.name !=
                          ruamMitrPageRoute["home"]!) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          ruamMitrPageRoute["home"]!,
                          (route) => false,
                        );
                      }
                    },
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
                    onPressed: () {
                      if (ModalRoute.of(context)?.settings.name !=
                          ruamMitrPageRoute["settings"]!) {
                        Navigator.pushNamed(
                          context,
                          ruamMitrPageRoute["settings"]!,
                        );
                      }
                    },
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
