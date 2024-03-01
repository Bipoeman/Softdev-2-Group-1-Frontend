import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
                          const Text('Posting publicly'),
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
                      color: const Color(0xFFEAEAEA),
                      borderRadius: 30,
                      depth: -20,
                      child: TextField(
                        controller: _ReviewtextController,
                        onChanged: (text) {
                          print('Typed text: $text');
                        },
                        maxLines: null,
                        // textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 10.0),
                          hintText: 'Write a review...',
                        ),
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
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey[300],
                      surfaceTintColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Add Photo'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
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
                      ElevatedButton(
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
                    ],
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
