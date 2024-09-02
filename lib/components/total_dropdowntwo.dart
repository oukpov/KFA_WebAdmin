// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_import

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'colors.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Total_dropdowntwo extends StatefulWidget {
  final OnChangeCallback total_type;
  final OnChangeCallback input;
  final int? flex;
  final String? filedName;
  const Total_dropdowntwo(
      {Key? key,
      required this.total_type,
      required this.input,
      this.flex,
      this.filedName})
      : super(key: key);

  @override
  State<Total_dropdowntwo> createState() => _RoadDropdownState();
}

class _RoadDropdownState extends State<Total_dropdowntwo> {
  late String roadValue;
  late String roadValue1;
  TextEditingController _controllerA = TextEditingController();
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
  Widget build(
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: (widget.flex == null) ? 0 : int.parse(widget.flex.toString()),
          child: TextFormField(
            //validator: false;
            //readOnly: widget.readOnly,
            style: TextStyle(
                fontSize: MediaQuery.textScaleFactorOf(context) * 12,
                fontWeight: FontWeight.bold),
            onChanged: (value) {
              setState(() {
                widget.input(value);
              });
            },
            decoration: InputDecoration(
              // labelStyle: ,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              fillColor: kwhite,
              filled: true,
              labelText: widget.filedName,
              hintText: '',
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
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: (widget.flex == null) ? 0 : int.parse(widget.flex.toString()),
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
              // labelStyle: ,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              fillColor: kwhite,
              filled: true,
              labelText: '',
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
            ),
          ),
        ),
      ],
    );
  }
}
