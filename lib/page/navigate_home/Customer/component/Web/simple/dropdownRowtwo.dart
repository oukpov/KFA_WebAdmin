import 'package:flutter/material.dart';
import '../../../../../../components/GoogleMap/map_for_verbal_and_autoverbal.dart';
import '../../../../../../components/colors/colors.dart';

class DropDownRowTwo extends StatefulWidget {
  DropDownRowTwo(
      {super.key,
      required this.list,
      required this.valuedropdown,
      required this.valuetxt,
      required this.filedName,
      required this.value,
      required this.flex,
      required this.validator});
  List list = [];
  final String valuedropdown;
  final String valuetxt;
  final String filedName;
  final int flex;
  final OnChangeCallback value;
  final bool validator;
  @override
  State<DropDownRowTwo> createState() => _DropDownState();
}

class _DropDownState extends State<DropDownRowTwo> {
  bool hasError = false;
  List _condition = [
    {
      'id': 1,
      'Condition': 'Condition 1',
    },
    {
      'id': 2,
      'Condition': 'Condition 2',
    }
  ];
  String? condition;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: widget.flex,
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            onChanged: (newValue) {
              setState(() {
                // print(newValue.toString());
                widget.value(newValue);
                condition = newValue;
              });
            },
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'require *';
              }
              return null;
            },
            items: _condition
                .map<DropdownMenuItem<String>>(
                  (value) => DropdownMenuItem<String>(
                    value: value['id'].toString(),
                    child: Text(
                      value['Condition'].toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: MediaQuery.textScaleFactorOf(context) * 13,
                          height: 1),
                    ),
                  ),
                )
                .toList(),
            // add extra sugar..
            icon: Icon(
              Icons.arrow_drop_down,
              color: kImageColor,
            ),

            decoration: InputDecoration(
              // labelStyle: ,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              fillColor: kwhite,
              filled: true,
              labelText: widget.filedName,
              hintText: widget.filedName,
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.textScaleFactorOf(context) * 12),
              helperStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.textScaleFactorOf(context) * 12),
              prefixIcon: const SizedBox(width: 7),
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
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 249, 0, 0),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 249, 0, 0),
                ),
                //  borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
