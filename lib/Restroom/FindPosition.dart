import 'package:flutter/material.dart';
import 'package:ruam_mitt/Restroom/Component/write_review.dart';
import 'package:ruam_mitt/Restroom/Component/comment.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:ruam_mitt/Restroom/Component/map.dart';
import 'dart:math';

class RestroomRoverFindPosition extends StatefulWidget {
  const RestroomRoverFindPosition({super.key});

  @override
  State<RestroomRoverFindPosition> createState() => _RestroomRoverFindPositionState();
}

class _RestroomRoverFindPositionState extends State<RestroomRoverFindPosition> {
  BoxController boxController = BoxController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var rating = 2.5;
    return Scaffold(
      appBar: AppBar(),
      body: MapRestroomRover(),
    );
  }
}
