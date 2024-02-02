import 'package:flutter/material.dart';

class AvatarViewer extends StatelessWidget {
  const AvatarViewer({
    super.key,
    this.username,
    this.avatarUrl,
    required this.onPressed,
  });
  final String? username;
  final String? avatarUrl;
  final VoidCallback onPressed;

  Widget getAvatar(BuildContext context) {
    ThemeData theme = Theme.of(context);
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
      backgroundColor: theme.colorScheme.primaryContainer.withOpacity(0.5),
      child: const Icon(
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
          onPressed: onPressed,
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
                  child: getAvatar(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
