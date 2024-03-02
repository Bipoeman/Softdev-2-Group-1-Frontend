import 'dart:io';

import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ruam_mitt/Restroom/Component/theme.dart';
import 'package:ruam_mitt/global_var.dart';

class ReviewSlideBar extends StatefulWidget {
  const ReviewSlideBar({super.key, required this.cancelOnPressed});
  final Future<void> Function() cancelOnPressed;

  @override
  State<ReviewSlideBar> createState() => _ReviewSlideBarState();
}

class _ReviewSlideBarState extends State<ReviewSlideBar> {
  TextEditingController _ReviewtextController = TextEditingController();
  File? _image;
  int remainingCharacters = 0;
  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void updateRemainingCharacters() {
    setState(() {
      remainingCharacters = _ReviewtextController.text.length;
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    print("init");
    _ReviewtextController.addListener(updateRemainingCharacters);
  }

  @override
  void dispose() {
    _ReviewtextController.removeListener(updateRemainingCharacters);
    _ReviewtextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Theme(
        data: RestroomThemeData,
        child: Builder(builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(239, 239, 239, 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(profileData["profile"] ??
                            'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(profileData["username"],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RatingBar.builder(
                    glow: false,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.02),
                    child: ClayContainer(
                      width: size.width * 0.85,
                      height: size.height * 0.17,
                      color: Color(0xFFEAEAEA),
                      borderRadius: 30,
                      depth: -20,
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextField(
                            maxLength: 150,
                            maxLines: 4,
                            controller: _ReviewtextController,
                            // inputFormatters: [
                            //   LengthLimitingTextInputFormatter(80),
                            // ],
                            decoration: InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.only(left: 16, right: 16, bottom: 5),
                              hintText: 'Write a review...',
                            ),
                          ),
                          Positioned(
                            top: 1,
                            right: 16.0,
                            child: Text(
                              '$remainingCharacters/150',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // TextFormField(
                  //   onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                  //   cursorColor: Colors.black54,
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     fillColor: Colors.grey[300],
                  //     hintText: 'Write a review',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //       borderSide: const BorderSide(color: Colors.grey),
                  //     ),
                  //   ),
                  //   maxLines: 3,
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.02,
                    ),
                    child: InkWell(
                      onTap: () {
                        _getImage();
                      },
                      child: _image == null
                          ? Container(
                              padding: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 10, top: 10, bottom: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.camera_alt),
                                    SizedBox(width: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        'Add Photo',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(right: 0.5),
                              child: Expanded(
                                // ใช้ Expanded เพื่อให้รูปภาพขยายตามพื้นที่
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   style: ElevatedButton.styleFrom(
                  //     foregroundColor: Colors.black,
                  //     backgroundColor: Colors.grey[300],
                  //     surfaceTintColor: Colors.white,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(40),
                  //       side: const BorderSide(color: Colors.grey),
                  //     ),
                  //   ),
                  //   child: const Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Icon(Icons.camera_alt),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Text('Add Photo'),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: ElevatedButton(
                          onPressed: widget.cancelOnPressed,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.grey[300],
                            surfaceTintColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                              side: const BorderSide(color: Colors.grey),
                            ),
                          ),
                          child: Text(
                            "Cancel",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.amber,
                            surfaceTintColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                              side: const BorderSide(color: Colors.grey),
                            ),
                          ),
                          child: Text(
                            'Submit',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
