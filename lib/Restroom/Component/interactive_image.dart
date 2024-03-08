import 'package:flutter/material.dart';

class RestroomInteractiveImage extends StatelessWidget {
  const RestroomInteractiveImage(
      {super.key,
      required this.picture,
      this.width,
      this.height,
      this.borderRadius});
  final String picture;
  final double? width;
  final double? height;
  final double? borderRadius;

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
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
          child: Image.network(
            picture,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
