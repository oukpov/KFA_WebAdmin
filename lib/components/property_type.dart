// ignore_for_file: unused_element

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'colors.dart';

typedef OnChangeCallback = void Function(dynamic value);

class property_hoemtype extends StatefulWidget {
  property_hoemtype({super.key, required this.hometype, this.hometype_lable});
  final OnChangeCallback hometype;
  final String? hometype_lable;

  @override
  State<property_hoemtype> createState() => _property_typeState();
}

class _property_typeState extends State<property_hoemtype> {
  @override
  void initState() {
    super.initState();
    _hometype();
  }

  var _list = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        onChanged: (newValue) {
          setState(() {
            widget.hometype(newValue);
          });
        },
        validator: (String? value) {
          if (value?.isEmpty ?? true) {
            return 'Please select bank';
          }
          return null;
        },
        items: _list
            .map<DropdownMenuItem<String>>(
              (value) => DropdownMenuItem<String>(
                value: value["property_type_id"].toString(),
                child: Text(
                  value["property_type_name"],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: MediaQuery.textScaleFactorOf(context) * 13,
                      height: 1),
                ),
              ),
            )
            .toList(),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: kImageColor,
        ),
        decoration: InputDecoration(
          fillColor: kwhite,
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 8),
          labelText: (widget.hometype_lable == null)
              ? 'Property Type*'
              : widget.hometype_lable,
          hintText: 'Select',
          prefixIcon: const Icon(
            Icons.real_estate_agent_outlined,
            color: kImageColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: kPrimaryColor,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: kerror,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: kerror,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  void _hometype() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/properties_dropdown'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      // print(jsonData);
      // print(jsonData);

      setState(() {
        _list = jsonData;
      });
    }
  }
}
