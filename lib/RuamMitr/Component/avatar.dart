import 'package:flutter/material.dart';
import 'dart:math';

class AvatarViewer extends StatelessWidget {
  const AvatarViewer({super.key, this.username, this.avatarUrl});
  final String? username;
  final String? avatarUrl;

  Widget getAvatar() {
    if (avatarUrl != null) {
      try {
        return CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(avatarUrl!),
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return const CircleAvatar(
      radius: 30,
      backgroundColor: Colors.grey,
      child: Icon(
        Icons.person,
        size: 25,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: IntrinsicWidth(
        child: RawMaterialButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          constraints: const BoxConstraints(),
          onPressed: () {
            if (ModalRoute.of(context)!.settings.name != "/profile") {
              Navigator.pushNamed(context, "/profile");
            }
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    username ?? "John Doe",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: getAvatar(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}