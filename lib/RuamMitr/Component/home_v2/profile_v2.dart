import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ruam_mitt/global_var.dart';

class ProfileWidgetV2 extends StatefulWidget {
  const ProfileWidgetV2({super.key});

  @override
  State<ProfileWidgetV2> createState() => _ProfileWidgetV2State();
}

class _ProfileWidgetV2State extends State<ProfileWidgetV2> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size.height -
              [size.width * 0.4, 100.0].reduce(min) -
              MediaQuery.of(context).padding.top,
        ),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.topCenter,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -[size.width * 0.6, 300.0].reduce(min),
                  left:
                      size.width * 0.5 - [size.width * 0.6, 300.0].reduce(min),
                  child: CustomPaint(
                    painter: HalfCirclePainter(
                      color: theme.colorScheme.primary,
                    ),
                    size: Size(
                      [size.width * 1.2, 600.0].reduce(min),
                      [size.width * 0.6, 300.0].reduce(min),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      width: 175,
                      height: 175,
                      margin: EdgeInsets.only(
                        top: [size.width * 0.6, 300.0].reduce(min) - 175 * 0.6,
                      ),
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colorScheme.primaryContainer,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            profileData['profile'] ??
                                "https://ui-avatars.com/api/?size=512&name=${profileData['fullname'].replaceAll(" ", "+")}",
                          ),
                        ),
                      ),
                    ),
                    Positioned.directional(
                      textDirection: TextDirection.ltr,
                      bottom: 10,
                      end: 10,
                      child: GestureDetector(
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(Icons.edit),
                        ),
                        onTap: () {
                          print("You might want to change profile image");
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                    0,
                    [
                      ([size.width * 0.6, 300.0].reduce(min) - 175) * 0.5,
                      0.0,
                    ].reduce(max),
                    0,
                    0,
                  ),
                  child: Center(
                    child: Text(
                      profileData['fullname'],
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(profileData['fullname']),
                    trailing: const Icon(Icons.edit),
                    onTap: () {
                      debugPrint("You might want to edit username");
                    },
                  ),
                  const Divider(
                    height: 4,
                    thickness: 1,
                    indent: 20,
                    endIndent: 0,
                    color: Color.fromARGB(44, 109, 108, 108),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email_outlined),
                    title: Text(profileData['email']),
                    trailing: const Icon(Icons.edit),
                    onTap: () {
                      debugPrint("You might want to edit email");
                    },
                  ),
                  const Divider(
                    height: 4,
                    thickness: 1,
                    indent: 20,
                    endIndent: 0,
                    color: Color.fromARGB(44, 109, 108, 108),
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_month_outlined),
                    title: Text(profileData['birthday'] ?? "Not provided"),
                    trailing: const Icon(Icons.edit),
                    onTap: () {
                      debugPrint("You might want to edit birthday");
                    },
                  ),
                  const Divider(
                    height: 4,
                    thickness: 1,
                    indent: 20,
                    endIndent: 0,
                    color: Color.fromARGB(44, 109, 108, 108),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone_outlined),
                    title: Text(profileData['phonenum']),
                    trailing: const Icon(Icons.edit),
                    onTap: () {
                      debugPrint("You might want to edit phone number");
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit_document),
                    title: const Text("Edit you desciption"),
                    trailing: const Icon(Icons.edit),
                    onTap: () {
                      debugPrint("You might want to edit description");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HalfCirclePainter extends CustomPainter {
  final Color color;

  HalfCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height);

    final path = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(
        Rect.fromCircle(center: center, radius: radius),
        0,
        pi,
        false,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(HalfCirclePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
