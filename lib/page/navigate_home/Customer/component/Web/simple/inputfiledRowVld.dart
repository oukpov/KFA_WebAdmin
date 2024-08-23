import 'package:flutter/material.dart';
import 'package:web_admin/components/ApprovebyAndVerifyby.dart';

import '../../../../../../api/contants.dart';
import '../../../../../../components/colors/colors.dart';

class InputfiedRowVld extends StatefulWidget {
  const InputfiedRowVld(
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
  State<InputfiedRowVld> createState() => _InputfiedState();
}

class _InputfiedState extends State<InputfiedRowVld> {
  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: widget.flex,
          child: TextFormField(
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
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: (!hasError && widget.validator == true)
                      ? Colors.red
                      : bordertxt,
                ),
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
      ],
    );
  }
}
