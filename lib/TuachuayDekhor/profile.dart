import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'package:flutter/services.dart';

class TuachuayDekhorProfilePage extends StatefulWidget {
  const TuachuayDekhorProfilePage({Key? key}) : super(key: key);

  @override
  State<TuachuayDekhorProfilePage> createState() =>
      _TuachuayDekhorProfilePageState();
}

class _TuachuayDekhorProfilePageState extends State<TuachuayDekhorProfilePage> {
  bool user = true;
  String? description;
  bool isEditing = false;
  bool showMore = false;
  bool isPostSelected = true;
  bool isSaveSelected = false;

  void updateDescription(String value) {
    setState(() {
      description = value;
    });
  }

  final TextEditingController _controller = TextEditingController();
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
                  MediaQuery.of(context).padding.top,
            ),
            child: Column(
              children: [
                const NavbarTuachuayDekhor(),
                SizedBox(
                  width: size.width * 0.7,
                  height: size.width * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.person,
                          size: 30,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.05),
                        child: const Text(
                          "John Doe",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.325,
                      right: size.width * 0.2,
                      bottom: size.width * 0.05,
                      top: size.width * 0.005),
                  child: user
                      ? isEditing
                          ? TextFormField(
                              controller: _controller,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(100),
                              ],
                              decoration: InputDecoration(
                                hintText: 'describe yourself',
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                suffixIcon: isEditing
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            updateDescription(_controller.text);
                                            isEditing = false;
                                          });
                                        },
                                        icon: const Icon(Icons.save),
                                      )
                                    : null,
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isEditing = true;
                                    });
                                  },
                                  child: SizedBox(
                                    width: size.width * 0.7,
                                    child: Text(
                                      description ?? 'click to add description',
                                      maxLines: showMore ? null : 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                if ((description ?? '').split('\n').length > 4)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showMore = !showMore;
                                      });
                                    },
                                    child: Text(
                                      showMore ? 'less' : 'more',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            )
                      : const Text('can\'t edit other\'s description'),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.1,
                      right: size.width * 0.1,),
                  child: Container(
                    width: size.width * 0.8,
                    height: size.width * 0.03,
                    color: const Color.fromRGBO(0, 48, 73, 1)
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.1,
                      right: size.width * 0.1,
                      bottom: size.width * 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isPostSelected = true;
                            isSaveSelected = false;
                          });
                        },
                        child: Container(
                          width: size.width * 0.4,
                          height: size.width * 0.1,
                          decoration: BoxDecoration(
                            color: isPostSelected
                                ? const Color.fromRGBO(0, 48, 73, 1)
                                : const Color.fromRGBO(217, 217, 217, 1),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          child: Center(
                            child: Text(
                              'Post',
                              style: TextStyle(
                                color: isPostSelected
                                    ? const Color.fromRGBO(217, 217, 217, 1)
                                    : const Color.fromRGBO(0, 48, 73, 1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isPostSelected = false;
                            isSaveSelected = true;
                          });
                        },
                        child: Container(
                          width: size.width * 0.4,
                          height: size.width * 0.1,
                          decoration: BoxDecoration(
                            color: isSaveSelected
                                ? const Color.fromRGBO(0, 48, 73, 1)
                                : const Color.fromRGBO(217, 217, 217, 1),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          child: Center(
                            child: Text(
                              'Save',
                              style: TextStyle(
                                color: isSaveSelected
                                    ? const Color.fromRGBO(217, 217, 217, 1)
                                    : const Color.fromRGBO(0, 48, 73, 1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
