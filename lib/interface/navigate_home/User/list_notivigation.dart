// ignore_for_file: override_on_non_overriding_member, unused_local_variable, body_might_complete_normally_nullable, unused_field
import 'dart:convert';
import 'package:get/get.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'detail_Screen.dart';
import 'detail_notivigtion.dart';

class Notivigation_day extends StatefulWidget {
  const Notivigation_day({super.key});

  @override
  State<Notivigation_day> createState() => _Notivigation_dayState();
}

class _Notivigation_dayState extends State<Notivigation_day> {
  @override
  void initState() {
    super.initState();
  }

  String? list_data;
  @override
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
  String? start, end;
  List list = [];

  Future<List> fetchData_by_date(start, end) async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_nativigatoin_2?start=${start}&end=${end}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        list = jsonData;
        // print('ok');
      });
    }
    return list;
  }

  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime onewday = DateTime(now.year, now.month, now.day);
    DateTime twowday = DateTime(now.year, now.month, now.day + 1);
    //
    DateTime oneMonthAgo = DateTime(now.year, now.month);
    DateTime twoMonthAgo = DateTime(now.year, now.month - 1);
    DateTime threeMonthAgo = DateTime(now.year, now.month - 2);
    DateTime fourMonthAgo = DateTime(now.year, now.month - 3);
    DateTime fiveMonthAgo = DateTime(now.year, now.month - 4);
    DateTime sexMonthAgo = DateTime(now.year, now.month - 5);
    DateTime servenMonthAgo = DateTime(now.year, now.month - 6);
    DateTime eigthMonthAgo = DateTime(now.year, now.month - 7);
    DateTime nigthMonthAgo = DateTime(now.year, now.month - 8);
    DateTime tenMonthAgo = DateTime(now.year, now.month - 9);
    DateTime elevenMonthAgo = DateTime(now.year, now.month - 10);
    ////////
    String formattedDate_now = DateFormat('yyyy-MM-dd').format(onewday);
    String formattedDate_ago = DateFormat('yyyy-MM-dd').format(twowday);

    ///
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

    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 22, 13, 160),
          centerTitle: true,
          title: const Text('List of Notivigation'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back))),
      body: SingleChildScrollView(
          child: Column(
        children: [
          // Text('${formattedDate_3}'),
          // Text('${formattedDate_2}'),
          GFAccordion(
            titleBorder: Border.all(width: 1),
            collapsedTitleBackgroundColor:
                const Color.fromRGBO(238, 238, 238, 1),
            contentBackgroundColor: Colors.blue[100],
            expandedTitleBackgroundColor:
                const Color.fromRGBO(187, 222, 251, 1),
            title: "Notivigation : ${formattedDate_0}",
            collapsedIcon: const Icon(Icons.notifications_active_outlined),
            onToggleCollapsed: (p0) async {
              setState(() {
                formattedDate_now;
                formattedDate_ago;
              });
              await fetchData_by_date(formattedDate_now, formattedDate_ago);
              list1 = list;
              if (list1.length != 0) {
                list_data = 'have data';
              } else {
                list_data = 'no data';
              }
            },
            contentPadding: const EdgeInsets.all(0),
            contentChild: Column(
              children: [
                (list1.length != 0 && list_data == 'have data')
                    ? Container(
                        width: MediaQuery.of(context).size.width * 1,
                        padding: EdgeInsets.all(5),
                        child: PaginatedDataTable(
                          horizontalMargin: 5.0,
                          arrowHeadColor: Colors.blueAccent[300],
                          columns: [
                            DataColumn(
                                label: Text(
                              'UseID',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Name',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Gender',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Phone',
                              style: TextStyle(color: Colors.green),
                            )),
                          ],
                          dataRowHeight: 50,
                          rowsPerPage: on_row,
                          onRowsPerPageChanged: (value) {
                            setState(() {
                              on_row = value!;
                            });
                          },
                          source: new _DataSource(list1, list1.length, context),
                        ),
                      )
                    : (list_data == 'no data' && list1.length == 0)
                        ? Text('No data')
                        : Center(
                            child: CircularProgressIndicator(),
                          )
              ],
            ),
          ),
          GFAccordion(
            titleBorder: Border.all(width: 1),
            collapsedTitleBackgroundColor: Color.fromRGBO(238, 238, 238, 1),
            contentBackgroundColor: Colors.blue[100],
            expandedTitleBackgroundColor: Color.fromRGBO(187, 222, 251, 1),
            title: "Notivigation : ${formattedDate_1}",
            collapsedIcon: Icon(Icons.notifications_active_outlined),
            onToggleCollapsed: (p0) async {
              list2 = await fetchData_by_date(formattedDate_1, formattedDate_0);

              list2 = list;
              if (list2.length != 0) {
                list_data = 'have data';
              } else {
                list_data = 'no data';
              }
            },
            contentPadding: const EdgeInsets.all(0),
            contentChild: Column(
              children: [
                (list2.length != 0 && list_data == 'have data')
                    ? Container(
                        width: MediaQuery.of(context).size.width * 1,
                        padding: EdgeInsets.all(5),
                        child: PaginatedDataTable(
                          horizontalMargin: 5.0,
                          arrowHeadColor: Colors.blueAccent[300],
                          columns: [
                            DataColumn(
                                label: Text(
                              'UseID',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Name',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Gender',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Phone',
                              style: TextStyle(color: Colors.green),
                            )),
                          ],
                          dataRowHeight: 50,
                          rowsPerPage: on_row,
                          onRowsPerPageChanged: (value) {
                            setState(() {
                              on_row = value!;
                            });
                          },
                          source: new _DataSource(list2, list2.length, context),
                        ),
                      )
                    : (list_data == 'no data' && list2.length == 0)
                        ? Text('No data')
                        : Center(
                            child: CircularProgressIndicator(),
                          )
              ],
            ),
          ),
          GFAccordion(
            titleBorder: Border.all(width: 1),
            collapsedTitleBackgroundColor: Color.fromRGBO(238, 238, 238, 1),
            contentBackgroundColor: Colors.blue[100],
            expandedTitleBackgroundColor: Color.fromRGBO(187, 222, 251, 1),
            title: "Notivigation : ${formattedDate_2}",
            collapsedIcon: Icon(Icons.notifications_active_outlined),
            onToggleCollapsed: (p0) async {
              list3 = await fetchData_by_date(formattedDate_2, formattedDate_1);

              list3 = list;
              if (list3.length != 0) {
                list_data = 'have data';
              } else {
                list_data = 'no data';
              }
            },
            contentPadding: const EdgeInsets.all(0),
            contentChild: Column(
              children: [
                (list3.length != 0 && list_data == 'have data')
                    ? Container(
                        width: MediaQuery.of(context).size.width * 1,
                        padding: EdgeInsets.all(5),
                        child: PaginatedDataTable(
                          horizontalMargin: 5.0,
                          arrowHeadColor: Colors.blueAccent[300],
                          columns: [
                            DataColumn(
                                label: Text(
                              'UseID',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Name',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Gender',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Phone',
                              style: TextStyle(color: Colors.green),
                            )),
                          ],
                          dataRowHeight: 50,
                          rowsPerPage: on_row,
                          onRowsPerPageChanged: (value) {
                            setState(() {
                              on_row = value!;
                            });
                          },
                          source: new _DataSource(list3, list3.length, context),
                        ),
                      )
                    : (list_data == 'no data' && list3.length == 0)
                        ? Text('No data')
                        : Center(
                            child: CircularProgressIndicator(),
                          )
              ],
            ),
          ),
          GFAccordion(
            titleBorder: Border.all(width: 1),
            collapsedTitleBackgroundColor: Color.fromRGBO(238, 238, 238, 1),
            contentBackgroundColor: Colors.blue[100],
            expandedTitleBackgroundColor: Color.fromRGBO(187, 222, 251, 1),
            title: "Notivigation : ${formattedDate_3}",
            collapsedIcon: Icon(Icons.notifications_active_outlined),
            onToggleCollapsed: (p0) async {
              list4 = await fetchData_by_date(formattedDate_3, formattedDate_2);

              list4 = list;
              if (list4.length != 0) {
                list_data = 'have data';
              } else {
                list_data = 'no data';
              }
            },
            contentPadding: const EdgeInsets.all(0),
            contentChild: Column(
              children: [
                (list4.length != 0 && list_data == 'have data')
                    ? Container(
                        width: MediaQuery.of(context).size.width * 1,
                        padding: EdgeInsets.all(5),
                        child: PaginatedDataTable(
                          horizontalMargin: 5.0,
                          arrowHeadColor: Colors.blueAccent[300],
                          columns: [
                            DataColumn(
                                label: Text(
                              'UseID',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Name',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Gender',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Phone',
                              style: TextStyle(color: Colors.green),
                            )),
                          ],
                          dataRowHeight: 50,
                          rowsPerPage: on_row,
                          onRowsPerPageChanged: (value) {
                            setState(() {
                              on_row = value!;
                            });
                          },
                          source: new _DataSource(list4, list4.length, context),
                        ),
                      )
                    : (list_data == 'no data' && list4.length == 0)
                        ? Text('No data')
                        : Center(
                            child: CircularProgressIndicator(),
                          )
              ],
            ),
          ),
          GFAccordion(
            titleBorder: Border.all(width: 1),
            collapsedTitleBackgroundColor: Color.fromRGBO(238, 238, 238, 1),
            contentBackgroundColor: Colors.blue[100],
            expandedTitleBackgroundColor: Color.fromRGBO(187, 222, 251, 1),
            title: "Notivigation : ${formattedDate_4}",
            collapsedIcon: Icon(Icons.notifications_active_outlined),
            onToggleCollapsed: (p0) async {
              list5 = await fetchData_by_date(formattedDate_4, formattedDate_3);
              list5 = list;
              if (list5.length != 0) {
                list_data = 'have data';
              } else {
                list_data = 'no data';
              }
            },
            contentPadding: const EdgeInsets.all(0),
            contentChild: Column(
              children: [
                (list5.length != 0 && list_data == 'have data')
                    ? Container(
                        width: MediaQuery.of(context).size.width * 1,
                        padding: EdgeInsets.all(5),
                        child: PaginatedDataTable(
                          horizontalMargin: 5.0,
                          arrowHeadColor: Colors.blueAccent[300],
                          columns: [
                            DataColumn(
                                label: Text(
                              'UseID',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Name',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Gender',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Phone',
                              style: TextStyle(color: Colors.green),
                            )),
                          ],
                          dataRowHeight: 50,
                          rowsPerPage: on_row,
                          onRowsPerPageChanged: (value) {
                            setState(() {
                              on_row = value!;
                            });
                          },
                          source: new _DataSource(list5, list5.length, context),
                        ),
                      )
                    : (list_data == 'no data' && list5.length == 0)
                        ? Text('No data')
                        : Center(
                            child: CircularProgressIndicator(),
                          )
              ],
            ),
          ),
          GFAccordion(
            titleBorder: Border.all(width: 1),
            collapsedTitleBackgroundColor: Color.fromRGBO(238, 238, 238, 1),
            contentBackgroundColor: Colors.blue[100],
            expandedTitleBackgroundColor: Color.fromRGBO(187, 222, 251, 1),
            title: "Notivigation : ${formattedDate_6}",
            collapsedIcon: Icon(Icons.notifications_active_outlined),
            onToggleCollapsed: (p0) async {
              list6 = await fetchData_by_date(formattedDate_6, formattedDate_5);
              list6 = list;
              if (list6.length != 0) {
                list_data = 'have data';
              } else {
                list_data = 'no data';
              }
            },
            contentPadding: const EdgeInsets.all(0),
            contentChild: Column(
              children: [
                (list6.length != 0 && list_data == 'have data')
                    ? Container(
                        width: MediaQuery.of(context).size.width * 1,
                        padding: EdgeInsets.all(5),
                        child: PaginatedDataTable(
                          horizontalMargin: 5.0,
                          arrowHeadColor: Colors.blueAccent[300],
                          columns: [
                            DataColumn(
                                label: Text(
                              'UseID',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Name',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Gender',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Phone',
                              style: TextStyle(color: Colors.green),
                            )),
                          ],
                          dataRowHeight: 50,
                          rowsPerPage: on_row,
                          onRowsPerPageChanged: (value) {
                            setState(() {
                              on_row = value!;
                            });
                          },
                          source: new _DataSource(list6, list6.length, context),
                        ),
                      )
                    : (list_data == 'no data' && list6.length == 0)
                        ? Text('No data')
                        : Center(
                            child: CircularProgressIndicator(),
                          )
              ],
            ),
          ),
          GFAccordion(
            titleBorder: Border.all(width: 1),
            collapsedTitleBackgroundColor: Color.fromRGBO(238, 238, 238, 1),
            contentBackgroundColor: Colors.blue[100],
            expandedTitleBackgroundColor: Color.fromRGBO(187, 222, 251, 1),
            title: "Notivigation : ${formattedDate_7}",
            collapsedIcon: Icon(Icons.notifications_active_outlined),
            onToggleCollapsed: (p0) async {
              list7 = await fetchData_by_date(formattedDate_7, formattedDate_6);
              list7 = list;
              if (list7.length != 0) {
                list_data = 'have data';
              } else {
                list_data = 'no data';
              }
            },
            contentPadding: const EdgeInsets.all(0),
            contentChild: Column(
              children: [
                (list7.length != 0 && list_data == 'have data')
                    ? Container(
                        width: MediaQuery.of(context).size.width * 1,
                        padding: EdgeInsets.all(5),
                        child: PaginatedDataTable(
                          horizontalMargin: 5.0,
                          arrowHeadColor: Colors.blueAccent[300],
                          columns: [
                            DataColumn(
                                label: Text(
                              'UseID',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Name',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Gender',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Phone',
                              style: TextStyle(color: Colors.green),
                            )),
                          ],
                          dataRowHeight: 50,
                          rowsPerPage: on_row,
                          onRowsPerPageChanged: (value) {
                            setState(() {
                              on_row = value!;
                            });
                          },
                          source: new _DataSource(list7, list7.length, context),
                        ),
                      )
                    : (list_data == 'no data' && list7.length == 0)
                        ? Text('No data')
                        : Center(
                            child: CircularProgressIndicator(),
                          )
              ],
            ),
          ),
          GFAccordion(
            titleBorder: Border.all(width: 1),
            collapsedTitleBackgroundColor: Color.fromRGBO(238, 238, 238, 1),
            contentBackgroundColor: Colors.blue[100],
            expandedTitleBackgroundColor: Color.fromRGBO(187, 222, 251, 1),
            title: "Notivigation : ${formattedDate_8}",
            collapsedIcon: Icon(Icons.notifications_active_outlined),
            onToggleCollapsed: (p0) async {
              list8 = await fetchData_by_date(
                formattedDate_8,
                formattedDate_7,
              );
              list8 = list;
              if (list8.length != 0) {
                list_data = 'have data';
              } else {
                list_data = 'no data';
              }
            },
            contentPadding: const EdgeInsets.all(0),
            contentChild: Column(
              children: [
                (list8.length != 0 && list_data == 'have data')
                    ? Container(
                        width: MediaQuery.of(context).size.width * 1,
                        padding: EdgeInsets.all(5),
                        child: PaginatedDataTable(
                          horizontalMargin: 5.0,
                          arrowHeadColor: Colors.blueAccent[300],
                          columns: [
                            DataColumn(
                                label: Text(
                              'UseID',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Name',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Gender',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Phone',
                              style: TextStyle(color: Colors.green),
                            )),
                          ],
                          dataRowHeight: 50,
                          rowsPerPage: on_row,
                          onRowsPerPageChanged: (value) {
                            setState(() {
                              on_row = value!;
                            });
                          },
                          source: new _DataSource(list8, list8.length, context),
                        ),
                      )
                    : (list_data == 'no data' && list8.length == 0)
                        ? Text('No data')
                        : Center(
                            child: CircularProgressIndicator(),
                          )
              ],
            ),
          ),
          GFAccordion(
            titleBorder: Border.all(width: 1),
            collapsedTitleBackgroundColor: Color.fromRGBO(238, 238, 238, 1),
            contentBackgroundColor: Colors.blue[100],
            expandedTitleBackgroundColor: Color.fromRGBO(187, 222, 251, 1),
            title: "Notivigation : ${formattedDate_9}",
            collapsedIcon: Icon(Icons.notifications_active_outlined),
            onToggleCollapsed: (p0) async {
              list9 = await fetchData_by_date(formattedDate_9, formattedDate_8);
              list9 = list;
              if (list9.length != 0) {
                list_data = 'have data';
              } else {
                list_data = 'no data';
              }
            },
            contentPadding: const EdgeInsets.all(0),
            contentChild: Column(
              children: [
                (list9.length != 0 && list_data == 'have data')
                    ? Container(
                        width: MediaQuery.of(context).size.width * 1,
                        padding: EdgeInsets.all(5),
                        child: PaginatedDataTable(
                          horizontalMargin: 5.0,
                          arrowHeadColor: Colors.blueAccent[300],
                          columns: [
                            DataColumn(
                                label: Text(
                              'UseID',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Name',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Gender',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Phone',
                              style: TextStyle(color: Colors.green),
                            )),
                          ],
                          dataRowHeight: 50,
                          rowsPerPage: on_row,
                          onRowsPerPageChanged: (value) {
                            setState(() {
                              on_row = value!;
                            });
                          },
                          source: new _DataSource(list9, list9.length, context),
                        ),
                      )
                    : (list_data == 'no data' && list9.length == 0)
                        ? Text('No data')
                        : Center(
                            child: CircularProgressIndicator(),
                          )
              ],
            ),
          ),
          GFAccordion(
            titleBorder: Border.all(width: 1),
            collapsedTitleBackgroundColor: Color.fromRGBO(238, 238, 238, 1),
            contentBackgroundColor: Colors.blue[100],
            expandedTitleBackgroundColor: Color.fromRGBO(187, 222, 251, 1),
            title: "Notivigation : ${formattedDate_10}",
            collapsedIcon: Icon(Icons.notifications_active_outlined),
            onToggleCollapsed: (p0) async {
              list10 =
                  await fetchData_by_date(formattedDate_10, formattedDate_9);
              list10 = list;
              if (list10.length != 0) {
                list_data = 'have data';
              } else {
                list_data = 'no data';
              }
            },
            contentPadding: const EdgeInsets.all(0),
            contentChild: Column(
              children: [
                (list10.length != 0 && list_data == 'have data')
                    ? Container(
                        width: MediaQuery.of(context).size.width * 1,
                        padding: EdgeInsets.all(5),
                        child: PaginatedDataTable(
                          horizontalMargin: 5.0,
                          arrowHeadColor: Colors.blueAccent[300],
                          columns: [
                            DataColumn(
                                label: Text(
                              'UseID',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Name',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Gender',
                              style: TextStyle(color: Colors.green),
                            )),
                            DataColumn(
                                label: Text(
                              'Phone',
                              style: TextStyle(color: Colors.green),
                            )),
                          ],
                          dataRowHeight: 50,
                          rowsPerPage: on_row,
                          onRowsPerPageChanged: (value) {
                            setState(() {
                              on_row = value!;
                            });
                          },
                          source:
                              new _DataSource(list10, list10.length, context),
                        ),
                      )
                    : (list_data == 'no data' && list10.length == 0)
                        ? Text('No data')
                        : Center(
                            child: CircularProgressIndicator(),
                          )
              ],
            ),
          ),
        ],
      )),
    );
  }
}

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
              return index % 2 == 0
                  ? Color.fromARGB(168, 73, 83, 224)
                  : Colors.white;
            }
            return index % 2 == 0
                ? Color.fromARGB(255, 255, 162, 162)
                : Colors.white;
          },
        ),
        cells: [
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  item['id'].toString(),
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => Detail_Notivigation2(
                          list_widget: item,
                          id: item['id'].toString(),
                        )),
              );
            },
          ),
          DataCell(
            Text(
              item['username'].toString(),
              style: TextStyle(fontSize: 10),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => Detail_Notivigation2(
                          list_widget: item,
                          id: item['id'].toString(),
                        )),
              );
            },
          ),
          DataCell(
            Text(
              item['gender'].toString(),
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => Detail_Notivigation2(
                          list_widget: item,
                          id: item['id'].toString(),
                        )),
              );
            },
          ),
          DataCell(
            Text(
              item['tel_num'].toString(),
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => Detail_Notivigation2(
                          list_widget: item,
                          id: item['id'].toString(),
                        )),
              );
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
