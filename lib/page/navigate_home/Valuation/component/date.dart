import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../components/colors.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Data_FromEnd extends StatefulWidget {
  const Data_FromEnd({super.key, required this.lable, required this.valueDate});
  final String lable;

  final OnChangeCallback valueDate;
  @override
  State<Data_FromEnd> createState() => _Data_FromEndState();
}

class _Data_FromEndState extends State<Data_FromEnd> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return dateDay();
  }

  String date = '';

  Widget dateDay() {
    return Expanded(
      child: TextField(
        style: TextStyle(
          fontSize: MediaQuery.textScaleFactorOf(context) * 14,
        ),
        controller: controller, //editing controller of this TextField
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.calendar_today,
            color: kImageColor,
            size: MediaQuery.textScaleFactorOf(context) * 16,
          ), //icon of text field
          labelText: widget.lable,
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
          ),
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            date = DateFormat('yyyy-MM-dd').format(pickedDate);

            setState(() {
              controller.text = date;

              widget.valueDate(date);
            });
          } else {
            print("Date is not selected");
          }
        },
      ),
    );
  }
}
