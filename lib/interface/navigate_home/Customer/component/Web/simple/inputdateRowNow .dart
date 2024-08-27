import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../Profile/components/Drop_down.dart';
import '../../../../../../components/colors.dart';
import '../../../../../../components/colors/colors.dart';

class InputDateNow extends StatefulWidget {
  const InputDateNow({
    Key? key,
    required this.filedName,
    required this.flex,
    required this.value,
  }) : super(key: key);

  final String filedName;
  final int flex;
  final OnChangeCallback value;

  @override
  State<InputDateNow> createState() => _InputDateState();
}

class _InputDateState extends State<InputDateNow> {
  late TextEditingController todate;

  @override
  void initState() {
    super.initState();
    todate = TextEditingController(text: getCurrentDate());
  }

  @override
  void dispose() {
    todate.dispose();
    super.dispose();
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();

    return DateFormat('yyyy-MM-dd').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: SizedBox(
        height: 35,
        child: TextField(
          style: TextStyle(
            fontSize: MediaQuery.textScaleFactorOf(context) * 12,
          ),
          controller: todate,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.calendar_today,
              color: bordertxt,
              size: 20,
            ),
            labelText: widget.filedName,
            hintText: widget.filedName,
            fillColor: kwhite,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: bordertxt,
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
              lastDate: DateTime(2101),
            );

            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);

              setState(() {
                todate.text = formattedDate;
                widget.value(formattedDate);
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
