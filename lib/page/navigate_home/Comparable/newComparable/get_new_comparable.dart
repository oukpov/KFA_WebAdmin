// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_admin/models/savecomparablemodel.dart';
import '../../Customer/component/Web/simple/inputfiled.dart';
import '../../Customer/component/Web/simple/inputfiledRow.dart';
import '../../Customer/component/title/title.dart';

// ignore: camel_case_types
class Get_NewComarable extends StatefulWidget {
  const Get_NewComarable(
      {super.key,
      required this.device,
      required this.email,
      required this.idUsercontroller,
      required this.myIdcontroller,
      required this.username,
      required this.index});
  final int index;
  final String device;
  final String email;
  final String idUsercontroller;
  final String myIdcontroller;
  final String username;
  @override
  State<Get_NewComarable> createState() => _Get_NewComarableState();
}

class _Get_NewComarableState extends State<Get_NewComarable> {
  bool waitPosts = false;
  List _list = [];
  late SavenewcomparableModel savenewcomparableModel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var sizebox40h = const SizedBox(height: 40);
  var sizebox10h = const SizedBox(height: 10);
  var sizebox = const SizedBox(width: 10);
  var sizeboxw40 = const SizedBox(width: 40);
  List listbranch = [""];
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_new
    savenewcomparableModel = new SavenewcomparableModel(
        bankinfo: '',
        condition: '',
        latittute: '',
        longtittute: '',
        ownerphone: '',
        propertytype: '',
        skc: '',
        surveydate: '');
    setState(() {
      getnewcomparable();
    });
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();

    return DateFormat('yyyy-MM-dd').format(now);
  }

  void getNow() {
    setState(() {
      String today = getCurrentDate();
      // comparabledate = today;
      // comparable_survey_date = today;
    });
  }

  Future getnewcomparable() async {
    var headers = {
      'Accept': 'application/json',
      'Connection': 'application/json',
      'Content-Type': 'application/json'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparable_search',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        _list = jsonDecode(json.encode(response.data));
      });
    } else {
      print(response.statusMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width * 0.35 * 1.35;
    return Scaffold(
        appBar: AppBar(
          elevation: 10,
          // title: Text("New Comparable $comparable_survey_date"),
          title: const Text("Detail New Comparable"),
        ),
        body: (_list.isNotEmpty)
            ? SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(right: 0, left: 10),
                    child: (widget.device == 'm')
                        ? Form(
                            key: _formKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 30, left: 30),
                              child: Column(
                                children: [
                                  sizebox10h,
                                  titletexts('Bank Info *', context),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_officer = value;
                                        });
                                      },
                                      filedName: _list[widget.index]
                                              ['bank_name'] ??
                                          ''.toString(),
                                      flex: 4),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: _list[widget.index]
                                              ['bank_branch_name'] ??
                                          ''.toString(),
                                      flex: 4),
                                  sizebox10h,
                                  titletexts('Bank Officer', context),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_officer = value;
                                        });
                                      },
                                      filedName: ((_list[widget.index]
                                                      ['com_bankofficer']
                                                  .toString()) ==
                                              'null')
                                          ? ''
                                          : (_list[widget.index]
                                                  ['com_bankofficer']
                                              .toString()),
                                      flex: 4),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: ((_list[widget.index][
                                                      'com_bankofficer_contact']
                                                  .toString()) ==
                                              'null')
                                          ? ''
                                          : (_list[widget.index]
                                                  ['com_bankofficer_contact']
                                              .toString()),
                                      flex: 4),
                                  sizebox10h,
                                  titletexts('Zoning', context),
                                  sizebox10h,
                                  Container(
                                    height: 45,
                                    child: InputfiedRow(
                                        //validator: true,
                                        readOnly: true,
                                        value: (value) {
                                          setState(() {
                                            // com_bank_contact = value;
                                          });
                                        },
                                        //doesn't have zone yet
                                        filedName: _list[widget.index][''] ??
                                            ''.toString(),
                                        flex: 4),
                                  ),
                                  sizebox10h,
                                  titletexts('Property Type *', context),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: _list[widget.index]
                                              ['property_type_name'] ??
                                          ''.toString(),
                                      flex: 4),
                                  sizebox10h,
                                  titletexts('Road', context),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: _list[widget.index]
                                              ['road_name'] ??
                                          ''.toString(),
                                      flex: 4),
                                  sizebox10h,
                                  titletexts('Land', context),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName:
                                          "Length: ${((_list[widget.index]['comparable_land_length'].toString()) == 'null') ? '' : (_list[widget.index]['comparable_land_length'].toString())}",
                                      flex: 4),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName:
                                          "Width: ${((_list[widget.index]['comparable_land_width'].toString()) == 'null') ? '' : (_list[widget.index]['comparable_land_width'].toString())}",
                                      flex: 4),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName:
                                          "Total: ${((_list[widget.index]['comparable_land_total'].toString()) == 'null') ? '' : (_list[widget.index]['comparable_land_total'].toString())}",
                                      flex: 4),

                                  sizebox10h,
                                  titletexts('Building', context),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName:
                                          "Length: ${((_list[widget.index]['comparable_sold_length'].toString()) == 'null') ? '' : (_list[widget.index]['comparable_sold_length'].toString())}",
                                      flex: 4),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName:
                                          "Width: ${((_list[widget.index]['comparable_sold_width'].toString()) == 'null') ? '' : (_list[widget.index]['comparable_sold_width'].toString())}",
                                      flex: 4),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName:
                                          "Total: ${((_list[widget.index]['comparable_sold_total'].toString()) == 'null') ? '' : (_list[widget.index]['comparable_sold_total'].toString())}",
                                      flex: 4),
                                  sizebox10h,
                                  titletexts('Price Per Sqm', context),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName:
                                          "${_list[widget.index]['comparable_adding_price'].toString()} \$",
                                      flex: 4),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: ((_list[widget.index][
                                                      'comparableaddpricetotal']
                                                  .toString()) ==
                                              '1')
                                          ? 'Totally'
                                          // ignore: unrelated_type_equality_checks
                                          : ((_list[widget.index][
                                                          'comparableaddpricetotal']
                                                      .toString()) ==
                                                  '2')
                                              ? 'Sqm'
                                              : '',
                                      flex: 4),
                                  sizebox10h,
                                  titletexts('Offered Price', context),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: ((_list[widget.index]
                                                      ['comparableaddprice']
                                                  .toString()) ==
                                              'null')
                                          ? ''
                                          : (_list[widget.index]
                                                  ['comparableaddprice']
                                              .toString()),
                                      //"${_list[0]['comparableaddprice'].toString()} \$",
                                      flex: 4),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: // ignore: unrelated_type_equality_checks
                                          ((_list[widget.index][
                                                          'comparableaddpricetotal']
                                                      .toString()) ==
                                                  '1')
                                              ? 'Totally'
                                              // ignore: unrelated_type_equality_checks
                                              : ((_list[widget.index][
                                                              'comparableaddpricetotal']
                                                          .toString()) ==
                                                      '2')
                                                  ? 'Sqm'
                                                  : '',
                                      //"${_list[0]['comparableaddprice'].toString()} \$",
                                      flex: 4),
                                  sizebox10h,
                                  titletexts('Offered Price', context),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: ((_list[widget.index]
                                                      ['comparableboughtprice']
                                                  .toString()) ==
                                              'null')
                                          ? ''
                                          : (_list[widget.index]
                                                  ['comparableboughtprice']
                                              .toString()),
                                      // "${_list[0]['comparableboughtprice'].toString()} \$",
                                      flex: 4),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: ((_list[widget.index][
                                                      'comparableboughtpricetotal']
                                                  .toString()) ==
                                              '1')
                                          ? 'Totally'
                                          // ignore: unrelated_type_equality_checks
                                          : ((_list[widget.index][
                                                          'comparableboughtpricetotal']
                                                      .toString()) ==
                                                  '2')
                                              ? 'Sqm'
                                              : '',
                                      // "${_list[0]['comparableboughtprice'].toString()} \$",
                                      flex: 4),
                                  sizebox10h,

                                  titletexts('Sold Out Price', context),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: ((_list[widget.index]
                                                      ['comparable_sold_price']
                                                  .toString()) ==
                                              'null')
                                          ? ''
                                          : (_list[widget.index]
                                                  ['comparable_sold_price']
                                              .toString()),
                                      flex: 4),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: ((_list[widget.index][
                                                      'comparable_sold_total_price']
                                                  .toString()) ==
                                              '1')
                                          ? 'Totally'
                                          // ignore: unrelated_type_equality_checks
                                          : ((_list[widget.index][
                                                          'comparable_sold_total_price']
                                                      .toString()) ==
                                                  '2')
                                              ? 'Sqm'
                                              : '',
                                      flex: 4),
                                  sizebox10h,
                                  titletexts('Asking Price(TTAmount)', context),
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: ((_list[widget.index]
                                                      ['comparableAmount']
                                                  .toString()) ==
                                              'null')
                                          ? ''
                                          : _list[widget.index]
                                                  ['comparableAmount']
                                              .toString(),
                                      flex: 4),
                                  sizebox10h,
                                  titletexts('Condition*', context),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: ((_list[widget.index][
                                                      'comparable_condition_id']
                                                  .toString()) ==
                                              '1')
                                          ? 'Condition 1'
                                          : ((_list[widget.index][
                                                          'comparable_condition_id']
                                                      .toString()) ==
                                                  '2')
                                              ? 'Condtion 2'
                                              : '',
                                      flex: 4),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: ((_list[widget.index]
                                                      ['comparable_year']
                                                  .toString()) ==
                                              'null')
                                          ? ''
                                          : _list[widget.index]
                                                  ['comparable_year']
                                              .toString(),
                                      flex: 4),
                                  sizebox10h,
                                  titletexts('Address', context),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: ((_list[widget.index]
                                                      ['comparable_address']
                                                  .toString()) ==
                                              'null')
                                          ? ''
                                          : _list[widget.index]
                                                  ['comparable_address']
                                              .toString(),
                                      flex: 4),
                                  sizebox10h,
                                  titletexts('SKC', context),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: _list[widget.index]['province']
                                          .toString(),
                                      flex: 4),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: _list[widget.index]['district']
                                          .toString(),
                                      flex: 4),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: _list[widget.index]['commune']
                                          .toString(),
                                      flex: 4),
                                  sizebox10h,
                                  titletexts('Date*', context),
                                  sizebox10h,
                                  //Text(comparabledate.toString()),
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: _list[widget.index]
                                              ['comparableDate']
                                          .toString(),
                                      flex: 4),
                                  sizebox10h,
                                  titletexts('Remark', context),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: ((_list[widget.index]
                                                      ['comparable_remark']
                                                  .toString()) ==
                                              'null')
                                          ? ''
                                          : _list[widget.index]
                                                  ['comparable_remark']
                                              .toString(),
                                      flex: 4),
                                  sizebox10h,
                                  titletexts('Survey Date*', context),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: _list[widget.index]
                                              ['comparable_survey_date']
                                          .toString(),
                                      flex: 4),
                                  sizebox10h,
                                  titletexts('Owner Phone*', context),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: _list[widget.index]
                                              ['comparable_phone']
                                          .toString(),
                                      flex: 4),
                                  sizebox10h,
                                  titletexts('Latittute*', context),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: _list[widget.index]
                                              ['latlong_log']
                                          .toString(),
                                      flex: 4),
                                  sizebox10h,
                                  titletexts('Longitude*', context),
                                  sizebox10h,
                                  InputfiedRow(
                                      //validator: true,
                                      readOnly: true,
                                      value: (value) {
                                        setState(() {
                                          // com_bank_contact = value;
                                        });
                                      },
                                      filedName: _list[widget.index]
                                              ['latlong_la']
                                          .toString(),
                                      flex: 4),
                                  sizebox10h,
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Container(
                                      height: 400,
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      margin: const EdgeInsets.only(
                                          top: 15, right: 13, left: 15),
                                      child: FadeInImage.assetNetwork(
                                        placeholderCacheHeight: 120,
                                        placeholderCacheWidth: 120,
                                        fit: BoxFit.cover,
                                        placeholderFit: BoxFit.contain,
                                        placeholder: 'assets/earth.gif',
                                        image:
                                            // 'https://maps.googleapis.com/maps/api/staticmap?center=${_list[widget.index]['latlong_la'].toString()},${_list[widget.index]['latlong_log'].toString()}&zoom=15&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${_list[widget.index]['latlong_la'].toString()},${_list[widget.index]['latlong_log'].toString()}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                                            'https://maps.googleapis.com/maps/api/staticmap?center=${(double.parse(_list[widget.index]['latlong_la'].toString()) < double.parse(_list[widget.index]['latlong_log'].toString())) ? "${_list[widget.index]['latlong_la'].toString()},${_list[widget.index]['latlong_log'].toString()}" : "${_list[widget.index]['latlong_log'].toString()},${_list[widget.index]['latlong_la'].toString()}"}&zoom=15&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${(double.parse(_list[widget.index]['latlong_la'].toString()) < double.parse(_list[widget.index]['latlong_log'].toString())) ? "${_list[widget.index]['latlong_la'].toString()},${_list[widget.index]['latlong_log'].toString()}" : "${_list[widget.index]['latlong_log'].toString()},${_list[widget.index]['latlong_la'].toString()}"}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ))
                        : Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                children: [
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext(
                                                  'Bank Info', '', context),
                                              Inputfied(
                                                filedName: _list[widget.index]
                                                        ['bank_name'] ??
                                                    ''.toString(),
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                              sizebox,
                                              Inputfied(
                                                filedName: _list[widget.index]
                                                        ['bank_branch_name'] ??
                                                    ''.toString(),
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                              // SizedBox(
                                              //   width: w,
                                              // ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: w,
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext(
                                                  'Bank Officer', '', context),
                                              Inputfied(
                                                filedName: ((_list[widget.index]
                                                                [
                                                                'com_bankofficer']
                                                            .toString()) ==
                                                        'null')
                                                    ? ''
                                                    : (_list[widget.index]
                                                            ['com_bankofficer']
                                                        .toString()),
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                              sizebox,
                                              Inputfied(
                                                filedName: ((_list[widget.index]
                                                                [
                                                                'com_bankofficer_contact']
                                                            .toString()) ==
                                                        'null')
                                                    ? ''
                                                    : (_list[widget.index][
                                                            'com_bankofficer_contact']
                                                        .toString()),
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext('Zoning', '', context),
                                              Inputfied(
                                                filedName: '',
                                                flex: 4,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  //Property Guider Name
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext(
                                                  'Property Type', '', context),
                                              Inputfied(
                                                filedName: _list[widget.index][
                                                        'property_type_name'] ??
                                                    ''.toString(),
                                                flex: 4,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext('Road', '', context),
                                              Inputfied(
                                                filedName: _list[widget.index]
                                                        ['road_name'] ??
                                                    ''.toString(),
                                                flex: 4,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext('Land', '', context),
                                              Inputfied(
                                                filedName:
                                                    "Length: ${((_list[widget.index]['comparable_land_length'].toString()) == 'null') ? '' : (_list[widget.index]['comparable_land_length'].toString())}",
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                              sizebox,
                                              Inputfied(
                                                filedName:
                                                    "Width: ${((_list[widget.index]['comparable_land_width'].toString()) == 'null') ? '' : (_list[widget.index]['comparable_land_width'].toString())}",
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                              sizebox,
                                              Inputfied(
                                                filedName:
                                                    "Total: ${((_list[widget.index]['comparable_land_total'].toString()) == 'null') ? '' : (_list[widget.index]['comparable_land_total'].toString())}",
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext(
                                                  'Building', '', context),
                                              Inputfied(
                                                filedName:
                                                    "Length: ${((_list[widget.index]['comparable_sold_length'].toString()) == 'null') ? '' : (_list[widget.index]['comparable_sold_length'].toString())}",
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                              sizebox,
                                              Inputfied(
                                                filedName:
                                                    "Width: ${((_list[widget.index]['comparable_sold_width'].toString()) == 'null') ? '' : (_list[widget.index]['comparable_sold_width'].toString())}",
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                              sizebox,
                                              Inputfied(
                                                filedName:
                                                    "Total: ${((_list[widget.index]['comparable_sold_total'].toString()) == 'null') ? '' : (_list[widget.index]['comparable_sold_total'].toString())}",
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext(
                                                  'Price Per Sqm', '', context),
                                              Inputfied(
                                                filedName:
                                                    "${_list[widget.index]['comparable_adding_price'].toString()} \$",
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                              sizebox,
                                              Inputfied(
                                                filedName: ((_list[widget.index]
                                                                [
                                                                'comparableaddpricetotal']
                                                            .toString()) ==
                                                        '1')
                                                    ? 'Totally'
                                                    // ignore: unrelated_type_equality_checks
                                                    : ((_list[widget.index][
                                                                    'comparableaddpricetotal']
                                                                .toString()) ==
                                                            '2')
                                                        ? 'Sqm'
                                                        : '',
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext(
                                                  'Offered Price', '', context),
                                              Inputfied(
                                                filedName: ((_list[widget.index]
                                                                [
                                                                'comparableaddprice']
                                                            .toString()) ==
                                                        'null')
                                                    ? ''
                                                    : (_list[widget.index][
                                                            'comparableaddprice']
                                                        .toString()),
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                              sizebox,
                                              Inputfied(
                                                filedName: ((_list[widget.index]
                                                                [
                                                                'comparableaddpricetotal']
                                                            .toString()) ==
                                                        '1')
                                                    ? 'Totally'
                                                    // ignore: unrelated_type_equality_checks
                                                    : ((_list[widget.index][
                                                                    'comparableaddpricetotal']
                                                                .toString()) ==
                                                            '2')
                                                        ? 'Sqm'
                                                        : '',
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext(
                                                  'Offered Price', '', context),
                                              Inputfied(
                                                filedName: ((_list[widget.index]
                                                                [
                                                                'comparableboughtprice']
                                                            .toString()) ==
                                                        'null')
                                                    ? ''
                                                    : (_list[widget.index][
                                                            'comparableboughtprice']
                                                        .toString()),
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                              sizebox,
                                              Inputfied(
                                                filedName: ((_list[widget.index]
                                                                [
                                                                'comparableboughtpricetotal']
                                                            .toString()) ==
                                                        '1')
                                                    ? 'Totally'
                                                    // ignore: unrelated_type_equality_checks
                                                    : ((_list[widget.index][
                                                                    'comparableboughtpricetotal']
                                                                .toString()) ==
                                                            '2')
                                                        ? 'Sqm'
                                                        : '',
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext('Sold Out Price', '',
                                                  context),
                                              Inputfied(
                                                filedName: ((_list[widget.index]
                                                                [
                                                                'comparable_sold_price']
                                                            .toString()) ==
                                                        'null')
                                                    ? ''
                                                    : (_list[widget.index][
                                                            'comparable_sold_price']
                                                        .toString()),
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                              sizebox,
                                              Inputfied(
                                                filedName: ((_list[widget.index]
                                                                [
                                                                'comparable_sold_total_price']
                                                            .toString()) ==
                                                        '1')
                                                    ? 'Totally'
                                                    // ignore: unrelated_type_equality_checks
                                                    : ((_list[widget.index][
                                                                    'comparable_sold_total_price']
                                                                .toString()) ==
                                                            '2')
                                                        ? 'Sqm'
                                                        : '',
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  filedtext('Asking Price', '',
                                                      context),
                                                  filedtext('(TTAmount)', '',
                                                      context),
                                                ],
                                              ),
                                              Inputfied(
                                                filedName: ((_list[widget.index]
                                                                [
                                                                'comparableAmount']
                                                            .toString()) ==
                                                        'null')
                                                    ? ''
                                                    : _list[widget.index]
                                                            ['comparableAmount']
                                                        .toString(),
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                              sizebox,
                                              Inputfied(
                                                filedName: _list[widget.index]
                                                        ['bank_branch_name'] ??
                                                    ''.toString(),
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext(
                                                  'Condition', '', context),
                                              Inputfied(
                                                filedName: ((_list[widget.index]
                                                                [
                                                                'comparable_condition_id']
                                                            .toString()) ==
                                                        '1')
                                                    ? 'Condition 1'
                                                    : ((_list[widget.index][
                                                                    'comparable_condition_id']
                                                                .toString()) ==
                                                            '2')
                                                        ? 'Condtion 2'
                                                        : '',
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                              sizebox,
                                              Inputfied(
                                                filedName: ((_list[widget.index]
                                                                [
                                                                'comparable_year']
                                                            .toString()) ==
                                                        'null')
                                                    ? ''
                                                    : _list[widget.index]
                                                            ['comparable_year']
                                                        .toString(),
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: w * 2,
                                          child: Row(
                                            children: [
                                              filedtext('Address', '', context),
                                              Inputfied(
                                                filedName: ((_list[widget.index]
                                                                [
                                                                'comparable_address']
                                                            .toString()) ==
                                                        'null')
                                                    ? ''
                                                    : _list[widget.index][
                                                            'comparable_address']
                                                        .toString(),
                                                flex: 8,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: w * 2,
                                          child: Row(
                                            children: [
                                              filedtext('SKC', '', context),
                                              Inputfied(
                                                filedName: _list[widget.index]
                                                        ['province']
                                                    .toString(),
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                              sizebox,
                                              Inputfied(
                                                filedName: _list[widget.index]
                                                        ['district']
                                                    .toString(),
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                              sizebox,
                                              Inputfied(
                                                filedName: _list[widget.index]
                                                        ['commune']
                                                    .toString(),
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext('Date', '', context),
                                              Inputfied(
                                                filedName: _list[widget.index]
                                                        ['comparableDate']
                                                    .toString(),
                                                flex: 4,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                              //sizebox,
                                              // Inputfied(
                                              //   filedName: _list[widget.index]
                                              //           ['bank_branch_name'] ??
                                              //       ''.toString(),
                                              //   flex: 2,
                                              //   readOnly: true,
                                              //   validator: false,
                                              //   value: (value) {},
                                              // ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext('Remark', '', context),
                                              Inputfied(
                                                filedName: ((_list[widget.index]
                                                                [
                                                                'comparable_remark']
                                                            .toString()) ==
                                                        'null')
                                                    ? ''
                                                    : _list[widget.index][
                                                            'comparable_remark']
                                                        .toString(),
                                                flex: 4,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext(
                                                  'Survey Date', '', context),
                                              Inputfied(
                                                filedName: _list[widget.index][
                                                        'comparable_survey_date']
                                                    .toString(),
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext(
                                                  'Owner Phone', '', context),
                                              Inputfied(
                                                filedName: _list[widget.index]
                                                        ['comparable_phone']
                                                    .toString(),
                                                flex: 4,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext(
                                                  'Longitude', '', context),
                                              Inputfied(
                                                filedName: _list[widget.index]
                                                        ['latlong_la']
                                                    .toString(),
                                                flex: 2,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext(
                                                  'Latittute', '', context),
                                              Inputfied(
                                                filedName: _list[widget.index]
                                                        ['latlong_log']
                                                    .toString(),
                                                flex: 4,
                                                readOnly: true,
                                                validator: false,
                                                value: (value) {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Container(
                                      height: 400,
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      margin: const EdgeInsets.only(
                                          top: 15, right: 13, left: 15),
                                      child: FadeInImage.assetNetwork(
                                        placeholderCacheHeight: 120,
                                        placeholderCacheWidth: 120,
                                        fit: BoxFit.cover,
                                        placeholderFit: BoxFit.contain,
                                        placeholder: 'assets/earth.gif',
                                        image:
                                            'https://maps.googleapis.com/maps/api/staticmap?center=${(double.parse(_list[widget.index]['latlong_la'].toString()) < double.parse(_list[widget.index]['latlong_log'].toString())) ? "${_list[widget.index]['latlong_la'].toString()},${_list[widget.index]['latlong_log'].toString()}" : "${_list[widget.index]['latlong_log'].toString()},${_list[widget.index]['latlong_la'].toString()}"}&zoom=15&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${(double.parse(_list[widget.index]['latlong_la'].toString()) < double.parse(_list[widget.index]['latlong_log'].toString())) ? "${_list[widget.index]['latlong_la'].toString()},${_list[widget.index]['latlong_log'].toString()}" : "${_list[widget.index]['latlong_log'].toString()},${_list[widget.index]['latlong_la'].toString()}"}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
              )
            : const Center(child: CircularProgressIndicator()));
  }

  List zoningList = [];
  Future<void> genderModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Gender_model'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body)['data'];
          // genderList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }
}
