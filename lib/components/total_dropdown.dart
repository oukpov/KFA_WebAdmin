// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_import

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'colors.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Total_dropdown extends StatefulWidget {
  final OnChangeCallback total_type;
  final OnChangeCallback input;
  const Total_dropdown(
      {Key? key, required this.total_type, required this.input})
      : super(key: key);

  @override
  State<Total_dropdown> createState() => _RoadDropdownState();
}

class _RoadDropdownState extends State<Total_dropdown> {
  late String roadValue;
  late String roadValue1;
  List totally = [
    {
      'numer_id': 1,
      'type': 'Totally',
    },
    {
      'numer_id': 2,
      'type': 'Sqm',
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
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.42,
            child: TextFormField(
              keyboardType: TextInputType.number,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.015,
                  fontWeight: FontWeight.bold),
              onChanged: (value) {
                setState(() {
                  widget.input(value);
                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 8),
                prefixIcon: Icon(
                  Icons.payments,
                  color: kImageColor,
                ),
                // hintText: 'Price Per SQM',
                fillColor: kwhite,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: kPrimaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: kPrimaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.42,
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: DropdownButtonFormField<String>(
              //value: genderValue,
              isExpanded: true,
              onChanged: (newValue) {
                setState(() {
                  print(newValue);
                  widget.total_type(newValue);
                });
              },
              items: totally
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                      value: value["numer_id"].toString(),
                      child: Text(value["type"]),
                      onTap: () {
                        setState(() {});
                      },
                    ),
                  )
                  .toList(),
              // add extra sugar..
              icon: Icon(
                Icons.arrow_drop_down,
                color: kImageColor,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 8),
                fillColor: kwhite,
                filled: true,
                labelText: 'Select',
                hintText: 'Select',
                prefixIcon: Icon(
                  Icons.discount_outlined,
                  color: kImageColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: kPrimaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: kPrimaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
