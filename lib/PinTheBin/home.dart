import "package:flutter/material.dart";
import "package:ruam_mitt/PinTheBin/navbar.dart";

class BinPage extends StatefulWidget {
  const BinPage({super.key});

  @override
  State<BinPage> createState() => _BinPageState();
}

class _BinPageState extends State<BinPage> {
  // late GoogleMapController mapController;

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Google Map'),
  //     ),
  //     body: GoogleMap(
  //       key: UniqueKey(),
  //       initialCameraPosition: CameraPosition(
  //         target:
  //             LatLng(13.7563, 100.5018), // ตำแหน่งเริ่มต้นของแผนที่ (กรุงเทพฯ)
  //         zoom: 12, // ขนาดการซูมเริ่มต้นของแผนที่
  //       ),
  //       onMapCreated: (GoogleMapController controller) {
  //         mapController = controller;
  //       },
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      backgroundColor: Color.fromARGB(0, 251, 250, 250),
    );
  }
}
