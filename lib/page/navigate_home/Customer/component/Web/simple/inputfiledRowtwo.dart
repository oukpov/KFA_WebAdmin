import 'package:flutter/material.dart';
import 'package:web_admin/components/ApprovebyAndVerifyby.dart';

import '../../../../../../components/colors.dart';

class InputfiedRowtwo extends StatefulWidget {
  const InputfiedRowtwo(
      {super.key,
      required this.value,
      required this.filedName,
      required this.flex,
      required this.readOnly,
      required this.validator});
  final OnChangeCallback value;
  final String filedName;
  final int flex;
  final bool readOnly;
  final bool validator;
  @override
  State<InputfiedRowtwo> createState() => _InputfiedState();
}

class _InputfiedState extends State<InputfiedRowtwo> {
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          // controller: controller,
          validator: (input) {
            if (input == null || input.isEmpty) {
              return 'require *';
            }
            return null;
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
            // labelStyle: ,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            fillColor: kwhite,
            filled: true,
            labelText: widget.filedName,
            //hintText: widget.filedName,
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
              borderRadius: BorderRadius.circular(5.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Color.fromARGB(255, 249, 0, 0),
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Color.fromARGB(255, 249, 0, 0),
              ),
              //  borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
