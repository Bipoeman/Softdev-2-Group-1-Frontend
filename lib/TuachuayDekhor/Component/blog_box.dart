import 'package:flutter/material.dart';

class BlogBox extends StatelessWidget {
  const BlogBox({
    super.key,
    required this.title,
    required this.name,
    required this.like,
    required this.image,
    required this.onPressed,
  });
  final void Function()? onPressed;
  final ImageProvider<Object> image;
  final String title;
  final String name;
  final String like;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: IntrinsicWidth(
        child: RawMaterialButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          fillColor: Colors.white,
          constraints: const BoxConstraints(),
          onPressed: onPressed,
          child: Container(
            margin: const EdgeInsets.only(
              top: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    right: 10,
                    left: 10,
                    bottom: 10,
                  ),
                  constraints: const BoxConstraints(
                    minHeight: 50,
                    minWidth: 50,
                    maxWidth: 50,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
                  height: 35,
                  width: 147,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(0, 48, 73, 1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                          Text(
                            like,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                        ],
                      )
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
