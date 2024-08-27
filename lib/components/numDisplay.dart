// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

class NumDisplay extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  // ignore: prefer_const_constructors_in_immutables
  NumDisplay({Key? key, required this.onSaved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextFormField(
        // controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          // for below version 2 use this
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          // for version 2 and greater youcan also use this
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: onSaved,
        initialValue: "5",
        decoration: InputDecoration(
          fillColor: kwhite,
          filled: true,
          labelText: "Num Display",
          labelStyle: TextStyle(color: blueColor),
          prefixIcon: Icon(
            Icons.numbers,
            color: kImageColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: kPrimaryColor,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
