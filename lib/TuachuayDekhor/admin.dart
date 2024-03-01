import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ruam_mitt/global_const.dart';

class TuachuayDekhorAdminPage extends StatefulWidget {
  const TuachuayDekhorAdminPage({super.key});

  @override
  State<TuachuayDekhorAdminPage> createState() =>
      _TuachuayDekhorAdminPageState();
}

class _TuachuayDekhorAdminPageState extends State<TuachuayDekhorAdminPage> {
  final item = List.generate(20, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: size.height -
                    [size.width * 0.4, 100.0].reduce(min) -
                    MediaQuery.of(context).padding.top),
            child: Column(
              children: [
                Container(
                  color: const Color.fromRGBO(0, 48, 73, 1),
                  width: size.width,
                  height: size.width * 0.2,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.pushNamed(
                          context, tuachuayDekhorPageRoute["home"]!);
                    },
                    child: const Image(
                      image: AssetImage(
                          "assets/images/Logo/TuachuayDekhor_Dark.png"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.width * 0.05, bottom: size.width * 0.05),
                  child: const Text(
                    "ALL REPORTS",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    final item = this.item[index];
                    return Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                      child: Dismissible(
                        key: Key(item),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            this.item.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Item dismissed"),
                            ),
                          );
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 10),
                          color: Colors.red,
                          child: const Icon(Icons.delete),
                        ),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          color: Colors.grey[300],
                          child: ListTile(
                            title: Text(item),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
