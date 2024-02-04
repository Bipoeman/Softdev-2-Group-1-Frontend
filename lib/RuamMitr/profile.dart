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
