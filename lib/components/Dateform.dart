// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/colors.dart';
import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Dateform extends StatefulWidget {
  final OnChangeCallback Date;
  final int flex;
  String? formattedDate;
  Dateform(
      {Key? key, required this.Date, required this.flex, this.formattedDate})
      : super(key: key);

  @override
  State<Dateform> createState() => _DateformState();
}

class _DateformState extends State<Dateform> {
  TextEditingController fromdate = TextEditingController();
  TextEditingController selecteddate = TextEditingController();
  //text editing controller for text field
  String? curentDate;
  void today_formart() {
    DateTime now = DateTime.now();
    curentDate = DateFormat('yyyy-MM-dd').format(now);
  }

  @override
  void initState() {
    today_formart();
    selecteddate.text = ""; //set the initial value of text field
    fromdate.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: TextField(
        style: TextStyle(fontSize: 12, color: blackColor),
        controller: selecteddate,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.calendar_today,
            color: kImageColor,
            size: 25,
          ),
          // labelStyle: ,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          fillColor: kwhite,
          filled: true,
          label:
              ((widget.formattedDate) == null) ? Text('$curentDate') : Text(''),
          //hintText: widget.filedName,
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.textScaleFactorOf(context) * 12),
          helperStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.textScaleFactorOf(context) * 12),
          //prefixIcon: const SizedBox(width: 7),
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
        readOnly: true, //set it true, so that user will not able to edit text
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            //curentDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            formattedDate = formattedDate;
            setState(() {
              print(formattedDate.toString());
              // selecteddate.text = widget.formattedDate!;
              widget.Date(formattedDate);
            });
          } else {
            print("Date is not selected");
          }
        },
      ),
    );
  }
}
