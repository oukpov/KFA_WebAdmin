import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../components/colors/colors.dart';

class InputDateRowNow extends StatefulWidget {
  const InputDateRowNow({
    Key? key,
    required this.filedName,
    required this.flex,
    required this.value,
    required this.validator,
  }) : super(key: key);

  final String filedName;
  final int flex;
  final bool validator;
  final OnChangeCallback value;

  @override
  State<InputDateRowNow> createState() => _InputDateState();
}

class _InputDateState extends State<InputDateRowNow> {
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

  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: widget.flex,
          child: SizedBox(
            height: 35,
            child: TextFormField(
              validator: (value) {
                setState(() {
                  if ((value == null || value.isEmpty) &&
                      widget.validator == true) {
                    hasError = false;
                  } else {
                    hasError = true;
                  }
                });
              },
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
                  borderSide: BorderSide(
                    width: 1,
                    color: (!hasError && widget.validator == true)
                        ? Colors.red
                        : bordertxt,
                  ),
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
        ),
      ],
    );
  }
}
