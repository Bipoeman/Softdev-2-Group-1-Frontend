import 'package:flutter/material.dart';

class RestroomInteractiveImage extends StatelessWidget {
  const RestroomInteractiveImage(
      {super.key, required this.picture, this.width, this.height});
  final String picture;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Stack(
              children: [
                Center(
                    child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: InteractiveViewer(
                    maxScale: 10,
                    child: Image.network(
                      picture,
                    ),
                  ),
                )),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
      child: SizedBox(
        width: width == null ? size.width * 0.3 : width!,
        height: height == null ? size.height * 0.2 : height!,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            picture,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
