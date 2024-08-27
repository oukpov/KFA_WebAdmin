// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../components/colors.dart';


class FormS extends StatelessWidget {
  final String label;
  final Widget iconname;
  final FormFieldSetter<String> onSaved;
  const FormS({
    Key? key,
    required this.label,
    required this.iconname,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: TextFormField(
        // controller: controller,
        onChanged: onSaved,
        decoration: InputDecoration(
          fillColor: kwhite,
          filled: true,
          labelText: label,
          labelStyle: TextStyle(color: kTextLightColor),
          prefixIcon: iconname,
          contentPadding: EdgeInsets.symmetric(vertical: 8),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: kPrimaryColor,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
