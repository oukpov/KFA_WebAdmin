import 'package:flutter/material.dart';
import '../../../../../../components/GoogleMap/map_for_verbal_and_autoverbal.dart';
import '../../../../../../components/colors.dart';
import '../../../../../../components/colors/colors.dart';

class DropDownRowtxts extends StatefulWidget {
  DropDownRowtxts(
      {super.key,
      required this.list,
      required this.txtvalue,
      required this.valuedropdown,
      required this.valuetxt,
      required this.filedName,
      required this.value,
      required this.flex,
      required this.validator});
  List list = [];
  final String txtvalue;
  final String valuedropdown;
  final String valuetxt;
  final String filedName;
  final int flex;
  final OnChangeCallback value;
  final bool validator;
  @override
  State<DropDownRowtxts> createState() => _DropDownState();
}

class _DropDownState extends State<DropDownRowtxts> {
  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
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
                labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.textScaleFactorOf(context) * 12),
                helperStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.textScaleFactorOf(context) * 12),
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
