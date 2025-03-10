import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../components/ApprovebyAndVerifyby.dart';
import '../../../../components/colors.dart';

class DateExpanedController extends StatefulWidget {
  const DateExpanedController(
      {super.key,
      required this.value,
      required this.filedname,
      required this.todate});

  final OnChangeCallback value;
  final String filedname;
  final TextEditingController todate;
  @override
  State<DateExpanedController> createState() => _DateExpanedState();
}

class _DateExpanedState extends State<DateExpanedController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 40,
      child: TextField(
        style: const TextStyle(
          fontSize: 12,
        ),
        controller: widget.todate,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.calendar_today,
            color: kImageColor,
            size: 20,
          ),
          labelText: widget.filedname,
          fillColor: kwhite,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
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
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

            setState(() {
              widget.todate.text = formattedDate;
              widget.value(widget.todate.text);
            });
          }
        },
      ),
    );
  }
}
