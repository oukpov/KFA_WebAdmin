import 'package:flutter/material.dart';
import 'package:web_admin/components/ApprovebyAndVerifyby.dart';
import '../../../../../../components/colors.dart';
import '../../../../../../components/colors/colors.dart';

class InputfiedRowtxts extends StatefulWidget {
  const InputfiedRowtxts(
      {super.key,
      required this.value,
      required this.filedName,
      required this.txtvalue,
      required this.flex,
      required this.readOnly,
      required this.validator});
  final OnChangeCallback value;
  final String filedName;
  final int flex;
  final String txtvalue;
  final bool readOnly;
  final bool validator;
  @override
  State<InputfiedRowtxts> createState() => _InputfiedState();
}

class _InputfiedState extends State<InputfiedRowtxts> {
  TextEditingController txtvalue = TextEditingController();
  @override
  void initState() {
    txtvalue.text = widget.txtvalue;
    super.initState();
  }

  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: widget.flex,
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
                hintText: widget.filedName,
                fillColor: kwhite,
                labelText: widget.filedName,
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