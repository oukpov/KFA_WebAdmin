import 'package:flutter/material.dart';

import '../../../../../screen/Property/FirstProperty/component/Colors/colors.dart';

Widget titletext(title, context) {
  return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(title,
            style: TextStyle(
                fontSize: MediaQuery.textScaleFactorOf(context) * 16,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 4, 33, 84))),
      ));
}

Widget filedtext(title, star, context) {
  return SizedBox(
      width: 150,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.textScaleFactorOf(context) * 12,
                    color: greyColor)),
            Text(star,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.textScaleFactorOf(context) * 14,
                    color: Colors.red)),
          ],
        ),
      ));
}

Widget titletexts(title, context) {
  return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 0),
        child: Text(title,
            style: TextStyle(
                fontSize: MediaQuery.textScaleFactorOf(context) * 16,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 4, 33, 84))),
      ));
}

Widget filedtexts(title, star, context) {
  return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 0),
        child: Row(
          children: [
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.textScaleFactorOf(context) * 13,
                    color: greyColor)),
            Text(star,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.textScaleFactorOf(context) * 13,
                    color: Colors.red)),
          ],
        ),
      ));
}

Widget filedtextRight(title, star, context) {
  return SizedBox(
      width: MediaQuery.of(context).size.width * 0.1,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Wrap(
          children: [
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.textScaleFactorOf(context) * 12,
                    color: greyColor)),
            Text(star,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.textScaleFactorOf(context) * 14,
                    color: Colors.red)),
          ],
        ),
      ));
}
