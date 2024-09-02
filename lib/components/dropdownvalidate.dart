// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, unused_import, avoid_print, non_constant_identifier_names, unused_field, unused_element
import 'dart:convert';
import 'dart:math';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:web_admin/page/navigate_setting/bank/brand/new_brand.dart';

import 'colors.dart';
import 'colors/colors.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Dropdownvalidate extends StatefulWidget {
  const Dropdownvalidate({
    Key? key,
    required this.bank,
    required this.bankbranch,
    this.bn,
    this.brn,
    required this.flex,
    required this.filedName,
    this.validator,
  }) : super(key: key);
  final OnChangeCallback bank;
  final String filedName;
  final OnChangeCallback bankbranch;
  final String? bn;
  final OnChangeCallback? validator;
  final String? brn;
  final int flex;
  @override
  State<Dropdownvalidate> createState() => _DropdownvalidateState();
}

class _DropdownvalidateState extends State<Dropdownvalidate> {
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

  bool validateAndSave(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data1')),
      );
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data2')),
      );
      return false;
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Expanded(
        flex: widget.flex,
        child: Column(
          children: [
            GFButton(
                text: 'Save',
                onPressed: () {
                  setState(() {
                    validateAndSave(context);
                  });
                }),
            DropdownButtonFormField<String>(
              isExpanded: true,
              onChanged: (newValue) {
                setState(() async {
                  bankvalue = newValue as String;

                  widget.bank(bankvalue);

                  // branch(newValue.toString());
                  await _district();
                  widget.bankbranch(_branch);
                  // print(newValue);
                });
              },
              validator: (newValue) {
                if (newValue == null || newValue.isEmpty) {
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
                            fontSize:
                                MediaQuery.textScaleFactorOf(context) * 13,
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
                fillColor: Color.fromARGB(255, 255, 255, 255),
                filled: true,
                labelText: 'Email',
                prefixIcon: Icon(
                  Icons.email,
                  color: kImageColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(0, 126, 250, 1), width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color.fromRGBO(0, 126, 250, 1),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color.fromARGB(255, 249, 0, 0),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color.fromARGB(255, 249, 0, 0),
                  ),
                  //  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
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
