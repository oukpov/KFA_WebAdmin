import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'colors.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Date_click extends StatefulWidget {
  Date_click({super.key, required this.date, this.date_get});

  final OnChangeCallback date;
  String? date_get;
  @override
  State<Date_click> createState() => _Date_clickState();
}

class _Date_clickState extends State<Date_click> {
  TextEditingController todate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: double.infinity,
        child: TextField(
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.015,
          ),
          controller: todate, //editing controller of this TextField
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.calendar_today,
              color: kImageColor,
              size: MediaQuery.of(context).size.height * 0.025,
            ), //icon of text field
            labelText: (widget.date_get == null) ? "Date" : widget.date_get,
            fillColor: kwhite,
            filled: true,
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
            ), //label text of field
          ),
          readOnly: true, //set it true, so that user will not able to edit text
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101));

            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);

              setState(() {
                todate.text = formattedDate;
                widget.date(formattedDate);
              });
            } else {
              print("Date is not selected");
            }
          },
        ),
      ),
    );
  }
}
