import 'package:flutter/material.dart';

import '../../../../components/colors.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Input_text extends StatefulWidget {
  Input_text(
      {super.key,
      required this.lable,
      required this.type,
      required this.typeRead,
      required this.valueBack,
      required this.required,
      this.controller});
  String? lable;
  bool? type;
  bool? typeRead;
  final OnChangeCallback valueBack;
  bool? required;
  var controller;
  @override
  State<Input_text> createState() => _Input_textState();
}

// late TextEditingController controller;

class _Input_textState extends State<Input_text> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        validator: (value) {
          if ((value == null || value.isEmpty) && widget.required == true) {
            return '${widget.lable} is required';
          }
          return null;
        },
        controller: widget.controller,
        readOnly: widget.typeRead!,
        keyboardType: (widget.type == true) ? TextInputType.number : null,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * 0.015,
          fontWeight: FontWeight.bold,
        ),
        onChanged: (value) {
          setState(() {
            widget.valueBack(value);
          });
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          prefixIcon: const Icon(
            Icons.feed_outlined,
            color: kImageColor,
          ),
          hintText: widget.lable,
          fillColor: kwhite,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: kPrimaryColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: kPrimaryColor,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
