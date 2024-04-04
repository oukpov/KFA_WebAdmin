import 'package:flutter/material.dart';
import '../../../components/colors/colors.dart';
import '../../../screen/Property/FirstProperty/component/Colors/colors.dart';

Widget options(txt, txts, icon) {
  return Padding(
    padding: const EdgeInsets.only(right: 10),
    child: Container(
      height: 40,
      width: 140,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromARGB(255, 58, 207, 230)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: whileColors,
            ),
            const SizedBox(width: 10),
            Row(
              children: [
                Text(txt, style: TextStyle(fontSize: 10, color: whileColors)),
                Text(
                  ' $txts',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      color: Colors.red),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget textfield(txt) {
  return Text(txt, style: const TextStyle(fontWeight: FontWeight.bold));
}

Widget title(txt) {
  return Column(
    children: [
      const SizedBox(height: 50),
      Text(
        txt,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: greyColor),
      ),
      const SizedBox(height: 10),
    ],
  );
}
