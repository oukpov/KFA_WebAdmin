import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../component/Colors/appbar.dart';

var colorblue = const Color.fromARGB(255, 12, 136, 224);
Widget imageIcon(txt, icon) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(width: 2, color: colorblue),
        borderRadius: BorderRadius.circular(5)),
    height: 40,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: appback,
          ),
          const SizedBox(width: 5),
          Text(
            txt,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}
