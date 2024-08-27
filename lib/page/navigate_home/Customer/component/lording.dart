import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

Widget lording(context) {
  return LiquidLinearProgressIndicator(
    value: 0.25,
    valueColor: const AlwaysStoppedAnimation(Color.fromARGB(255, 53, 33, 207)),
    backgroundColor: Colors.white,
    borderColor: Colors.white,
    borderWidth: 5.0,
    borderRadius: 12.0,
    direction: Axis.vertical,
    center: Text(
      "Please waiting...!",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.textScaleFactorOf(context) * 15),
    ),
  );
}
