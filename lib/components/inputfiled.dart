import 'package:flutter/material.dart';
import '../../components/ApprovebyAndVerifyby.dart';
import 'colors.dart';
import 'colors/colors.dart';

class InputfiedWidget extends StatefulWidget {
  const InputfiedWidget(
      {super.key,
      required this.value,
      required this.filedName,
      required this.flex,
      required this.readOnly,
      required this.lable});
  final OnChangeCallback value;
  final String filedName;
  final String lable;
  final int flex;
  final bool readOnly;

  @override
  State<InputfiedWidget> createState() => _InputfiedWidgetState();
}

class _InputfiedWidgetState extends State<InputfiedWidget> {
  bool hasError = false;
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller.text = widget.filedName;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: SizedBox(
        height: 35,
        child: TextFormField(
          controller: controller,
          readOnly: widget.readOnly,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          onChanged: (value) {
            setState(() {
              widget.value(controller.text);
            });
          },
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            hintText: widget.filedName,
            fillColor: kwhite,
            labelText: widget.lable,
            labelStyle: TextStyle(color: greyColor),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
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
