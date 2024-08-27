// ignore_for_file: prefer_const_constructors

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../components/colors.dart';

class FormN extends StatelessWidget {
  final String label;
  final Widget iconname;
  final FormFieldSetter<String> onSaved;
  const FormN({
    Key? key,
    required this.label,
    required this.iconname,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: controller,

      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        // for below version 2 use this
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        // for version 2 and greater youcan also use this
        FilteringTextInputFormatter.digitsOnly
      ],
      onChanged: onSaved,
      decoration: InputDecoration(
        fillColor: kwhite,
        filled: true,
        labelText: label,
        prefixIcon: iconname,
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
    );
  }
}
