import 'package:flutter/material.dart';

import 'MyListings.dart';

class ResponseListings extends StatefulWidget {
  const ResponseListings({super.key, required this.myIdcontroller});
  final String myIdcontroller;
  @override
  State<ResponseListings> createState() => _ResponseListingsState();
}

class _ResponseListingsState extends State<ResponseListings> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 770) {
          return MyListings(
            myIdcontroller: widget.myIdcontroller,
            device: 'M',
          );
        } else if (constraints.maxWidth < 1199) {
          return MyListings(
            myIdcontroller: widget.myIdcontroller,
            device: 'T',
          );
        } else {
          return MyListings(
            myIdcontroller: widget.myIdcontroller,
            device: 'D',
          );
        }
      },
    );
  }
}
