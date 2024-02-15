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
      cursorColor: const Color.fromRGBO(0, 48, 73, 1),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelStyle: TextStyle(
          color: Colors.black.withOpacity(0.5),
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.only(left: 15),
        labelText: "Search for...",
        suffixIconColor: Colors.white,
        suffixIcon: Container(
          margin: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(0, 48, 73, 1),
          ),
          child: const IconButton(
            onPressed: null,
            icon: Icon(
              size: 14,
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
