import 'package:flutter/material.dart';

class TuachuaySearchBox extends StatefulWidget {
  const TuachuaySearchBox({super.key});

  @override
  State<TuachuaySearchBox> createState() => _TuachuaySearchBoxState();
}

class _TuachuaySearchBoxState extends State<TuachuaySearchBox> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelStyle: TextStyle(
          color: Colors.black.withOpacity(0.5),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        labelText: "Search for...",
        suffixIconColor: Colors.white,
        suffixIcon: Container(
          height: 1,
          width: 1,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 48, 73, 1),
            borderRadius: BorderRadius.circular(40),
          ),
          child: const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(color: Color.fromRGBO(0, 48, 73, 1)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(color: Color.fromRGBO(0, 48, 73, 1)),
        ),
      ),
    );
  }
}
