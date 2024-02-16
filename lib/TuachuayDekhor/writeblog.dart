import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';

class TuachuayDekhorWriteBlogPage extends StatefulWidget {
  const TuachuayDekhorWriteBlogPage({super.key});

  @override
  State<TuachuayDekhorWriteBlogPage> createState() =>
      _TuachuayDekhorWriteBlogPageState();
}

class _TuachuayDekhorWriteBlogPageState
    extends State<TuachuayDekhorWriteBlogPage> {
  String? _dropdownValue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: size.height -
                        [size.width * 0.4, 100.0].reduce(min) -
                        MediaQuery.of(context).padding.top),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.12,
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
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                        right: size.width * 0.04,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: const Text(
                              "DRAFTS",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 48, 73, 1),
                              ),
                            ),
                            onTap: () {
                              print("Drafts tapped");
                            },
                          ),
                          Container(
                            width: 70,
                            margin: const EdgeInsets.only(left: 20, right: 10),
                            child: RawMaterialButton(
                              onPressed: () {
                                print("Post tapped");
                              },
                              fillColor: const Color.fromRGBO(217, 192, 41, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              child: const Text("POST"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                        left: size.width * 0.12,
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            height: 30,
                            width: size.width * 0.55,
                            child: TextFormField(
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.black.withOpacity(0.5),
                              cursorHeight: 18,
                              decoration: InputDecoration(
                                fillColor: Colors.grey.withOpacity(0.3),
                                filled: true,
                                labelText: "Write a title",
                                labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                        left: size.width * 0.2,
                      ),
                      width: size.width * 0.85,
                      child: TextFormField(
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                        keyboardType: TextInputType.multiline,
                        cursorColor: Colors.black.withOpacity(0.5),
                        cursorHeight: 16,
                        minLines: 15,
                        maxLines: null,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          fillColor: Colors.grey.withOpacity(0.3),
                          filled: true,
                          labelText: "Write a blog",
                          labelStyle: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: size.width * 0.12,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(0, 48, 73, 1),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: DropdownButton(
                        underline: const SizedBox(),
                        padding: const EdgeInsets.only(left: 10),
                        hint: const Text("Select Category", style: TextStyle(fontSize: 12),),
                        dropdownColor: Colors.white,
                        iconEnabledColor: Colors.black,
                        items: const [
                          DropdownMenuItem(
                            value: "public",
                          child: Text("Public", style: TextStyle(fontSize: 12),),
                          ),
                          DropdownMenuItem(
                            value: "private",
                            child: Text("Private", style: TextStyle(fontSize: 12),),
                          ),
                        ],
                        value: _dropdownValue,
                        onChanged: (value) {
                          setState(
                            () {
                              _dropdownValue = value;
                            },
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        print("Add image tapped");
                      },
                      icon: const Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                    ),
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
