import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Profile/components/Drop_down.dart';
import '../screen/Property/FirstProperty/component/Colors/colors.dart';

class DateDrop extends StatefulWidget {
  DateDrop({
    super.key,
    required this.value,
    required this.filedname,
  });
  final _DateDropState _state = _DateDropState();
  final OnChangeCallback value;
  final String filedname;
  void clear() {
    _state.clearText();
  }

  @override
  State<DateDrop> createState() => _state;
}

class _DateDropState extends State<DateDrop> {
  late TextEditingController todate;
  String? curentDate;
  void today_formart() {
    DateTime now = DateTime.now();
    curentDate = DateFormat('yyyy-MM-dd').format(now);
  }

  @override
  void initState() {
    todate = TextEditingController(text: widget.filedname);
    super.initState();
    today_formart();
  }

  @override
  void dispose() {
    todate.dispose();
    super.dispose();
  }

  void clearText() {
    todate = TextEditingController(text: widget.filedname);
    setState(() {
      todate.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 40,
        child: TextField(
          style: const TextStyle(fontSize: 12),
          controller: todate,
          decoration: InputDecoration(
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.textScaleFactorOf(context) * 12),
            prefixIcon: Icon(Icons.calendar_today, color: greyColor, size: 20),
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: greyColor, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: greyColor),
                borderRadius: BorderRadius.circular(5.0)),
          ),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101));

            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              formattedDate = formattedDate;
              setState(() {
                todate.text = formattedDate;
                widget.value(todate.text);
              });
            }
          },
        ),
      ),
    );
  }
}
