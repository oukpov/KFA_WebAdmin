// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors/colors.dart';

class TitlePromotion extends StatelessWidget {
  final String titlePromo;
  final String titlePromo1;

  final String check;
  const TitlePromotion({
    Key? key,
    required this.titlePromo1,
    required this.titlePromo,
    required this.check,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            titlePromo,
            style: TextStyle(
              fontSize: 12,
              color: (check == "1") ? whileColors : Colors.black,
            ),
          ),
        ),
        Flexible(
          child: TextButton(
            onPressed: () {},
            child: Text(
              titlePromo1,
              style: TextStyle(
                fontSize: 12,
                color: (check == "1")
                    ? const Color.fromARGB(255, 88, 165, 246)
                    : const Color.fromARGB(255, 1, 95, 190),
              ),
            ),
          ),
        )
      ],
    );
  }
}
