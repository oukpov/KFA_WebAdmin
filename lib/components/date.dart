// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Profile/components/Drop_down.dart';
import 'colors.dart';

class DateComponents extends StatefulWidget {
  const DateComponents(
      {Key? key,
      required this.value,
      required this.title,
      required this.values})
      : super(key: key);
  final OnChangeCallback value;
  final String title;
  final String values;
  @override
  State<DateComponents> createState() => _DateComponentsState();
}

class _DateComponentsState extends State<DateComponents> {
  @override
  void initState() {
    if (widget.values != "") {
      controllerDate.text = widget.values;
    }
    super.initState();
  }

  TextEditingController controllerDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Center(
        child: TextField(
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          controller: controllerDate,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 3),
            prefixIcon: Icon(
              Icons.calendar_today,
              color: kImageColor,
            ),
            labelText: widget.title,
            fillColor: kwhite,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: kPrimaryColor,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          // readOnly: true,
          onTap: () async {
            showLeftAlignedDatePicker(context);

            // if (pickedDate != null) {
            //   print(pickedDate);
            //   String formattedDate =
            //       DateFormat('yyyy-MM-dd').format(pickedDate);

            //   setState(() {
            //     controllerDate.text = formattedDate;
            //     widget.value(formattedDate);
            //   });
            // } else {
            //   print("Date is not selected");
            // }
          },
        ),
      ),
    );
  }

  Future<void> showLeftAlignedDatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 550,
            child: Theme(
              data: ThemeData.light(),
              child: Builder(
                builder: (context) => DatePickerDialog(
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                ),
              ),
            ),
          ),
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      setState(() {
        controllerDate.text = formattedDate;
        widget.value(formattedDate);
      });
    } else {
      print("Date is not selected");
    }
  }
}
