import 'package:flutter/material.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/colors.dart';

import '../../../../Profile/contants.dart';
import '../../../../components/colors/colors.dart';
import '../../../../components/property copy.dart';

class DropDownRowtxt extends StatefulWidget {
  DropDownRowtxt(
      {super.key,
      required this.list,
      required this.valuedropdown,
      required this.valuetxt,
      required this.value,
      required this.validator,
      required this.txtvalue,
      required this.lable,
      required this.star});
  List list = [];
  final String valuedropdown;
  final String valuetxt;
  final String txtvalue;
  final String lable;
  final String star;
  final OnChangeCallback value;
  final bool validator;
  @override
  State<DropDownRowtxt> createState() => _DropDownState();
}

class _DropDownState extends State<DropDownRowtxt> {
  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: Row(
              children: [
                Text(
                  widget.lable,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.textScaleFactorOf(context) * 11),
                ),
                const SizedBox(width: 5),
                Text(
                  widget.star,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: MediaQuery.textScaleFactorOf(context) * 11),
                ),
              ],
            )),
        sizedBox,
        Expanded(
          flex: 6,
          child: SizedBox(
            height: 35,
            child: DropdownButtonFormField<String>(
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
                            fontSize:
                                MediaQuery.textScaleFactorOf(context) * 12),
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

                prefixIcon: const SizedBox(width: 7),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: kPrimaryColor, width: 1.0),
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
        ),
      ],
    );
  }
}
