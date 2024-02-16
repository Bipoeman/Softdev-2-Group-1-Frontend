import 'package:flutter/material.dart';


class Cardpin extends StatefulWidget {
  const Cardpin({Key? key}) : super(key: key);

  @override
  State<Cardpin> createState() => _CardpinState();
}

class _CardpinState extends State<Cardpin> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width * 0.8,
        height: size.width * 0.7,
        color: Colors.blue,
        child: const Column(,
          children: [
            SizedBox(
              height: size.width * 0.1,
              decoration: Text(
              "Bally",
              style: TextStyle(fontSize: 20),
              ),
            ),

            Text(
              "Bally",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "44 บางซ่อน",
              style: TextStyle(fontSize: 20),
            )
    
          ],
        ),
      ),
    );
  }
}
