import 'package:flutter/material.dart';

import '../Profile/contants.dart';

class Textform extends StatefulWidget {
  const Textform({super.key, required this.flex, required this.text});
  final int flex;
  final String text;
  @override
  State<Textform> createState() => _TextformState();
}

class _TextformState extends State<Textform> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: TextFormField(
        readOnly: true,
        style: TextStyle(
            fontSize: MediaQuery.textScaleFactorOf(context) * 12,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          prefixIcon: const SizedBox(width: 7),
          //hintText: widget.filedName,
          fillColor: kwhite,
          //labelText: widget.filedName,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              //color: (!hasError && widget.validator == true)
              //? Colors.red
              // : bordertxt,
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
    );
  }
}
