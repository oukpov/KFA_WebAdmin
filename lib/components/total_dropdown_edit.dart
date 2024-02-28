// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_import, unnecessary_null_comparison

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Total_dropdown_edit extends StatefulWidget {
  final OnChangeCallback total_type;
  String? total_id;
  final OnChangeCallback input;
  String? sqm_price;
  Total_dropdown_edit(
      {Key? key,
      required this.total_id,
      required this.total_type,
      required this.input,
      required this.sqm_price})
      : super(key: key);

  @override
  State<Total_dropdown_edit> createState() => _RoadDropdownState();
}

class _RoadDropdownState extends State<Total_dropdown_edit> {
  late String roadValue;
  late String roadValue1;
  String? total = '';
  @override
  void initState() {
    if (widget.total_id == totally[1]['numer_id'].toString()) {
      setState(() {
        total = 'Sqm';
      });
    } else {
      setState(() {
        total = 'Totally';
      });
    }
    _price_sqm = TextEditingController(text: '${widget.sqm_price.toString()}');
    sqm_price = _price_sqm!.text;
    super.initState();
    roadValue = "";
    // ignore: unnecessary_new
  }

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
  String? sqm_price;
  TextEditingController? _price_sqm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.height * 0.19,
            child: TextFormField(
              controller: _price_sqm,
              keyboardType: TextInputType.number,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.015,
                  fontWeight: FontWeight.bold),
              onChanged: (value) {
                setState(() {
                  if (value == null) {
                    widget.input(sqm_price);
                  } else {
                    widget.input(value);
                  }
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
            width: MediaQuery.of(context).size.height * 0.26,
            padding: const EdgeInsets.fromLTRB(10, 0, 30, 0),
            child: DropdownButtonFormField<String>(
              //value: genderValue,
              isExpanded: true,
              onChanged: (newValue) {
                setState(() {
                  if (newValue == null) {
                    widget.total_type(widget.total_id.toString());
                  } else {
                    widget.total_type(newValue);
                  }
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
                labelText: '$total',
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
