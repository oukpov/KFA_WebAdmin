// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../components/colors/colors.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Dropdown extends StatefulWidget {
  final String gender;
  final OnChangeCallback get_gender;
  const Dropdown({Key? key, required this.gender, required this.get_gender})
      : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String bankvalue = 'Male';
  var gender = [
    'Male',
    'Female',
    'Other',
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownButtonFormField<String>(
        onChanged: (String? newValue) {
          setState(() {
            widget.get_gender(newValue);
          });
        },

        value: widget.gender,
        items: gender
            .map<DropdownMenuItem<String>>(
              (String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ),
            )
            .toList(),
        // add extra sugar..
        icon: Icon(
          Icons.arrow_drop_down,
          color: whileColors,
        ),

        decoration: const InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'gender',
          hintText: 'Select',
        ),
      ),
    );
  }
}
