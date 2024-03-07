import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ruam_mitt/Restroom/Component/font.dart';
import 'package:ruam_mitt/Restroom/Component/theme.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_func.dart';
import 'package:ruam_mitt/global_var.dart';

class ReviewSlideBar extends StatefulWidget {
  const ReviewSlideBar(
      {super.key, required this.restroomData, required this.closeSlidingBox});
  final Map<String, dynamic> restroomData;
  final Future<void> Function() closeSlidingBox;

  @override
  State<ReviewSlideBar> createState() => _ReviewSlideBarState();
}

class _ReviewSlideBarState extends State<ReviewSlideBar> {
  final TextEditingController _reviewTextController = TextEditingController();
  File? _image;
  double _rating = 0.0;
  int reviewTextLength = 0;
  Future<void> _getImage() async {
    bool? isCamera = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Camera"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("gallery "),
            ),
          ],
        ),
      ),
    );

    if (isCamera == null) return;
    final pickedFile = await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Future<void> _postReview() async {
    await requestNewToken(context);
    debugPrint("post review");
    final url = Uri.parse("$api$restroomRoverReviewRoute");
    var response = await http
        .post(url, headers: {
          "Authorization": "Bearer $publicToken"
        }, body: {
          "id_toilet": widget.restroomData["id"].toString(),
          "star": _rating.toString(),
          "comment": _reviewTextController.text
        })
        .timeout(const Duration(seconds: 10))
        .onError((error, stackTrace) {
          return Future.error(error ?? {}, stackTrace);
        });
    debugPrint(response.body);
    if (response.statusCode != 200) {
      return Future.error(response.reasonPhrase ?? "Failed to post review.");
    }
    int reviewId = jsonDecode(response.body)["id"];
    if (_image != null) {
      await _uploadPicture(reviewId.toString(), _image)
          .onError((error, stackTrace) async {
        await _delReview(reviewId);
        return Future.error(error ?? "Failed to upload picture.", stackTrace);
      });
    }
  }

  Future<http.Response> _uploadPicture(id, picture) async {
    final url = Uri.parse("$api$restroomRoverUploadReviewPictureRoute");
    http.MultipartRequest request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      "Authorization": "Bearer $publicToken",
      "Content-Type": "application/json"
    });
    request.files.add(
      http.MultipartFile.fromBytes(
        "file",
        File(picture.path).readAsBytesSync(),
        filename: picture.path,
        contentType:
            MediaType.parse(lookupMimeType(picture.path) ?? "image/jpeg"),
      ),
    );
    request.fields['id'] = id;
    try {
      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) {
        return Future.error(response.reasonPhrase ?? "Failed to send report");
      }
      http.Response res = await http.Response.fromStream(response)
          .timeout(const Duration(seconds: 10));
      return res;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<http.Response> _delReview(int id) async {
    await requestNewToken(context);
    Uri url = Uri.parse("$api$restroomRoverReviewRoute/$id");
    http.Response res = await http.delete(url, headers: {
      "Authorization": "Bearer $publicToken"
    }).timeout(const Duration(seconds: 10));
    debugPrint(res.body);
    if (res.statusCode != 200) {
      return Future.error(res.reasonPhrase ?? "Failed to delete restroom");
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Theme(
        data: RestroomThemeData,
        child: Builder(builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(239, 239, 239, 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(profileData["imgPath"]),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(profileData["fullname"],
                              style:
                                  name_place(profileData["fullname"], context)),
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
                    initialRating: _rating,
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                      debugPrint(_rating.toString());
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          style:
                              text_input(_reviewTextController.text, context),
                          maxLength: 150,
                          maxLines: null,
                          controller: _reviewTextController,
                          onChanged: (text) {
                            setState(() {
                              reviewTextLength = text.length;
                            });
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r"\n"))
                          ],
                          decoration: const InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            hintText: 'Write a review...',
                          ),
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.05),
                        child: IntrinsicWidth(
                          child: Text(
                            "$reviewTextLength/150",
                            style: text_input("", context),
                          ),
                        ),
                      )
                    ],
                  ),
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
                                    const Icon(Icons.camera_alt),
                                    const SizedBox(width: 10),
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
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: ElevatedButton(
                          onPressed: widget.closeSlidingBox,
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
                          onPressed: () {
                            _postReview().then((value) {
                              Navigator.pushReplacementNamed(
                                  context, restroomPageRoute["review"]!,
                                  arguments: {
                                    ...widget.restroomData,
                                    "avg_star":
                                        (widget.restroomData["avg_star"] +
                                                _rating) /
                                            (widget.restroomData["count"] + 1),
                                    "count": widget.restroomData["count"] + 1,
                                  });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Review posted.")));
                            }).onError((error, stackTrace) {
                              debugPrint(error.toString());
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Failed to post review.",
                                    style: TextStyle(
                                      color: theme.colorScheme.onPrimary,
                                    ),
                                  ),
                                  backgroundColor: theme.colorScheme.primary,
                                ),
                              );
                            });
                          },
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
