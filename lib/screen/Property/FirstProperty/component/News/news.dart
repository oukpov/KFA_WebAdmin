import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget news(context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.5,
    width: double.infinity,
    color: Colors.white,
    child: Column(
      children: [Text('New')],
    ),
  );
}
