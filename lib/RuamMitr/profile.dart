import "package:flutter/material.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Center(
      child: Text(
        "There is nothing in \"Profile\" page yet.",
        style: TextStyle(
          color: theme.colorScheme.onBackground,
          fontSize: 20,
        ),
      ),
    );
  }
}
