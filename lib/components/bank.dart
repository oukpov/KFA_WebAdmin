// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, unused_import, avoid_print, non_constant_identifier_names, unused_field, unused_element
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class BankDropdown extends StatefulWidget {
  const BankDropdown({
    Key? key,
    required this.bank,
    required this.bankbranch,
    this.bn,
    this.brn,
  }) : super(key: key);
  final OnChangeCallback bank;
  final OnChangeCallback bankbranch;
  final String? bn;
  final String? brn;
  @override
  State<BankDropdown> createState() => _BankDropdownState();
}

class _BankDropdownState extends State<BankDropdown> {
  var _list = [];
  var _branch = [];
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
    return Column(
      children: [
        Container(
          height: 58,
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
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
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Please select bank';
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
              fillColor: kwhite,
              filled: true, contentPadding: EdgeInsets.symmetric(vertical: 8),

              labelText: ((widget.bn == null) ? 'Bank' : widget.bn),
              hintText: 'Select',

              prefixIcon: Icon(
                Icons.home_work,
                color: kImageColor,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: kPrimaryColor,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: kerror,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: kerror,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              //   decoration: InputDecoration(
              //       labelText: 'From',
              //       prefixIcon: Icon(Icons.business_outlined)),
            ),
          ),
        ),
        _district_l
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: 58,
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
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
                    fillColor: kwhite,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),

                    filled: true,
                    labelText: ((widget.brn == null) ? 'Branch' : widget.bn),
                    hintText: 'Select',

                    prefixIcon: Icon(
                      Icons.account_tree_rounded,
                      color: kImageColor,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    //   decoration: InputDecoration(
                    //       labelText: 'From',
                    //       prefixIcon: Icon(Icons.business_outlined)),
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
