import 'package:flutter/material.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';

class Cardpin extends StatefulWidget {
  const Cardpin({Key? key}) : super(key: key);

  @override
  State<Cardpin> createState() => _CardpinState();
}

class _CardpinState extends State<Cardpin> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 40,
              width: 250,
              padding: const EdgeInsets.only(
                left: 35,
                top: 10,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Bally",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      )),
                  Icon(
                    Icons.woman_2,
                    size: 35,
                  )
                ],
              )),
          Container(
            height: 25,
            width: 320,
            padding: const EdgeInsets.only(
              left: 35,
              top: 4,
            ),
            child: const Text("97/2 บางซ่อน",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                )),
          ),
          Row(
            children: [
              Container(
                height: 20,
                width: 60,
                padding: const EdgeInsets.only(
                  left: 35,
                  top: 0.8,
                ),
                child: const Text("5.0",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              Container(
                height:20,
                width: 160,
                child: const FlutterRating(
                  rating: 3.5,
                  size: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              // ),
              Container(
                height: 20,
                width: 40,
                padding: const EdgeInsets.only(
                  top: 0.8,
                ),
                child: const Text("[ 9 ]",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ],
          ),
          Container(
              height: 150,
              width: 300,
              padding: const EdgeInsets.only(
                left: 1,
              ),
              child: Image.network(
                  "https://i.pinimg.com/564x/97/15/0f/97150f3cc7e93677495133ffe6ea77c3.jpg")),
          Container(
              height: 55,
              width: 300,
              padding: const EdgeInsets.only(
                left: 35,
                top: 2,
                right: 35,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 45,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 183, 3, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(255, 183, 3, 1)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.directions,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                  Container(
                    height: 45,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 183, 3, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(255, 183, 3, 1)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.reviews,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
