import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ruam_mitt/global_const.dart';

class TuachuayDekhorDetailReport extends StatefulWidget {
  const TuachuayDekhorDetailReport({super.key, required this.id_post});
  final int id_post;

  @override
  State<TuachuayDekhorDetailReport> createState() =>
      _TuachuayDekhorDetailReportState();
}

class _TuachuayDekhorDetailReportState
    extends State<TuachuayDekhorDetailReport> {
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
                    top: size.width * 0.04,
                    left: size.width * 0.04,
                  ),
                  child: GestureDetector(
                    child: const Row(
                      children: [
                        Icon(Icons.arrow_back_outlined),
                        SizedBox(width: 5),
                        Text("Back")
                      ],
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(size.width * 0.1,
                      size.width * 0.04, size.width * 0.1, size.width * 0.04),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          "lorem ipsum dolor sit amet",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      size.width * 0.1, 0, size.width * 0.1, size.width * 0.08),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reason:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          'lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      size.width * 0.1, 0, size.width * 0.1, size.width * 0.04),
                  padding: EdgeInsets.all(size.width * 0.04),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 48, 73, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://api.multiavatar.com/pumxni}.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: size.width * 0.04),
                          const Text(
                            'Name',
                            style: TextStyle(color: Colors.white),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              print("delete");
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.width * 0.04),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Title:",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              "Lorem Ipsum Dolor Sit Amet 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.width * 0.04),
                      Container(
                        constraints: const BoxConstraints(maxHeight: 200),
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(),
                        child: const IntrinsicHeight(
                          child: Image(
                            image: NetworkImage(
                              "https://behavioralscientist.org/wp-content/uploads/2020/11/daydream_-zedelius.jpg",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: size.width * 0.04),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Content:",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, consequat nibh.',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
