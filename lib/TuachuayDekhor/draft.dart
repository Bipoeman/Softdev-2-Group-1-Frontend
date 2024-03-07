import 'package:flutter/material.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/blog_box.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'dart:math';
import 'dart:convert';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:http/http.dart' as http;

class TuachuayDekhorDraftPage extends StatefulWidget {
  const TuachuayDekhorDraftPage({super.key});

  @override
  State<TuachuayDekhorDraftPage> createState() =>
      _TuachuayDekhorDraftPageState();
}

class _TuachuayDekhorDraftPageState extends State<TuachuayDekhorDraftPage> {
  var draft = [];
  final draftposturl = Uri.parse("$api$dekhorPosttoDraftRoute");
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  Future<void> posttodraft() async {
    var response = await http
        .get(draftposturl, headers: {"Authorization": "Bearer $publicToken"});
    if (response.statusCode == 200) {
      setState(() {
        draft = jsonDecode(response.body);
        print(draft);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _loadDetail() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2), () {});
    await posttodraft();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CustomThemes theme =
        ThemesPortal.appThemeFromContext(context, "TuachuayDekhor")!;
    Map<String, Color> customColors = theme.customColors;

    return Scaffold(
      backgroundColor: customColors["background"]!,
      body: SafeArea(
        child: Stack(
          children: [
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: customColors["main"]!,
                    ),
                  )
                : SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: size.height -
                            [size.width * 0.4, 100.0].reduce(min) -
                            MediaQuery.of(context).padding.top,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.12,
                              left: size.width * 0.04,
                            ),
                            child: GestureDetector(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back_outlined,
                                    color: customColors["main"]!,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Back",
                                    style:
                                        TextStyle(color: customColors["main"]!),
                                  ),
                                ],
                              ),
                              onTap: () => Navigator.pop(context),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: size.width * 0.1,
                              right: size.width * 0.1,
                              top: size.width * 0.05,
                              bottom: size.width * 0.05,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Yours Draft',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: customColors["main"]!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width * 0.8,
                            height: size.width * 0.02,
                            color: customColors["main"]!,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: size.width * 0.05,
                                left: size.width * 0.07,
                                right: size.width * 0.07,
                                top: size.width * 0.05),
                            child: MasonryGridView.builder(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              itemCount: draft.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: ((context, index) => BlogBox(
                                    title: draft[index]['title'],
                                    name: draft[index]['user']['fullname'],
                                    category: draft[index]['category'],
                                    like: draft[index]['save'] ?? "0",
                                    image: NetworkImage(
                                      draft[index]['image_link'],
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        tuachuayDekhorPageRoute['editdraft']!,
                                        arguments: draft[index]['id_draft'],
                                      );
                                    },
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
            const NavbarTuachuayDekhor(),
          ],
        ),
      ),
    );
  }
}
