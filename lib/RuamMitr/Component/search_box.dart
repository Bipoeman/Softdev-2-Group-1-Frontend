import 'package:flutter/material.dart';

class CustomSearchBox extends StatefulWidget {
  const CustomSearchBox({super.key});

  @override
  State<CustomSearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<CustomSearchBox> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        fillColor: theme.colorScheme.primaryContainer,
        filled: true,
        labelStyle: TextStyle(
          color: theme.colorScheme.onBackground.withOpacity(0.5),
        ),
        contentPadding: const EdgeInsets.fromLTRB(30, 0, 5, 0),
        labelText: "Search for...",
        prefixIconColor: Colors.white,
        prefixIcon: Icon(
          Icons.search,
          color: theme.colorScheme.primary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
