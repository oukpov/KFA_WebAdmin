import 'package:flutter/material.dart';

import '../../../../../../Profile/contants.dart';
import '../../../../../../components/colors/colors.dart';
import '../../../../../../components/landsize.dart';
import '../../../../../../screen/Property/FirstProperty/component/Colors/colors.dart';

class DropDowntxt extends StatefulWidget {
  DropDowntxt(
      {super.key,
      required this.list,
      required this.valuedropdown,
      required this.valuetxt,
      required this.value,
      required this.flex,
      required this.validator,
      required this.txtvalue});
  List list = [];
  final String txtvalue;
  final String valuedropdown;
  final String valuetxt;

  final int flex;
  final OnChangeCallback value;
  final bool validator;
  @override
  State<DropDowntxt> createState() => _DropDownState();
}

class _DropDownState extends State<DropDowntxt> {
  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: SizedBox(
        height: 35,
        child: DropdownButtonFormField<String>(
          validator: (value) {
            setState(() {
              if ((value == null || value.isEmpty) &&
                  widget.validator == true) {
                hasError = false;
              } else {
                hasError = true;
              }
            });
          },
          isExpanded: true,
          onChanged: (newValue) {
            setState(() {
              widget.value(newValue);
            });
          },
          items: widget.list
              .map<DropdownMenuItem<String>>(
                (value) => DropdownMenuItem<String>(
                  value: value[widget.valuedropdown].toString(),
                  child: Text(
                    value[widget.valuetxt],
                    style: TextStyle(
                        fontSize: MediaQuery.textScaleFactorOf(context) * 12),
                  ),
                ),
              )
              .toList(),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: kImageColor,
          ),
          decoration: InputDecoration(
            // labelStyle: ,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            fillColor: kwhite,
            filled: true,
            hintText: widget.txtvalue,
            hintStyle: TextStyle(
                fontSize: MediaQuery.textScaleFactorOf(context) * 12,
                color: blackColor),
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.textScaleFactorOf(context) * 12),
            helperStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.textScaleFactorOf(context) * 12),
            prefixIcon: const SizedBox(width: 7),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: bordertxt,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
    );
  }
}
