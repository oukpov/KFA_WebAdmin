// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
// import 'package:form_field_validator/form_field_validator.dart';

typedef OnChangeCallback = void Function(dynamic value);

class TextForm_Field extends StatefulWidget {
  TextForm_Field(
      {super.key,
      required this.field,
      required this.label,
      required this.icon,
      required this.InputType,
      required this.lock,
      required this.email,
      this.apiRequest,
      this.validator,
      this.Request,
      this.message,
      this.email_1,
      this.BoolEmail2,
      this.email_2,
      this.required});
  final OnChangeCallback field;
  final String label;
  var required;
  final Widget icon;
  final bool InputType;
  final bool lock;
  var apiRequest;
  var Request;
  var message;
  var email_1;
  var email_2;
  var BoolEmail2;
  var validator;
  var email;
  @override
  State<TextForm_Field> createState() => _Textform_FieldState();
}

class _Textform_FieldState extends State<TextForm_Field> {
  bool _isObscure = true;
  bool isRequired = false;
  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              validator: (value) {
                if (value == null) {
                  print('1');
                  return "Email Password";
                }
              },
              style: TextStyle(
                fontSize: MediaQuery.textScaleFactorOf(context) * 12,
                fontWeight: FontWeight.bold,
              ),
              keyboardType:
                  (widget.InputType == true) ? TextInputType.number : null,
              onChanged: (value) {
                setState(() {
                  widget.field(value);
                  isRequired = value.isEmpty;
                });
              },
              // obscureText: (widget.lock == true) ? _isObscure : false,
              decoration: InputDecoration(
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                contentPadding: EdgeInsets.symmetric(vertical: 8),
                prefixIcon: widget.icon,
                prefixIconColor: Colors.red,
                hintText: widget.label,
                labelText: widget.label,
                labelStyle: TextStyle(color: Colors.black),
                // suffixIcon: (widget.lock == true)
                //     ? IconButton(
                //         icon: Icon(
                //           color: Colors.grey,
                //           _isObscure ? Icons.visibility : Icons.visibility_off,
                //         ),
                //         onPressed: () {
                //           setState(() {
                //             _isObscure = !_isObscure;
                //           });
                //         },
                //       )
                //     : null,
                // filled: true,
                // focusedBorder: OutlineInputBorder(
                //   borderSide: BorderSide(
                //     color: Color.fromARGB(255, 62, 137, 103),
                //     width: 1.0,
                //   ),
                //   borderRadius: BorderRadius.circular(5.0),
                // ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isRequired
                        ? Colors.red
                        : Color.fromARGB(255, 62, 137, 103),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.6,
                    color: Colors.yellow,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
