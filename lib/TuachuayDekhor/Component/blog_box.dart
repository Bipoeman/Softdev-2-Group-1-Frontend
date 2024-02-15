import 'package:flutter/material.dart';
import 'package:ruam_mitt/global_const.dart';

class BlogBox extends StatelessWidget {
  const BlogBox({super.key});

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
          onPressed: () {
            Navigator.pushNamed(context, ruamMitrPageRoute["profile"]!);
          },
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
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/Icon/TuachuayDekhor_Catagories_1.png"),
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          Text(
                            "Like",
                            style: TextStyle(color: Colors.white, fontSize: 10),
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
