import "package:flutter/material.dart";
import 'dart:math';

Color backgroundColor = const Color(0xffe8e8e8);
Color mainColor = const Color(0xffd33333);
Color textColor = const Color(0xff000000);

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
// waiting to be replaced in the future

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.topCenter,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -[size.width * 0.6, 300.0].reduce(min),
              left: size.width * 0.5 - [size.width * 0.6, 300.0].reduce(min),
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
            Container(
              width: 175,
              height: 175,
              margin: EdgeInsets.fromLTRB(
                0,
                [size.width * 0.6, 300.0].reduce(min) - 175 * 0.6,
                0,
                0,
              ),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primaryContainer,
              ),
              child: Icon(
                Icons.person,
                size: 100,
                color: theme.colorScheme.onPrimaryContainer,
              ),
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
                  "John Doe",
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
                title: const Text("John Doe"),
                trailing: const Icon(Icons.arrow_forward_ios),
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
                title: const Text("123@12mail.com"),
                trailing: const Icon(Icons.arrow_forward_ios),
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
                title: const Text("30/2/2069"),
                trailing: const Icon(Icons.arrow_forward_ios),
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
                title: const Text("082816888888"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  debugPrint("You might want to edit phone number");
                },
              ),
            ],
          ),
        ),
      ],
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
