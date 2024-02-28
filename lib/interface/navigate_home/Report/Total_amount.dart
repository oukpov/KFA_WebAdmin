// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'Detail.dart';

class Total_Amount extends StatefulWidget {
  const Total_Amount({super.key});

  @override
  State<Total_Amount> createState() => _Total_AmountState();
}

class _Total_AmountState extends State<Total_Amount> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 216, 217, 218),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey[100],
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 86, 85, 85),
            )),
        title: Text('Total Amount',
            style: TextStyle(color: Color.fromARGB(255, 61, 61, 61))),
      ),
      body: _body(),
    );
  }

  List list1 = [];
  List list2 = [];
  List list3 = [];
  List list4 = [];
  List list5 = [];
  List list6 = [];
  List list7 = [];
  List list8 = [];
  List list9 = [];
  List list10 = [];
  int on_row = 10;
  Widget _body() {
    DateTime now = DateTime.now();
    DateTime oneMonthAgo = DateTime(now.year, now.month - 1);
    DateTime twoMonthAgo = DateTime(now.year, now.month - 2);
    DateTime threeMonthAgo = DateTime(now.year, now.month - 3);
    DateTime fourMonthAgo = DateTime(now.year, now.month - 4);
    DateTime fiveMonthAgo = DateTime(now.year, now.month - 5);
    DateTime sexMonthAgo = DateTime(now.year, now.month - 6);
    DateTime servenMonthAgo = DateTime(now.year, now.month - 7);
    DateTime eigthMonthAgo = DateTime(now.year, now.month - 8);
    DateTime nigthMonthAgo = DateTime(now.year, now.month - 9);
    DateTime tenMonthAgo = DateTime(now.year, now.month - 10);
    DateTime elevenMonthAgo = DateTime(now.year, now.month - 11);
    String formattedDate_0 = DateFormat('yyyy-MM-dd').format(now);
    String formattedDate_1 = DateFormat('yyyy-MM-dd').format(oneMonthAgo);
    String formattedDate_2 = DateFormat('yyyy-MM-dd').format(twoMonthAgo);
    String formattedDate_3 = DateFormat('yyyy-MM-dd').format(threeMonthAgo);
    String formattedDate_4 = DateFormat('yyyy-MM-dd').format(fourMonthAgo);
    String formattedDate_5 = DateFormat('yyyy-MM-dd').format(fiveMonthAgo);
    String formattedDate_6 = DateFormat('yyyy-MM-dd').format(sexMonthAgo);
    String formattedDate_7 = DateFormat('yyyy-MM-dd').format(servenMonthAgo);
    String formattedDate_8 = DateFormat('yyyy-MM-dd').format(eigthMonthAgo);
    String formattedDate_9 = DateFormat('yyyy-MM-dd').format(nigthMonthAgo);
    String formattedDate_10 = DateFormat('yyyy-MM-dd').format(tenMonthAgo);
    String formattedDate_11 = DateFormat('yyyy-MM-dd').format(tenMonthAgo);
    return SingleChildScrollView(
      child: Column(
        children: [
          _Option(),
          Date(formattedDate_2, formattedDate_1, 1),
          Date(formattedDate_3, formattedDate_2, 2),
          Date(formattedDate_4, formattedDate_3, 3),
          Date(formattedDate_5, formattedDate_4, 4),
          Date(formattedDate_6, formattedDate_5, 5),
          Date(formattedDate_7, formattedDate_6, 6),
          Date(formattedDate_8, formattedDate_7, 7),
          Date(formattedDate_9, formattedDate_8, 8),
          Date(formattedDate_10, formattedDate_9, 9),
          Date(formattedDate_11, formattedDate_10, 10),
        ],
      ),
    );
  }

  List list_await = [];
  int val = 0;
  int groupValue = 0;
  Widget _Option() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _text('UPAY BANK'),
          GFRadio(
            size: 20,
            activeBorderColor: GFColors.SUCCESS,
            value: 0,
            groupValue: groupValue,
            onChanged: (val) {
              setState(() {
                groupValue = int.parse(val.toString());
                print('UPAY = $groupValue');
                type = true;
              });
            },
            inactiveIcon: null,
            radioColor: GFColors.SUCCESS,
          ),
          _text('WING BANK'),
          GFRadio(
            size: 20,
            activeBorderColor: GFColors.SUCCESS,
            value: 1,
            groupValue: groupValue,
            onChanged: (val) {
              setState(() {
              groupValue = int.parse(val.toString());
                print('Wing = $groupValue');
                type = true;
              });
            },
            inactiveIcon: null,
            radioColor: GFColors.SUCCESS,
          ),
          _text('ABA BANK'),
          GFRadio(
            size: 20,
            activeBorderColor: GFColors.SUCCESS,
            value: 2,
            groupValue: groupValue,
            onChanged: (val) {
              setState(() {
                groupValue = int.parse(val.toString());
              });
            },
            inactiveIcon: null,
            radioColor: GFColors.SUCCESS,
          ),
        ],
      ),
    );
  }

  bool type = false;
  Widget Date(start, end, int i) {
    var result;
    List list = [];

    bool _await = false;
    return GFAccordion(
      collapsedTitleBackgroundColor:const Color.fromRGBO(238, 238, 238, 1),
      contentBackgroundColor: Colors.blue[100],
      expandedTitleBackgroundColor:const Color.fromRGBO(187, 222, 251, 1),
      title: "Date Amount : ${end}",
      onToggleCollapsed: (p0) async {
        //
        result = await date_await(start, end,
            '${(groupValue == 0) ? 'user_VPoint_date' : 'Wing_VPoint'}');
        setState(() {
          list = result['list'];
          print('List Date Amount = ${list.toString()}');
          print('start = ${start.toString()}  start = ${end.toString()}');
          setState(() {
            if (groupValue == 0) {
              payment = 'payAmount';
            } else {
              payment = 'amount';
            }
            if (i == 1) {
              list1 = list;
            } else if (i == 2) {
              list2 = list;
            } else if (i == 3) {
              list3 = list;
            } else if (i == 4) {
              list4 = list;
            } else if (i == 5) {
              list5 = list;
            } else if (i == 6) {
              list6 = list;
            } else if (i == 7) {
              list7 = list;
            } else if (i == 8) {
              list8 = list;
            } else if (i == 9) {
              list9 = list;
            } else {
              list10 = list;
            }
          });
        });
      },
      contentPadding: const EdgeInsets.all(0),
      contentChild: Column(
        children: [
          (type == false)
              ? Center(child: CircularProgressIndicator())
              : _PaginatedDataTable((i == 1)
                  ? list1
                  : (i == 2)
                      ? list2
                      : (i == 3)
                          ? list3
                          : (i == 4)
                              ? list4
                              : (i == 5)
                                  ? list5
                                  : (i == 6)
                                      ? list6
                                      : (i == 7)
                                          ? list7
                                          : (i == 8)
                                              ? list8
                                              : (i == 9)
                                                  ? list9
                                                  : list10)
        ],
      ),
    );
  }

  Widget _text(text) {
    return Text(
      text,
      style: TextStyle(
          color: Color.fromARGB(255, 46, 45, 45),
          fontSize: MediaQuery.textScaleFactorOf(context) * 09,
          fontWeight: FontWeight.bold),
    );
  }

  Widget _PaginatedDataTable(List list) {
    // return Text(list.length.toString());
    return PaginatedDataTable(
      horizontalMargin: 5.0,
      arrowHeadColor: Color.fromARGB(255, 176, 177, 179),
      columns: [
        DataColumn(label: _text('User ID')),
        // DataColumn(label: _text('Bank')),
        DataColumn(label: _text('Name')),
        DataColumn(label: _text('Gender')),
        DataColumn(label: _text('V Point')),
        DataColumn(label: _text('Payment')),
        DataColumn(label: _text('Phone')),
        DataColumn(label: _text('Email')),
      ],
      dataRowHeight: 50,
      rowsPerPage: on_row,
      onRowsPerPageChanged: (value) {
        setState(() {
          on_row = value!;
        });
      },
      source: new _DataSource(list, list.length, context),
    );
  }

  Future<Map<String, dynamic>> date_await(start, end, api) async {
    List list = [];
    bool _await = false;
    list = await Get_User(start, end, api);
    print(api.toString());
    return {
      'list': list,
      '_await': _await,
    };
  }

  Future<List> Get_User(start, end, api) async {
    List list = [];
    final rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/$api?start=$start&end=$end'));
    // 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user_VPoint_date?start=2021-7-1&end=2024-9-1'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        list = jsonData;
        type = true;
      });
    }
    return list;
  }
}

void Naviga(BuildContext context, List list, index, type_bank) {
  Navigator.push(context, MaterialPageRoute(
    builder: (context) {
      return Detai_VPoint(
        TypePayment_bank: type_bank,
        list: list,
        index_get: index.toString(),
      );
    },
  ));
}

String? payment;

class _DataSource extends DataTableSource {
  final List data;
  final int count_row;
  final BuildContext context;
  _DataSource(this.data, this.count_row, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];

    return DataRow(
        selected: true,
        color: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return index % 2 == 0 ? Colors.grey[300] : Colors.white;
            }
            return index % 2 == 0
                ? Color.fromARGB(255, 255, 162, 162)
                : Colors.white;
          },
        ),
        cells: [
          DataCell(
            Text(
              '${(item['control_user'] != null) ? item['control_user'].toString() : ""}',
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Naviga(context, data, index, payment);
            },
          ),
          DataCell(
            placeholder: true,
            Text(
              '${(item['username'] != null) ? item['username'].toString() : ""}',
              style: TextStyle(fontSize: 10),
            ),
            onTap: () {
              Naviga(context, data, index, payment);
            },
          ),
          DataCell(
            Text(
              '${(item['gender'] != null) ? item['gender'].toString() : ""}',
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Naviga(context, data, index, payment);
            },
          ),
          DataCell(
            Text(
              '${(item['count_autoverbal'] != null) ? item['count_autoverbal'].toString() : ""}',
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Naviga(context, data, index, payment);
            },
          ),
          DataCell(
            Text(
              '${(item['$payment'] != null) ? item['$payment'].toString() : ""}',
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Naviga(context, data, index, payment);
            },
          ),
          DataCell(
            Text(
              '${(item['tel_num'] != null) ? item['tel_num'].toString() : ""}',
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Naviga(context, data, index, payment);
            },
          ),
          DataCell(
            Text(
              '${(item['email'] != null) ? item['email'].toString() : ""}',
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Naviga(context, data, index, payment);
            },
          ),
        ]);
  }

  @override
  int get rowCount => count_row;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
