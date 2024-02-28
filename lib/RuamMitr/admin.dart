import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: theme.colorScheme.onPrimary,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: theme.colorScheme.primary,
          title: Text(
            "Administrator",
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
