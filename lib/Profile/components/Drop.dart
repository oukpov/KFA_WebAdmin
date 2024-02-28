// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../Customs/Contants.dart';

class BankDropdown extends StatefulWidget {
  final String from;
  const BankDropdown({Key? key, required this.from}) : super(key: key);

  @override
  State<BankDropdown> createState() => _BankDropdownState();
}

class _BankDropdownState extends State<BankDropdown> {
  String bankvalue = 'Bank';
  var bank = [
    'Bank',
    'Private',
    'Other',
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 59,
      width: 140,
      child: DropdownButtonFormField<String>(
        onChanged: (String? newValue) {
          setState(() {
            bankvalue = newValue!;
            // ignore: avoid_print
            print(newValue);
          });
        },
        // validator: (String? value) {
        //   if (value?.isEmpty ?? true) {
        //     return 'Please select bank';
        //   }
        //   return null;
        // },
        value: widget.from,
        items: bank
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
          color: kImageColor,
        ),

        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Bank',
          hintText: 'Select',
        ),
      ),
    );
  }
}
