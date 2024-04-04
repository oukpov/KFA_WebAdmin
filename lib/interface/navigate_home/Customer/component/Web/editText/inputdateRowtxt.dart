import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../Profile/components/Drop_down.dart';
import '../../../../../../Profile/contants.dart';
import '../../../../../../components/colors/colors.dart';

class InputDateRowtxts extends StatefulWidget {
  const InputDateRowtxts(
      {super.key,
      required this.filedName,
      required this.flex,
      required this.value,
      required this.txtvalue,
      required this.validator});
  final String filedName;
  final int flex;
  final bool validator;
  final OnChangeCallback value;
  final String txtvalue;
  @override
  State<InputDateRowtxts> createState() => _InputDateState();
}

class _InputDateState extends State<InputDateRowtxts> {
  TextEditingController todate = TextEditingController();
  @override
  void dispose() {
    // Don't forget to dispose the controller when it's no longer needed to avoid memory leaks
    todate.dispose();
    super.dispose();
  }

  @override
  void initState() {
    todate.text = widget.txtvalue;
    super.initState();
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
              controller: todate, //editing controller of this TextField
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: bordertxt,
                  size: 20,
                ), //icon of text field
                labelText: widget.filedName,
                hintText: widget.filedName,
                fillColor: kwhite,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: kPrimaryColor, width: 1.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: bordertxt,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ), //label text of field
              ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
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
                    widget.value(todate.text);
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
