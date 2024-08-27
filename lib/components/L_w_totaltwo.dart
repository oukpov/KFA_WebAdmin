// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

import '../page/navigate_home/Customer/component/Web/simple/inputfiledRowVld.dart';
import '../page/navigate_home/Customer/component/Web/simple/inputfiledRowtwo.dart';
import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Land_buildingtwo extends StatefulWidget {
  Land_buildingtwo(
      {super.key,
      required this.w,
      required this.l,
      required this.total,
      this.l_get,
      this.total_get,
      this.w_get,
      this.ltext,
      this.wtext,
      this.l_total,
      required this.filedName,
      this.flex});
  final OnChangeCallback l;
  final OnChangeCallback w;
  final OnChangeCallback total;
  final String filedName;
  final int? flex;
  String? w_get;
  String? l_get;
  String? total_get;
  String? ltext;
  String? wtext;
  String? l_total;

  @override
  _MultiplyFormState createState() => _MultiplyFormState();
}

class _MultiplyFormState extends State<Land_buildingtwo> {
  TextEditingController _controllerA = TextEditingController();
  TextEditingController _controllerB = TextEditingController();
  int _total = 0;
  var sizebox10h = const SizedBox(height: 10);
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: (widget.flex == null) ? 0 : int.parse(widget.flex.toString()),
          child: TextFormField(
            controller: _controllerA,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              // prefixIcon: Icon(
              //   Icons.width_full_outlined,
              //   color: kImageColor,
              // ),
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
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                width: 1,
                color: Colors.red,
              )),
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
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              // prefixIcon: Icon(
              //   Icons.width_full_outlined,
              //   color: kImageColor,
              // ),
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
              labelText: widget.wtext,
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
            width: MediaQuery.of(context).size.width * 0.9,
            height: 45,
            child: (_total != 0) ? Text('$_total') : Text('${widget.l_total}'),
          ),
        ),
        // Expanded(d
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
