import 'package:flutter/material.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';

class TuachuayDekhorAvatarViewer extends StatelessWidget {
  const TuachuayDekhorAvatarViewer({
    super.key,
    this.username,
    this.avatarUrl,
  });

  final String? username;
  final String? avatarUrl;

  Widget getAvatar(BuildContext context) {
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
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.white.withOpacity(0.5),
      backgroundImage: NetworkImage(profileData['imgPath'] ?? avatarUrl ?? ""),
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
            Navigator.pushNamed(context, tuachuayDekhorPageRoute["profile"]!);
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: getAvatar(context),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: const Color.fromRGBO(0, 48, 73, 1),
                    ),
                    height: 24,
                    width: 68.5,
                    child: Text(
                      username ?? "John Doe",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
