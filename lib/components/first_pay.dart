// ignore_for_file: unused_element, unused_field, must_be_immutable
import 'package:flutter/material.dart';

import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class payment_first extends StatefulWidget {
  payment_first(
      {super.key,
      this.Code_AFR,
      required this.First_Pay,
      required this.hintText,
      required this.hintTexts,
      required this.OR_N,
      required this.controller2,
      required this.controller1});
  TextEditingController? controller2;
  TextEditingController? controller1;
  final OnChangeCallback First_Pay;
  final OnChangeCallback hintText;
  String? hintTexts;
  String? OR_N;
  String? Code_AFR;

  @override
  State<payment_first> createState() => _property_typeState();
}

class _property_typeState extends State<payment_first> {
  @override
  Widget build(BuildContext context) {
    var pading_bt = EdgeInsets.only(left: 30, right: 30);
    return Padding(
      padding: pading_bt,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: widget.controller1,
              keyboardType: (widget.OR_N != 'Instructor Tell' &&
                      widget.hintTexts != 'Invoice')
                  ? TextInputType.number
                  : null,
              // controller: _Account_Receivable,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.015,
                fontWeight: FontWeight.bold,
              ),
              onChanged: (value) {
                setState(() {
                  widget.First_Pay(value);
                });
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                prefixIcon: (widget.hintTexts != 'Tel')
                    ? const Icon(
                        Icons.feed_outlined,
                        color: kImageColor,
                      )
                    : const Icon(
                        Icons.phone,
                        color: kImageColor,
                      ),
                hintText: '${widget.hintTexts.toString()}',
                fillColor: kwhite,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: kPrimaryColor,
                    width: 2.0,
                  ),
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
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextFormField(
              controller: widget.controller2,
              onChanged: (value) {
                widget.hintText(value);
                print('${widget.OR_N} || ${widget.Code_AFR}');
              },
              readOnly: (widget.OR_N == widget.Code_AFR) ? true : false,
              // controller: _Account_Receivable,
              keyboardType: (widget.OR_N == 'Building Size *' ||
                      widget.OR_N == 'OR N' ||
                      widget.OR_N == 'Instructor Tell')
                  ? TextInputType.number
                  : null,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.015,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                hintText: (widget.OR_N == 'Building Size *')
                    ? '${widget.OR_N.toString()}'
                    : '    ${widget.OR_N.toString()}',
                fillColor: kwhite,
                prefixIcon: (widget.OR_N == 'Building Size *')
                    ? const Icon(
                        Icons.landscape,
                        color: kImageColor,
                      )
                    : null,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: kPrimaryColor,
                    width: 2.0,
                  ),
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
            ),
          ),
        ],
      ),
    );
  }
}
