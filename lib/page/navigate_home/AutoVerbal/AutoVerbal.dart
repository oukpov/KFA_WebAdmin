// ignore_for_file: unused_field

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import '../../../components/ToFromDate.dart';
import '../../../components/colors.dart';
import '../Add/Detail_Autoverbal.dart';

class Show_autoVerbals extends StatefulWidget {
  const Show_autoVerbals({super.key});

  @override
  State<Show_autoVerbals> createState() => _Show_autoVerbalsState();
}

class _Show_autoVerbalsState extends State<Show_autoVerbals> {
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
  List get_data_AutoVerbal_from_date = [];
  Future<List> fetchData_by_date(start, end) async {
    List list = [];
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list?start=${start}&end=${end}'));

    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        list = jsonData;
      });
    }
    return list;
  }

  List<String> data_id_all = [];
  List<String> data_type_all = [];
  void fetchData_all() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list'));

    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      List data;
      setState(() {
        data = jsonData;
        // print(data[0]['verbal_id']);
        for (int i = 0; i < data.length; i++) {
          data_id_all.add(data[i]["verbal_id"]);
          data_type_all.add(data[i]["property_type_name"].toString());
        }
      });
    }
  }

  List data_get_by_bank = [];
  var name_bank;
  Future<List> fetchData_get_by_bank() async {
    List list = [];

    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list?name_bank=${name_bank}'));

    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        list = jsonData;
      });
    }
    return list;
  }

  int on_row = 10;
  String? start, end;
  bool t1 = false,
      t2 = false,
      t3 = false,
      t4 = false,
      t5 = false,
      t6 = false,
      t7 = false,
      t8 = false,
      t9 = false,
      t10 = false;
  int groupValue = 0;

  @override
  void initState() {
    fetchData_all();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
    double h;
    if (groupValue == 1 || groupValue == 2) {
      h = 0.25;
    } else {
      h = 0.12;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Auto Verbal"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.blue[500],
      ),
      backgroundColor: Colors.blue[500],
      body: Container(
        margin: EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 0, left: 18, right: 18),
                height: MediaQuery.of(context).size.height * h,
                decoration: BoxDecoration(
                  color: Colors.blue[500],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "Search By",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(0.5, 0),
                                blurRadius: 5,
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          " Identity ",
                          style: TextStyle(color: Colors.white),
                        ),
                        GFRadio(
                          size: 20,
                          activeBorderColor: GFColors.SUCCESS,
                          value: 0,
                          groupValue: groupValue,
                          onChanged: (val) {
                            setState(() {
                              groupValue = int.parse(val.toString());
                              data_get_by_bank.clear();
                              get_data_AutoVerbal_from_date.clear();
                            });
                          },
                          inactiveIcon: null,
                          radioColor: GFColors.SUCCESS,
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          " Date ",
                          style: TextStyle(color: Colors.white),
                        ),
                        GFRadio(
                          size: 20,
                          activeBorderColor: GFColors.SUCCESS,
                          value: 1,
                          groupValue: groupValue,
                          onChanged: (val) {
                            setState(() {
                              get_data_AutoVerbal_from_date.clear();
                              groupValue = int.parse(val.toString());
                            });
                          },
                          inactiveIcon: null,
                          radioColor: GFColors.SUCCESS,
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          " Bank ",
                          style: TextStyle(color: Colors.white),
                        ),
                        GFRadio(
                          size: 20,
                          activeBorderColor: GFColors.SUCCESS,
                          value: 2,
                          groupValue: groupValue,
                          onChanged: (val) {
                            setState(() {
                              get_data_AutoVerbal_from_date.clear();
                              groupValue = int.parse(val.toString());
                            });
                          },
                          inactiveIcon: null,
                          radioColor: GFColors.SUCCESS,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (groupValue == 1)
                      Column(
                        children: [
                          ToFromDate(
                            fromDate: (value) {
                              setState(() {
                                start = value.toString();
                              });
                            },
                            toDate: (value) {
                              setState(() {
                                end = value.toString();
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          GFButtonBadge(
                            textStyle: const TextStyle(fontSize: 15),
                            color: Colors.green,
                            onPressed: () async {
                              get_data_AutoVerbal_from_date =
                                  await fetchData_by_date(start, end);
                            },
                            text: "Show..",
                          ),
                        ],
                      ),
                    if (groupValue == 2)
                      Column(
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              setState(() {
                                data_get_by_bank.clear;
                                name_bank = value;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.search,
                                color: kImageColor,
                              ), //icon of text field
                              labelText: "Enter Name of bank",
                              floatingLabelStyle: const TextStyle(
                                  color: Colors.black,
                                  shadows: [
                                    Shadow(
                                      color: Color.fromARGB(255, 94, 53, 88),
                                      offset: Offset(0.5, 0),
                                      blurRadius: 2,
                                    ),
                                  ]),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 8),
                              fillColor: kwhite,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.green, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.green),
                                borderRadius: BorderRadius.circular(10.0),
                              ), //label text of field
                            ),
                          ),
                          const SizedBox(height: 10),
                          GFButtonBadge(
                            textStyle: const TextStyle(fontSize: 15),
                            color: Colors.green,
                            onPressed: () async {
                              data_get_by_bank = await fetchData_get_by_bank();
                            },
                            text: "Show..",
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              if (groupValue == 0)
                InkWell(
                  onTap: () {
                    showSearch(
                        context: context,
                        delegate: verbal_Search(
                          name: data_id_all,
                          type: data_type_all,
                        ));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 50,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: ListTile(
                        onTap: () {
                          showSearch(
                              context: context,
                              delegate: verbal_Search(
                                name: data_id_all,
                                type: data_type_all,
                              ));
                        },
                        leading: const Text('Enter Here'),
                        trailing: const Icon(
                          Icons.search_outlined,
                          color: Colors.grey,
                        )),
                  ),
                )
              else if (groupValue == 1 &&
                  get_data_AutoVerbal_from_date.length >= 1)
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  padding: EdgeInsets.all(5),
                  color: Colors.blue[100],
                  child: PaginatedDataTable(
                    horizontalMargin: 5.0,
                    arrowHeadColor: Colors.blueAccent[300],
                    columns: const [
                      DataColumn(
                          label: Text(
                        'Verbal ID',
                        style: TextStyle(color: Colors.green),
                      )),
                      DataColumn(
                          label: Text(
                        'Bank',
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
                    source: _DataSource(get_data_AutoVerbal_from_date,
                        get_data_AutoVerbal_from_date.length, context),
                  ),
                )
              else if (groupValue == 2 && data_get_by_bank.length >= 1)
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  padding: const EdgeInsets.all(5),
                  color: Colors.blue[100],
                  child: PaginatedDataTable(
                    horizontalMargin: 5.0,
                    arrowHeadColor: Colors.blueAccent[300],
                    columns: const [
                      DataColumn(
                          label: Text(
                        'Verbal ID',
                        style: TextStyle(color: Colors.green),
                      )),
                      DataColumn(
                          label: Text(
                        'Bank',
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
                    source: _DataSource(
                        data_get_by_bank, data_get_by_bank.length, context),
                  ),
                ),
              GFAccordion(
                collapsedTitleBackgroundColor:
                    const Color.fromRGBO(238, 238, 238, 1),
                contentBackgroundColor: Colors.blue[100],
                expandedTitleBackgroundColor:
                    const Color.fromRGBO(187, 222, 251, 1),
                title: "Auto Verbal : ${formattedDate_0}",
                onToggleCollapsed: (p0) async {
                  list1 =
                      await fetchData_by_date(formattedDate_1, formattedDate_0);
                },
                contentPadding: const EdgeInsets.all(0),
                contentChild: Column(
                  children: [
                    if (list1.length >= 1)
                      PaginatedDataTable(
                        horizontalMargin: 5.0,
                        arrowHeadColor: Colors.blueAccent[300],
                        columns: const [
                          DataColumn(
                              label: Text(
                            'Verbal ID',
                            style: TextStyle(color: Colors.green),
                          )),
                          DataColumn(
                              label: Text(
                            'Bank',
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
                        source: _DataSource(list1, list1.length, context),
                      )
                    else
                      const Center(child: CircularProgressIndicator())
                  ],
                ),
              ),
              GFAccordion(
                collapsedTitleBackgroundColor:
                    const Color.fromRGBO(238, 238, 238, 1),
                contentBackgroundColor: Colors.blue[100],
                expandedTitleBackgroundColor:
                    const Color.fromRGBO(187, 222, 251, 1),
                title: "Auto Verbal : ${formattedDate_1}",
                onToggleCollapsed: (p0) async {
                  list2 =
                      await fetchData_by_date(formattedDate_2, formattedDate_1);
                },
                contentPadding: const EdgeInsets.all(0),
                contentChild: Column(
                  children: [
                    if (list2.isNotEmpty)
                      PaginatedDataTable(
                        horizontalMargin: 5.0,
                        arrowHeadColor: Colors.blueAccent[300],
                        columns: const [
                          DataColumn(
                              label: Text(
                            'Verbal ID',
                            style: TextStyle(color: Colors.green),
                          )),
                          DataColumn(
                              label: Text(
                            'Bank',
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
                        source: _DataSource(list2, list2.length, context),
                      )
                    else
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                  ],
                ),
              ),
              GFAccordion(
                collapsedTitleBackgroundColor:
                    const Color.fromRGBO(238, 238, 238, 1),
                contentBackgroundColor: Colors.blue[100],
                expandedTitleBackgroundColor:
                    const Color.fromRGBO(187, 222, 251, 1),
                title: "Auto Verbal : ${formattedDate_2}",
                onToggleCollapsed: (p0) async {
                  list3 =
                      await fetchData_by_date(formattedDate_3, formattedDate_2);
                },
                contentPadding: const EdgeInsets.all(0),
                contentChild: Column(
                  children: [
                    if (list3.isNotEmpty)
                      PaginatedDataTable(
                        horizontalMargin: 5.0,
                        arrowHeadColor: Colors.blueAccent[300],
                        columns: const [
                          DataColumn(
                              label: Text(
                            'Verbal ID',
                            style: TextStyle(color: Colors.green),
                          )),
                          DataColumn(
                              label: Text(
                            'Bank',
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
                        source: _DataSource(list3, list3.length, context),
                      )
                    else
                      const Center(child: CircularProgressIndicator())
                  ],
                ),
              ),
              GFAccordion(
                collapsedTitleBackgroundColor:
                    const Color.fromRGBO(238, 238, 238, 1),
                contentBackgroundColor: Colors.blue[100],
                expandedTitleBackgroundColor:
                    const Color.fromRGBO(187, 222, 251, 1),
                title: "Auto Verbal : ${formattedDate_3}",
                onToggleCollapsed: (p0) async {
                  list4 =
                      await fetchData_by_date(formattedDate_4, formattedDate_3);
                },
                contentPadding: const EdgeInsets.all(0),
                contentChild: Column(
                  children: [
                    if (list4.isNotEmpty)
                      PaginatedDataTable(
                        horizontalMargin: 5.0,
                        arrowHeadColor: Colors.blueAccent[300],
                        columns: const [
                          DataColumn(
                              label: Text(
                            'Verbal ID',
                            style: TextStyle(color: Colors.green),
                          )),
                          DataColumn(
                              label: Text(
                            'Bank',
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
                        source: _DataSource(list4, list4.length, context),
                      )
                    else
                      const Center(child: CircularProgressIndicator())
                  ],
                ),
              ),
              GFAccordion(
                collapsedTitleBackgroundColor:
                    const Color.fromRGBO(238, 238, 238, 1),
                contentBackgroundColor: Colors.blue[100],
                expandedTitleBackgroundColor:
                    const Color.fromRGBO(187, 222, 251, 1),
                title: "Auto Verbal : ${formattedDate_4}",
                onToggleCollapsed: (p0) async {
                  list5 =
                      await fetchData_by_date(formattedDate_5, formattedDate_4);
                },
                contentPadding: const EdgeInsets.all(0),
                contentChild: Column(
                  children: [
                    if (list5.isNotEmpty)
                      PaginatedDataTable(
                        horizontalMargin: 5.0,
                        arrowHeadColor: Colors.blueAccent[300],
                        columns: const [
                          DataColumn(
                              label: Text(
                            'Verbal ID',
                            style: TextStyle(color: Colors.green),
                          )),
                          DataColumn(
                              label: Text(
                            'Bank',
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
                        source: _DataSource(list5, list5.length, context),
                      )
                    else
                      const Center(child: CircularProgressIndicator())
                  ],
                ),
              ),
              GFAccordion(
                collapsedTitleBackgroundColor:
                    const Color.fromRGBO(238, 238, 238, 1),
                contentBackgroundColor: Colors.blue[100],
                expandedTitleBackgroundColor:
                    const Color.fromRGBO(187, 222, 251, 1),
                title: "Auto Verbal : ${formattedDate_5}",
                onToggleCollapsed: (p0) async {
                  list6 =
                      await fetchData_by_date(formattedDate_6, formattedDate_5);
                },
                contentPadding: const EdgeInsets.all(0),
                contentChild: Column(
                  children: [
                    if (list6.isNotEmpty)
                      PaginatedDataTable(
                        horizontalMargin: 5.0,
                        arrowHeadColor: Colors.blueAccent[300],
                        columns: const [
                          DataColumn(
                              label: Text(
                            'Verbal ID',
                            style: TextStyle(color: Colors.green),
                          )),
                          DataColumn(
                              label: Text(
                            'Bank',
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
                        source: _DataSource(list6, list6.length, context),
                      )
                    else
                      const Center(child: CircularProgressIndicator())
                  ],
                ),
              ),
              GFAccordion(
                collapsedTitleBackgroundColor:
                    const Color.fromRGBO(238, 238, 238, 1),
                contentBackgroundColor: Colors.blue[100],
                expandedTitleBackgroundColor: Color.fromRGBO(187, 222, 251, 1),
                title: "Auto Verbal : ${formattedDate_6}",
                onToggleCollapsed: (p0) async {
                  list7 =
                      await fetchData_by_date(formattedDate_7, formattedDate_6);
                },
                contentPadding: const EdgeInsets.all(0),
                contentChild: Column(
                  children: [
                    if (list7.isNotEmpty)
                      PaginatedDataTable(
                        horizontalMargin: 5.0,
                        arrowHeadColor: Colors.blueAccent[300],
                        columns: const [
                          DataColumn(
                              label: Text(
                            'Verbal ID',
                            style: TextStyle(color: Colors.green),
                          )),
                          DataColumn(
                              label: Text(
                            'Bank',
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
                        source: _DataSource(list7, list7.length, context),
                      )
                    else
                      const Center(child: CircularProgressIndicator())
                  ],
                ),
              ),
              GFAccordion(
                collapsedTitleBackgroundColor:
                    const Color.fromRGBO(238, 238, 238, 1),
                contentBackgroundColor: Colors.blue[100],
                expandedTitleBackgroundColor:
                    const Color.fromRGBO(187, 222, 251, 1),
                title: "Auto Verbal : ${formattedDate_7}",
                onToggleCollapsed: (p0) async {
                  list8 =
                      await fetchData_by_date(formattedDate_8, formattedDate_7);
                },
                contentPadding: const EdgeInsets.all(0),
                contentChild: Column(
                  children: [
                    if (list8.isNotEmpty)
                      PaginatedDataTable(
                        horizontalMargin: 5.0,
                        arrowHeadColor: Colors.blueAccent[300],
                        columns: const [
                          DataColumn(
                              label: Text(
                            'Verbal ID',
                            style: TextStyle(color: Colors.green),
                          )),
                          DataColumn(
                              label: Text(
                            'Bank',
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
                        source: _DataSource(list8, list8.length, context),
                      )
                    else
                      const Center(child: CircularProgressIndicator())
                  ],
                ),
              ),
              GFAccordion(
                collapsedTitleBackgroundColor:
                    const Color.fromRGBO(238, 238, 238, 1),
                contentBackgroundColor: Colors.blue[100],
                expandedTitleBackgroundColor:
                    const Color.fromRGBO(187, 222, 251, 1),
                title: "Auto Verbal : ${formattedDate_8}",
                onToggleCollapsed: (p0) async {
                  list9 =
                      await fetchData_by_date(formattedDate_9, formattedDate_8);
                },
                contentPadding: const EdgeInsets.all(0),
                contentChild: Column(
                  children: [
                    if (list9.isNotEmpty)
                      PaginatedDataTable(
                        horizontalMargin: 5.0,
                        arrowHeadColor: Colors.blueAccent[300],
                        columns: const [
                          DataColumn(
                              label: Text(
                            'Verbal ID',
                            style: TextStyle(color: Colors.green),
                          )),
                          DataColumn(
                              label: Text(
                            'Bank',
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
                        source: _DataSource(list9, list9.length, context),
                      )
                    else
                      const Center(child: CircularProgressIndicator())
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
              return index % 2 == 0 ? Colors.grey[300] : Colors.white;
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
                  item['verbal_id'].toString(),
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  item['property_type_name'].toString(),
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => detail_verbal(
                    set_data_verbal: item['verbal_id'].toString(),
                  ),
                ),
              );
            },
          ),
          DataCell(
            Text(
              item['bank_name'].toString(),
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => detail_verbal(
                    set_data_verbal: item['verbal_id'].toString(),
                  ),
                ),
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

class verbal_Search extends SearchDelegate {
  verbal_Search({required this.name, required this.type});

  List name;
  List type;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return detail_verbal(
      set_data_verbal: query.toString(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List result = name.where((element) {
      return element.contains(query);
    }).toList();
    return ListView.builder(
      itemCount: query == "" ? name.length : result.length,
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () {
            query = query == "" ? name[i] : result[i];
            print(query);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => detail_verbal(
                  set_data_verbal: query,
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(blurRadius: 5, color: Colors.grey),
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: query == ""
                ? Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text("${name[i]}"),
                      trailing: Text("${type[i]}"),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text("${result[i]}"),
                      trailing: Text("${type[i]}"),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
