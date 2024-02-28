import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/global_const.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    ThemeProvider themes = Provider.of<ThemeProvider>(context);
    return Theme(
      data: theme,
      child: Container(
        decoration: ruamMitrBackgroundGradient(themes),
        child: Scaffold(
          backgroundColor: Colors.transparent,
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
          body: Column(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 50),
                  height: size.width * (588 / 738) / (588 / 85),
                  width: size.width * (588 / 738),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Container(
                      decoration: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          color: theme.colorScheme.primary,
                          width: 3,
                        ),
                      ),
                      child: Text(
                        "Issues",
                        style: TextStyle(
                          fontFamily: GoogleFonts.getFont("Inter").fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
