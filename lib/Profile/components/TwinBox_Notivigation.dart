// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

typedef OnChangeCallback = void Function(dynamic value);

class TwinBox_read extends StatefulWidget {
  final String labelText1;
  final String labelText2;
  final String fname;
  final String lname;
  final OnChangeCallback get_fname;
  final OnChangeCallback get_lname;
  const TwinBox_read({
    Key? key,
    required this.labelText1,
    required this.labelText2,
    required this.fname,
    required this.lname,
    required this.get_fname,
    required this.get_lname,
  }) : super(key: key);

  @override
  State<TwinBox_read> createState() => _TwinBoxState();
}

class _TwinBoxState extends State<TwinBox_read> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 140,
          color: Color.fromARGB(255, 255, 255, 255),
          child: TextFormField(
            readOnly: true,
            initialValue: widget.fname,
            onChanged: (value) {
              setState(() {
                widget.get_fname(value);
              });
            },
            decoration: InputDecoration(
              fillColor: Color.fromARGB(255, 255, 255, 255),
              filled: true,
              labelText: widget.labelText1,
            ),
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Container(
          height: 60,
          width: 140,
          color: Color.fromARGB(255, 255, 255, 255),
          child: TextFormField(
            readOnly: true,
            initialValue: widget.lname,
            onChanged: (value) {
              setState(() {
                widget.get_lname(value);
              });
            },
            decoration: InputDecoration(
              fillColor: Color.fromARGB(255, 255, 255, 255),
              filled: true,
              labelText: widget.labelText2,
            ),
          ),
        )
      ],
    );
  }
}

// class TwinBox extends StatelessWidget {
//   final String labelText1;
//   final String labelText2;
//   final String fname;
//   final String lname;

//   const TwinBox({
//     Key? key,
//     required this.labelText1,
//     required this.labelText2,
//     required this.fname,
//     required this.lname,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           height: 60,
//           width: 140,
//           color: Color.fromARGB(255, 255, 255, 255),
//           child: TextFormField(
//             initialValue: fname,
//             decoration: InputDecoration(
//               fillColor: Color.fromARGB(255, 255, 255, 255),
//               filled: true,
//               labelText: labelText1,
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 6,
//         ),
//         Container(
//           height: 60,
//           width: 140,
//           color: Color.fromARGB(255, 255, 255, 255),
//           child: TextFormField(
//             initialValue: lname,
//             decoration: InputDecoration(
//               fillColor: Color.fromARGB(255, 255, 255, 255),
//               filled: true,
//               labelText: labelText2,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
