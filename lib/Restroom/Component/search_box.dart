import 'package:flutter/material.dart';



class RestroomSearchBox extends StatefulWidget {
  const RestroomSearchBox({super.key});

  @override
  State<RestroomSearchBox> createState() => _RestroomSearchBoxState();
}

class _RestroomSearchBoxState extends State<RestroomSearchBox> {
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
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.only(left: 15),
        labelText: "Search for...",
        suffixIconColor: Colors.white,
        suffixIcon: Container(
          margin: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 255, 0, 183),
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