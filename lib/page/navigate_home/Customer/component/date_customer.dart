import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../Profile/components/Drop_down.dart';
import '../../../../components/colors.dart';

class DateExpaned extends StatefulWidget {
  const DateExpaned({super.key, required this.value, required this.filedname});

  final OnChangeCallback value;
  final String filedname;
  @override
  State<DateExpaned> createState() => _DateExpanedState();
}

class _DateExpanedState extends State<DateExpaned> {
  TextEditingController todate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        style: const TextStyle(
          fontSize: 12,
        ),
        controller: todate,
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
            borderRadius: BorderRadius.circular(10.0),
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
          DateTime? pickedDate = await showDialog<DateTime>(
            context: context,
            builder: (BuildContext context) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Dialog(
                    // insetPadding: EdgeInsets.only(
                    //     left: offset.dx, top: offset.dy), // Set custom offset
                    child: SizedBox(
                      height: 400,
                      width: 300,
                      child: Column(
                        children: [
                          CalendarDatePicker(
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                            onDateChanged: (DateTime date) {
                              Navigator.of(context).pop(date);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
          // DateTime? pickedDate = await showDatePicker(
          //     context: context,
          //     initialDate: DateTime.now(),
          //     firstDate: DateTime(2000),
          //     lastDate: DateTime(2101));

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

            setState(() {
              todate.text = formattedDate;
              widget.value(formattedDate);
            });
          }
        },
      ),
    );
  }
}
