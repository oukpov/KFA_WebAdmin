import 'package:flutter/material.dart';
import 'package:web_admin/components/ApprovebyAndVerifyby.dart';

import '../../../../../../Profile/contants.dart';
import '../../../../../../components/colors/colors.dart';

class Inputfied extends StatefulWidget {
  const Inputfied({
    super.key,
    required this.value,
    required this.filedName,
    required this.flex,
    required this.readOnly,
    required this.validator,
  });
  final OnChangeCallback value;
  final String filedName;
  final int flex;
  final bool readOnly;
  final bool validator;

  @override
  State<Inputfied> createState() => _InputfiedState();
}

class _InputfiedState extends State<Inputfied> {
  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: SizedBox(
        height: 35,
        child: TextFormField(
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
          readOnly: widget.readOnly,
          style: TextStyle(
              fontSize: MediaQuery.textScaleFactorOf(context) * 12,
              fontWeight: FontWeight.bold),
          onChanged: (value) {
            setState(() {
              widget.value(value);
            });
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            prefixIcon: const SizedBox(width: 7),
            hintText: widget.filedName,
            fillColor: kwhite,
            labelText: widget.filedName,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: (!hasError && widget.validator == true)
                    ? Colors.red
                    : bordertxt,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
    );
  }
}
