import 'package:flutter/material.dart';
import 'dart:math';

class MainNavigator extends StatelessWidget {
  const MainNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return Container(
      height: [size.height * 0.4, size.width * 0.4, 100.0].reduce(min),
      width: size.width,
      color: theme.hoverColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: RawMaterialButton(
              shape: const CircleBorder(),
              constraints: BoxConstraints.tight(
                Size(
                  [size.height * 0.5, size.width * 0.3, 90.0].reduce(min),
                  [size.height * 0.5, size.width * 0.3, 90.0].reduce(min),
                ),
              ),
              onPressed: () {
                if (ModalRoute.of(context)!.settings.name != "/profile") {
                  Navigator.pushNamed(context, "/profile");
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
                  color: Colors.red[700] ?? const Color.fromRGBO(211, 47, 47, 1),
                  width: 5,
                ),
              ),
              fillColor: Colors.red,
              constraints: BoxConstraints.tight(
                Size(
                  [size.height * 0.5, size.width * 0.3, 90.0].reduce(min),
                  [size.height * 0.5, size.width * 0.3, 90.0].reduce(min),
                ),
              ),
              onPressed: () {
                if (ModalRoute.of(context)!.settings.name != "/home") {
                  Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
                }
              },
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home,
                    size: 30,
                    color: Colors.white,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                  [size.height * 0.5, size.width * 0.3, 90.0].reduce(min),
                  [size.height * 0.5, size.width * 0.3, 90.0].reduce(min),
                ),
              ),
              onPressed: () {
                if (ModalRoute.of(context)!.settings.name != "/settings") {
                  Navigator.pushNamed(context, "/settings");
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

class BoxWithMainNavigator extends StatelessWidget {
  const BoxWithMainNavigator({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: child ?? const Column(),
          ),
          const MainNavigator(),
        ],
      ),
    );
  }
}
