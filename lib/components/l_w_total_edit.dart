// ignore_for_file: unused_local_variable, unused_field

import 'package:flutter/material.dart';

import '../Profile/contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Land_building_edit extends StatefulWidget {
  Land_building_edit(
      {super.key,
      required this.w,
      required this.l,
      required this.total,
      required this.l_edit,
      required this.total_edit,
      required this.w_edit});
  final OnChangeCallback l;
  final OnChangeCallback w;
  final OnChangeCallback total;
  String? l_edit;
  String? w_edit;
  String? total_edit;
  @override
  _MultiplyFormState createState() => _MultiplyFormState();
}

class _MultiplyFormState extends State<Land_building_edit> {
  TextEditingController _controllerA = TextEditingController();
  TextEditingController _controllerB = TextEditingController();
  int _total = 0;

  @override
  void dispose() {
    _controllerA.dispose();
    _controllerB.dispose();
    super.dispose();
    // _la = TextEditingController(text: widget.l_edit);
    // _a = _la!.text;
    // _lb = TextEditingController(text: widget.w_edit);
    // _b = _lb!.text;
  }

  TextEditingController? _la;
  TextEditingController? _lb;
  void _updateTotal() {
    int a = int.tryParse(_controllerA.text) ?? 0;
    int b = int.tryParse(_controllerB.text) ?? 0;
    setState(() {
      // _a = a.toString();
      // _b = b.toString();
      _total = a * b;

      widget.l(a.toString());
      widget.total(_total.toString());
      widget.w(b.toString());
    });
  }

  String? _a = '';
  String? _b = '';
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width * 0.2;
    double w2 = MediaQuery.of(context).size.width * 0.2;
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 78, 131, 14),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: w2,
                child: TextFormField(
                  controller: _controllerA,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    labelText: '${widget.l_edit.toString()}',
                    // prefixIcon: Icon(
                    //   Icons.landscape,
                    //   color: kImageColor,
                    // ),
                    fillColor: kwhite,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (value) => _updateTotal(),
                ),
              ),
              Container(
                width: w2,
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
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: '${widget.w_edit.toString()}',
                  ),
                  onChanged: (value) => _updateTotal(),
                ),
              ),
              Text(
                '=',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.04,
                    color: kImageColor),
              ),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                width: w,
                height: MediaQuery.of(context).size.height * 0.065,
                child: (_total != 0)
                    ? Text('$_total')
                    : Text('${widget.total_edit}'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
