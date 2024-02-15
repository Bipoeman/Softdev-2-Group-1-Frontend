import 'package:flutter/material.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TuachuaySearchBox extends StatefulWidget {
  const TuachuaySearchBox({super.key});

  static final GlobalKey<_TuachuaySearchBoxState> searchBoxKey =
      GlobalKey<_TuachuaySearchBoxState>();

  @override
  State<TuachuaySearchBox> createState() => _TuachuaySearchBoxState();
}

class _TuachuaySearchBoxState extends State<TuachuaySearchBox> {
  final searchText = TextEditingController();

  savesearchtext() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("searchText", searchText.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchText,
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
            color: Color.fromRGBO(0, 48, 73, 1),
          ),
          child: IconButton(
            onPressed: () {
              searchText.text.isNotEmpty
                  ? (
                      Navigator.pushNamed(
                          context, tuachuayDekhorPageRoute["search"]!),
                      savesearchtext()
                    )
                  : ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter a search term"),
                        duration: Duration(seconds: 2),
                      ),
                    );
            },
            icon: const Icon(
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
