// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, unused_import, avoid_print, non_constant_identifier_names, unused_field, unused_element
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'colors/colors.dart';
import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class BankDropdownrow extends StatefulWidget {
  const BankDropdownrow({
    Key? key,
    required this.bank,
    required this.bankbranch,
    this.bn,
    this.brn,
    required this.filedName,
    this.validator,
    required this.brandfiledName,
  }) : super(key: key);
  final OnChangeCallback bank;
  final OnChangeCallback bankbranch;
  final OnChangeCallback? validator;
  final String filedName;
  final String brandfiledName;

  final String? bn;
  final String? brn;
  @override
  State<BankDropdownrow> createState() => _BankDropdownrowState();
}

class _BankDropdownrowState extends State<BankDropdownrow> {
  var _list = [];
  var _branch = [];
  bool hasError = false;
  late String bankvalue;
  late String branchvalue;
  var bank = [
    'Bank',
    'Private',
    'Other',
  ];
  @override
  void initState() {
    super.initState();
    bankvalue = "";
    branchvalue = "";
    // ignore: unnecessary_new
    Load();
  }

  bool _district_l = false;
  Future<void> _district() async {
    _district_l = true;
    await Future.wait([branch(bankvalue)]);

    setState(() {
      _district_l = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            onChanged: (newValue) {
              setState(() {
                bankvalue = newValue as String;

                widget.bank(bankvalue);
                print(bankvalue.toString());
                // branch(newValue.toString());
                _district();
                // print(newValue);
              });
            },
            validator: (Value) {
              if (Value == null || Value.isEmpty) {
                setState(() {
                  widget.validator!('require *');
                });
                return 'require *';
              }
              return null;
            },
            items: _list
                .map<DropdownMenuItem<String>>(
                  (value) => DropdownMenuItem<String>(
                    value: value["bank_id"].toString(),
                    child: Text(
                      value["bank_name"],
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
              )),
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
        SizedBox(
          width: 10,
        ),
        _district_l
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  isExpanded: true,

                  onChanged: (String? newValue) {
                    setState(() {
                      branchvalue = newValue!;
                      widget.bankbranch(branchvalue);

                      // print(newValue);
                    });
                  },
                  items: _branch
                      .map<DropdownMenuItem<String>>(
                        (value) => DropdownMenuItem<String>(
                          value: value["bank_branch_id"].toString(),
                          child: Text(
                            value["bank_branch_name"],
                            overflow: TextOverflow.ellipsis,
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
                    labelText: widget.brandfiledName,
                    hintText: widget.brandfiledName,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.textScaleFactorOf(context) * 12),
                    helperStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.textScaleFactorOf(context) * 12),
                    prefixIcon: const SizedBox(width: 7),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 1.0),
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
                ),
              ),
      ],
    );
  }

  void Load() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/bank'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      // print(jsonData);
      // print(jsonData);

      setState(() {
        _list = jsonData['banks'];
      });
    }
  }

  Future<void> branch(String value) async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/bankbranch?bank_branch_details_id=' +
            value));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body.toString());
      // print(jsonData);
      setState(() {
        _branch = jsonData['bank_branches'];
        print(_branch.toString());
      });
    }
  }
}
