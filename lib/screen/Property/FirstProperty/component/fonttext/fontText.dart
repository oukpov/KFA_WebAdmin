import 'package:flutter/material.dart';
import '../Colors/appbar.dart';

Widget fontSizes(text, value, fontSize, index, List list, context) {
  return Text(
      '${(text == "") ? "" : "$text : "}${list[index]['$value'].toString()}',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.textScaleFactorOf(context) * fontSize));
}

Widget fontSizesblue(text, value, fontSize, index, List list, context, type) {
  return Text(
      '\$ ${list[index]['$value'].toString()} ${(type == 'For Sale') ? "" : "/mth"}',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: appback,
          fontSize: MediaQuery.textScaleFactorOf(context) * fontSize));
}

Widget textS(context) {
  return Text(' | ',
      style: TextStyle(
          color: Colors.grey,
          fontSize: MediaQuery.textScaleFactorOf(context) * 12));
}
