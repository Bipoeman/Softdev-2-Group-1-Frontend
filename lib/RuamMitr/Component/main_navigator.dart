import 'package:flutter/material.dart';
import 'dart:math';

class MainNavigator extends StatelessWidget {
  const MainNavigator({
    super.key,
  });

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
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name != "/RuamMitr/profile") {
                  Navigator.pushNamed(
                    context,
                    "/RuamMitr/profile",
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
              fillColor: theme.colorScheme.primary.withBlue(66).withGreen(66),
              constraints: BoxConstraints.tight(
                Size(
                  [size.width * 0.3, 90.0].reduce(min),
                  [size.width * 0.3, 90.0].reduce(min),
                ),
              ),
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name != "/RuamMitr/home") {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    "/RuamMitr/home",
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
                if (ModalRoute.of(context)?.settings.name != "/RuamMitr/settings") {
                  Navigator.pushNamed(
                    context,
                    "/RuamMitr/settings",
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
