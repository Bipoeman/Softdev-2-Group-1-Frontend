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

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: size.height * 0.32,
          decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(size.height * 0.2),
                bottomLeft: Radius.circular(size.height * 0.2),
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Divider(
                height: 20,
                thickness: 5,
                indent: 20,
                endIndent: 0,
                color: const Color(0xffd33333),
              ),
              Text(
                "John Doee",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(
                    size.height * 0.15 / 2,
                  ),
                ),
                height: size.height * 0.15,
                width: size.height * 0.15,
              ),
            ],
          ),
        ),
        Divider(
          height: 20,
          thickness: 0.1,
          indent: 20,
          endIndent: 0,
          color: const Color(0xffe8e8e8),
        ),
        Column(
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text("John Doe"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                print("You might want to edit username");
              },
            ),
            Divider(
              height: 4,
              thickness: 1,
              indent: 20,
              endIndent: 0,
              color: Color.fromARGB(44, 109, 108, 108),
            ),
            ListTile(
              leading: Icon(Icons.email_outlined),
              title: Text("123@12mail.com"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                print("You might want to edit email");
              },
            ),
            Divider(
              height: 4,
              thickness: 1,
              indent: 20,
              endIndent: 0,
              color: Color.fromARGB(44, 109, 108, 108),
            ),
            ListTile(
              leading: Icon(Icons.calendar_month_outlined),
              title: Text("30/2/2069"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                print("You might want to edit birthday");
              },
            ),
            Divider(
              height: 4,
              thickness: 1,
              indent: 20,
              endIndent: 0,
              color: Color.fromARGB(44, 109, 108, 108),
            ),
            ListTile(
              leading: Icon(Icons.phone_outlined),
              title: Text("082816888888"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                print("You might want to edit phone number");
              },
            ),
          ],
        ),
      ],
    );
  }
}

// waiting to be replaced in the future

class _ProfilePageState2 extends State<ProfilePage> {
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
            Center(
              heightFactor: 5,
              child: Text(
                "John Doe",
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Username:",
                    style: TextStyle(
                      color: theme.colorScheme.onBackground,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "John_Doe",
                    style: TextStyle(
                      color: theme.colorScheme.onBackground,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Email:",
                    style: TextStyle(
                      color: theme.colorScheme.onBackground,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "John_Doe@example.com",
                    style: TextStyle(
                      color: theme.colorScheme.onBackground,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Birth Date:",
                    style: TextStyle(
                      color: theme.colorScheme.onBackground,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "02/02/1992",
                    style: TextStyle(
                      color: theme.colorScheme.onBackground,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Contact:",
                    style: TextStyle(
                      color: theme.colorScheme.onBackground,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "None",
                    style: TextStyle(
                      color: theme.colorScheme.onBackground,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
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

