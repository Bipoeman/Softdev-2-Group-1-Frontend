import 'package:flutter/material.dart';

class SearchBin extends StatefulWidget {
  const SearchBin({super.key});

  @override
  State<SearchBin> createState() => _SearchBinState();
}

class _SearchBinState extends State<SearchBin> {
  String searchText = '';
  final search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: search, //สร้างไว้ก่อน
      keyboardType: TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        fillColor: Colors.black.withOpacity(0.5),
        filled: true,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.69),
          fontSize: 16,
        ),
        contentPadding: const EdgeInsets.only(left: 15),
        hintText: "Search...",
        suffixIconColor: Colors.white.withOpacity(0.69),
        suffixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
