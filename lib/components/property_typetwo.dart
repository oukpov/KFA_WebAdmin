// ignore_for_file: unused_element

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'colors/colors.dart';
import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class property_hoemtypetwo extends StatefulWidget {
  property_hoemtypetwo(
      {super.key,
      required this.hometype,
      this.hometype_lable,
      this.filedName,
      required this.flex});
  final OnChangeCallback hometype;
  final String? hometype_lable;
  final String? filedName;
  final int flex;
  @override
  State<property_hoemtypetwo> createState() => _property_typeState();
}

class _property_typeState extends State<property_hoemtypetwo> {
  @override
  void initState() {
    super.initState();
    _hometype();
  }

  var _list = [];
  @override
  Widget build(BuildContext context) {
    bool hasError = false;
    return Expanded(
      flex: widget.flex,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        onChanged: (newValue) {
          setState(() {
            widget.hometype(newValue);
          });
        },
        // validator: (String? value) {
        //   if (value?.isEmpty ?? true) {
        //     return 'require *';
        //   }
        //   return null;
        // },
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
          // labelStyle: ,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
          fillColor: kwhite,
          filled: true,
          labelText: widget.filedName,
          hintText: widget.filedName,
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
            borderSide: BorderSide(
              width: 1,
              color: (!hasError == true) ? Colors.red : bordertxt,
            ),
            borderRadius: BorderRadius.circular(5.0),
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
