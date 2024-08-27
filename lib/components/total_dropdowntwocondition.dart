// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_import

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Total_dropdowntwocondition extends StatefulWidget {
  final OnChangeCallback total_type;
  final OnChangeCallback input;
  final Widget? conditiontext;
  final String? conditionyear;
  final bool? readOnly;
  final String? filedName;
  final int? flex;
  dynamic controllers;
  Total_dropdowntwocondition(
      {Key? key,
      required this.total_type,
      required this.input,
      this.flex,
      this.conditiontext,
      this.conditionyear,
      this.readOnly,
      this.controllers,
      this.filedName})
      : super(key: key);

  @override
  State<Total_dropdowntwocondition> createState() => _RoadDropdownState();
}

class _RoadDropdownState extends State<Total_dropdowntwocondition> {
  late String roadValue;
  late String roadValue1;
  List _condition = [
    {
      'id': 1,
      'Condition': 'Condition 1',
    },
    {
      'id': 2,
      'Condition': 'Condition 2',
    }
  ];
  @override
  void initState() {
    super.initState();
    roadValue = "";
    // ignore: unnecessary_new
  }

  String? total = '';
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: (widget.flex == null) ? 0 : int.parse(widget.flex.toString()),
          child: DropdownButtonFormField<String>(
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'require *';
              }
              return null;
            },
            //value: genderValue,
            isExpanded: true,
            onChanged: (newValue) {
              setState(() {
                print(newValue);
                widget.total_type(newValue);
              });
            },
            items: _condition
                .map<DropdownMenuItem<String>>(
                  (value) => DropdownMenuItem<String>(
                    value: value['id'].toString(),
                    child: Text(
                      value['Condition'].toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: MediaQuery.textScaleFactorOf(context) * 13,
                          height: 1),
                    ),
                  ),
                )
                .toList(),
            // add extra sugar..
            icon: Icon(
              Icons.arrow_drop_down,
              color: kImageColor,
            ),
            decoration: InputDecoration(
              // labelStyle: ,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              fillColor: kwhite,
              filled: true,
              label: widget.conditiontext,
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
                // borderSide: BorderSide(
                //   width: 1,
                //   color: (!hasError && widget.validator == true)
                //       ? Colors.red
                //       : bordertxt,
                // ),
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
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: (widget.flex == null) ? 0 : int.parse(widget.flex.toString()),
          child: TextFormField(
            controller: widget.controllers,
            validator: (input) {
              if (input == null || input.isEmpty) {
                return 'require *';
              }
              return null;
            },
            readOnly: false,
            style: TextStyle(
                fontSize: MediaQuery.textScaleFactorOf(context) * 12,
                fontWeight: FontWeight.bold),
            // onChanged: (value) {
            //   setState(() {
            //     widget.input(value);
            //   });
            // },
            decoration: InputDecoration(
              //labelText: '',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              fillColor: kwhite,
              filled: true,
              labelText: 'Year',
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
        )
      ],
    );
  }
}
