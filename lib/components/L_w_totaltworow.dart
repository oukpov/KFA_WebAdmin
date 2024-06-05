// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

import '../interface/navigate_home/Customer/component/Web/simple/inputfiledRowVld.dart';
import '../interface/navigate_home/Customer/component/Web/simple/inputfiledRowtwo.dart';
import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Land_buildingtwoRow extends StatefulWidget {
  Land_buildingtwoRow(
      {super.key,
      required this.w,
      required this.l,
      required this.total,
      this.l_get,
      this.total_get,
      this.w_get,
      required this.filedName,
      this.flex,
      this.l_total,
      required this.ltext,
      required this.wtext});
  final OnChangeCallback l;
  final OnChangeCallback w;
  final OnChangeCallback total;
  final String filedName;
  final int? flex;
  final String ltext;
  final String wtext;
  String? w_get;
  String? l_get;
  String? l_total;
  String? total_get;

  @override
  _MultiplyFormState createState() => _MultiplyFormState();
}

class _MultiplyFormState extends State<Land_buildingtwoRow> {
  TextEditingController _controllerA = TextEditingController();
  TextEditingController _controllerB = TextEditingController();
  int _total = 0;
  var sizebox10h = const SizedBox(width: 10);
  @override
  void initState() {
    if (widget.l_get == 'new_executive') {
      _controllerA = TextEditingController(text: widget.l_get.toString());
      _controllerB = TextEditingController(text: widget.w_get.toString());
      _total = int.parse(widget.total_get.toString());
    } else {}

    super.initState();
  }

  @override
  void dispose() {
    _controllerA.dispose();
    _controllerB.dispose();

    super.dispose();
  }

  void _updateTotal() {
    int a = int.tryParse(_controllerA.text) ?? 0;
    int b = int.tryParse(_controllerB.text) ?? 0;
    setState(() {
      _total = a * b;
      widget.l(a.toString());
      widget.total(_total.toString());
      widget.w(b.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width * 0.2;
    double w2 = 35;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: (widget.flex == null) ? 0 : int.parse(widget.flex.toString()),
          child: TextFormField(
            controller: _controllerA,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              helperStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.textScaleFactorOf(context) * 12),
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.textScaleFactorOf(context) * 12),
              prefixIcon: const SizedBox(width: 7),
              fillColor: kwhite,
              filled: true,
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
              labelText: widget.ltext,
            ),
            onChanged: (value) => _updateTotal(),
          ),
        ),
        sizebox10h,
        Expanded(
          //flex: 3,
          flex: (widget.flex == null) ? 0 : int.parse(widget.flex.toString()),
          child: TextFormField(
            controller: _controllerB,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              // labelStyle: ,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              fillColor: kwhite,
              filled: true,
              labelText: widget.wtext,
              hintText: widget.wtext,
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
            ),
            onChanged: (value) => _updateTotal(),
          ),
        ),
        sizebox10h,
        Expanded(
          flex: (widget.flex == null) ? 0 : int.parse(widget.flex.toString()),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Color.fromARGB(2, 19, 20, 20),
                border: Border.all(
                  width: 1,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(5.0)),
            width: MediaQuery.of(context).size.width * 0.09,
            height: 46,
            child: (_total != 0)
                ? Text('$_total')
                : Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      '${widget.l_total}',
                      style: TextStyle(
                        fontSize: MediaQuery.textScaleFactorOf(context) * 12,
                      ),
                    ),
                  ),
          ),
        ),

        // Expanded(
        //   flex: widget.flex,
        //   child: SizedBox(
        //     width: w2,
        //     child: TextFormField(
        //       controller: _controllerA,
        //       keyboardType: TextInputType.number,
        //       decoration: InputDecoration(
        //             // labelStyle: ,
        //             contentPadding:
        //                 const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        //             fillColor: kwhite,
        //             filled: true,
        //             labelText: widget.filedName,
        //             hintText: widget.filedName,
        //             labelStyle: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: MediaQuery.textScaleFactorOf(context) * 12),
        //             helperStyle: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: MediaQuery.textScaleFactorOf(context) * 12),
        //             prefixIcon: const SizedBox(width: 7),
        //             focusedBorder: OutlineInputBorder(
        //               borderSide:
        //                   const BorderSide(color: kPrimaryColor, width: 1.0),
        //               borderRadius: BorderRadius.circular(5.0),
        //             ),
        //             enabledBorder: OutlineInputBorder(
        //               // borderSide: BorderSide(
        //               //   width: 1,
        //               //   color: (!hasError && widget.validator == true)
        //               //       ? Colors.red
        //               //       : bordertxt,
        //               // ),
        //               borderRadius: BorderRadius.circular(5.0),
        //             ),
        //           ),
        //       onChanged: (value) => _updateTotal(),
        //     ),
        //   ),
        // ),
        // Expanded(
        //   flex: widget.flex,
        //   child: SizedBox(
        //     width: w2,
        //     child: TextFormField(
        //       controller: _controllerB,
        //       keyboardType: TextInputType.number,
        //       decoration: InputDecoration(
        //             // labelStyle: ,
        //             contentPadding:
        //                 const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        //             fillColor: kwhite,
        //             filled: true,
        //             labelText: widget.filedName,
        //             hintText: widget.filedName,
        //             labelStyle: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: MediaQuery.textScaleFactorOf(context) * 12),
        //             helperStyle: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: MediaQuery.textScaleFactorOf(context) * 12),
        //             prefixIcon: const SizedBox(width: 7),
        //             focusedBorder: OutlineInputBorder(
        //               borderSide:
        //                   const BorderSide(color: kPrimaryColor, width: 1.0),
        //               borderRadius: BorderRadius.circular(5.0),
        //             ),
        //             enabledBorder: OutlineInputBorder(
        //               // borderSide: BorderSide(
        //               //   width: 1,
        //               //   color: (!hasError && widget.validator == true)
        //               //       ? Colors.red
        //               //       : bordertxt,
        //               // ),
        //               borderRadius: BorderRadius.circular(5.0),
        //             ),
        //           ),
        //       onChanged: (value) => _updateTotal(),
        //     ),
        //   ),
        // ),
        // Text(
        //   '=',
        //   style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       fontSize: MediaQuery.of(context).size.height * 0.04,
        //       color: kImageColor),
        // ),
        // Expanded(
        //   flex: widget.flex,
        //   child: Container(
        //     alignment: Alignment.centerLeft,
        //     decoration: BoxDecoration(
        //         color: Colors.white,
        //         border: Border.all(width: 2, color: Colors.white),
        //         borderRadius: BorderRadius.circular(10)
        //         ),
        //     width: w,
        //     height: MediaQuery.of(context).size.height * 0.065,
        //     child: (_total != 0) ? Text('$_total') : Text('Total'),
        //   ),
        // )
      ],
    );
  }
}
