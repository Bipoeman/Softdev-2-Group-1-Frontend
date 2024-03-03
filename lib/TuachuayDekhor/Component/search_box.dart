import 'package:flutter/material.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
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
    CustomThemes theme = ThemesPortal.appThemeFromContext(context, "TuachuayDekhor")!;
    Map<String, Color> customColors = theme.customColors;

    return TextFormField(
      controller: searchText,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {
        searchText.text.isNotEmpty
            ? (Navigator.pushNamed(context, tuachuayDekhorPageRoute["search"]!), savesearchtext())
            : ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: customColors["main"]!,
                  content: Text(
                    "Please enter a search term",
                    style: TextStyle(
                      color: customColors["onMain"]!,
                    ),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
      },
      cursorColor: customColors["main"]!,
      decoration: InputDecoration(
        fillColor: customColors["container"]!,
        filled: true,
        labelStyle: TextStyle(
          color: customColors["onContainer"]!.withOpacity(0.5),
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.only(left: 15),
        labelText: "Search for...",
        suffixIconColor: customColors["onMain"]!,
        suffixIcon: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: customColors["main"]!,
          ),
          child: IconButton(
            onPressed: () {
              searchText.text.isNotEmpty
                  ? (
                      Navigator.pushNamed(context, tuachuayDekhorPageRoute["search"]!),
                      savesearchtext()
                    )
                  : ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: customColors["main"]!,
                        content: Text(
                          "Please enter a search term",
                          style: TextStyle(
                            color: customColors["onMain"]!,
                          ),
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
            },
            icon: Icon(
              size: 14,
              Icons.search,
              color: customColors["onMain"]!,
            ),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(
            color: customColors["main"]!,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(
            color: customColors["main"]!,
          ),
        ),
      ),
    );
  }
}
