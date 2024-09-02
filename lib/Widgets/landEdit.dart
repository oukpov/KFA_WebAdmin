// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import '../../../../components/ApprovebyAndVerifyby.dart';
import '../components/colors.dart';

class LandbuildingEdit extends StatefulWidget {
  const LandbuildingEdit(
      {super.key,
      required this.w,
      required this.l,
      required this.total,
      required this.title,
      required this.checkvalidate,
      required this.lvalue,
      required this.wvalue,
      required this.totalvalue});
  final OnChangeCallback l;
  final OnChangeCallback w;
  final OnChangeCallback total;
  final String title;
  final bool checkvalidate;
  final String lvalue;
  final String wvalue;
  final String totalvalue;
  @override
  _MultiplyFormState createState() => _MultiplyFormState();
}

class _MultiplyFormState extends State<LandbuildingEdit> {
  TextEditingController controllerA = TextEditingController();
  TextEditingController controllerB = TextEditingController();
  TextEditingController controllerTotal = TextEditingController();
  double _total = 0;
  @override
  void initState() {
    controllerA.text = widget.lvalue;
    controllerB.text = widget.wvalue;
    controllerTotal.text = widget.totalvalue;

    super.initState();
  }

  @override
  void dispose() {
    controllerA.dispose();
    controllerB.dispose();
    super.dispose();
  }

  void _updateTotal() {
    double a = double.tryParse(controllerA.text) ?? 0;
    double b = double.tryParse(controllerB.text) ?? 0;

    setState(() {
      _total = a * b;
      controllerTotal.text = _total.toString();
      widget.l(a);
      widget.w(b);
      widget.total(_total);
    });
  }

  bool checkland = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title,
            style: TextStyle(
                color: !checkland ? whiteColor : colorsRed, fontSize: 15)),
        const SizedBox(height: 5),
        Container(
          height: 55,
          decoration: BoxDecoration(
            border: Border.all(
                width: 2, color: !checkland ? whiteColor : colorsRed),
            borderRadius: BorderRadius.circular(5),
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: TextFormField(
                      controller: controllerA,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        labelText: ' Lenght',
                        fillColor: kwhite,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (value) => _updateTotal(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: TextFormField(
                      controller: controllerB,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        // prefixIcon: Icon(
                        //   Icons.width_full_outlined,
                        //   color: kImageColor,
                        // ),
                        fillColor: kwhite,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        labelText: 'W',
                      ),
                      onChanged: (value) => _updateTotal(),
                    ),
                  ),
                ),
                Text(
                  '  =  ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: whiteColor),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: TextFormField(
                      validator: (value) {
                        if (widget.checkvalidate == true) {
                          if (controllerTotal.text == "" &&
                              widget.title == "Land") {
                            setState(() {
                              checkland = true;
                            });
                          } else {
                            setState(() {
                              checkland = false;
                            });
                          }
                        }
                      },
                      controller: controllerTotal,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        fillColor: kwhite,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        labelText: 'Total',
                      ),
                      onChanged: (value) {
                        setState(() {
                          widget.total(controllerTotal.text);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
