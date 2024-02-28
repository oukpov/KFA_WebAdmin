import 'package:flutter/material.dart';
import '../../../../../../../components/landsize.dart';
import 'EmailSave.dart';

class ResponsiveEmailSave extends StatefulWidget {
  const ResponsiveEmailSave(
      {super.key,
      required this.list,
      required this.listBack,
      required this.checkboxValues,
      required this.listAll,
      required this.myIdcontroller});
  final List list;
  final List listAll;
  final String myIdcontroller;
  final OnChangeCallback listBack;
  final OnChangeCallback checkboxValues;
  @override
  State<ResponsiveEmailSave> createState() => _ResponsiveEmailSaveState();
}

class _ResponsiveEmailSaveState extends State<ResponsiveEmailSave> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 770) {
          return EmailSave(
            myIdcontroller: widget.myIdcontroller,
            listAll: widget.listAll,
            checkboxValues: (value) {
              setState(() {
                widget.checkboxValues(value);
              });
            },
            listBack: (value) {
              setState(() {
                widget.listBack(value);
              });
            },
            list: widget.list,
            device: 'M',
          );
        } else if (constraints.maxWidth < 1199) {
          return EmailSave(
            myIdcontroller: widget.myIdcontroller,
            listAll: widget.listAll,
            checkboxValues: (value) {
              setState(() {
                widget.checkboxValues(value);
              });
            },
            listBack: (value) {
              setState(() {
                widget.listBack(value);
              });
            },
            list: widget.list,
            device: 'T',
          );
        } else {
          return EmailSave(
            myIdcontroller: widget.myIdcontroller,
            listAll: widget.listAll,
            checkboxValues: (value) {
              setState(() {
                widget.checkboxValues(value);
              });
            },
            listBack: (value) {
              setState(() {
                widget.listBack(value);
              });
            },
            list: widget.list,
            device: 'D',
          );
        }
      },
    );
  }
}
