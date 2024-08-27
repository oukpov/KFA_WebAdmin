// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'colors.dart';

typedef OnChangeCallback = void Function(dynamic value);

class RoadDropdown extends StatefulWidget {
  final OnChangeCallback id_road;
  final OnChangeCallback Name_road;
  final String lable;
  const RoadDropdown(
      {Key? key,
      required this.id_road,
      required this.Name_road,
      required this.lable})
      : super(key: key);

  @override
  State<RoadDropdown> createState() => _RoadDropdownState();
}

class _RoadDropdownState extends State<RoadDropdown> {
  late String roadValue;
  late String roadValue1;
  List list = [
    {"road_id": 1, "road_name": "Main Road"},
    {"road_id": 2, "road_name": "Sub Road"}
  ];

  @override
  void initState() {
    super.initState();
    roadValue = "";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: DropdownButtonFormField<String>(
        validator: (value) {
          if (value == null) {
            setState(() {
              widget.Name_road(true);
            });
          } else {
            setState(() {
              widget.Name_road(false);
            });
          }
        },
        //value: genderValue,
        isExpanded: true,
        onChanged: (newValue) {
          setState(() {
            widget.id_road(newValue);
          });
        },
        items: list
            .map<DropdownMenuItem<String>>(
              (value) => DropdownMenuItem<String>(
                value: value["road_id"].toString(),
                child: Text(value["road_name"]),
              ),
            )
            .toList(),

        icon: const Icon(
          Icons.arrow_drop_down,
          color: kImageColor,
        ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          fillColor: kwhite,
          filled: true,
          labelText: widget.lable,
          hintText: 'Select one',
          prefixIcon: const Icon(
            Icons.edit_road_outlined,
            color: kImageColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: kPrimaryColor,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
