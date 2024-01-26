import 'package:flutter/material.dart';
import 'package:ruam_mitt/Component/text_field.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return textField(
      labelText: "Search Here",
      fillColor: Colors.white,
      icon: Icon(
        Icons.search,
        color: theme.colorScheme.primary,
      ),
      onChanged: (value) {
        setState(() {
          searchText = value;
        });
        debugPrint(searchText);
      },
    );
  }
}
