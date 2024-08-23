import 'package:flutter/material.dart';
import 'package:web_admin/components/ApprovebyAndVerifyby.dart';

import '../../../../api/contants.dart';
import '../../../../components/colors/colors.dart';

class InputfiedRowtxt extends StatefulWidget {
  const InputfiedRowtxt({
    super.key,
    required this.value,
    required this.readOnly,
    required this.validator,
    required this.txtvalue,
    required this.lable,
    required this.star,
  });
  final OnChangeCallback value;

  final String txtvalue;
  final String lable;
  final String star;
  final bool readOnly;
  final bool validator;
  @override
  State<InputfiedRowtxt> createState() => _InputfiedState();
}

class _InputfiedState extends State<InputfiedRowtxt> {
  TextEditingController txtvalue = TextEditingController();
  bool hasError = false;
  void dispose() {
    txtvalue.dispose();
    super.dispose();
  }

  @override
  void initState() {
    txtvalue.text = widget.txtvalue;
    super.initState();
  }

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
        Expanded(
          flex: 6,
          child: SizedBox(
            height: 35,
            child: TextFormField(
              controller: txtvalue,
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
                fillColor: kwhite,
                filled: true,
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
