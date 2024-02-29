import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/global_const.dart';

enum App { ruammitr, dekhor, restroom, pinthebin, dinodengzz }

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
          body: RefreshIndicator(
            onRefresh: () async {},
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  AdminHeader(size, theme),
                  ReportCard(
                    size: size,
                    theme: theme,
                    topic: "Better UI",
                    explaination:
                        "adasdsjgfdfghlgsdkjghdfslgkdsfhgdlfkgjdhgldfkgjhdslgkdfjgh",
                    user: const {"fullname": "John Doe"},
                    fromApp: App.ruammitr,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center AdminHeader(Size size, ThemeData theme) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 50, bottom: 40),
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
    );
  }
}

class ReportCard extends StatefulWidget {
  const ReportCard({
    super.key,
    required this.size,
    required this.theme,
    required this.topic,
    required this.explaination,
    required this.user,
    required this.fromApp,
  });
  final Map<String, dynamic> user;
  final String topic;
  final String explaination;
  final Size size;
  final ThemeData theme;
  final App fromApp;

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  Map<App, Color> appColor = const {
    App.ruammitr: Color(0xFFD62828),
    App.dekhor: Color(0xFF003049),
    App.restroom: Color(0xFFFFB703),
    App.pinthebin: Color(0xFFF77F00),
    App.dinodengzz: Color(0xFF0A9396),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: () {},
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: widget.size.width * (570 / 738),
          height: widget.size.width * (570 / 738) / (570 / 152),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFEEEEEE),
          ),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                margin: const EdgeInsets.only(left: 10, right: 10),
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 15,
                        height: 15,
                        color: appColor[widget.fromApp],
                      ),
                      Text(widget.topic)
                    ],
                  ),
                  SizedBox(
                    width: widget.size.width * (570 / 738) * 0.7,
                    child: Text(
                      "Explanation : ${widget.explaination}",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text("User : ${widget.user['fullname']}")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
