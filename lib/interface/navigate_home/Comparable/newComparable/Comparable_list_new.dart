// ignore_for_file: unused_import, unnecessary_import, implementation_imports, non_constant_identifier_names, unused_field, must_call_super, prefer_const_constructors, unnecessary_string_interpolations, unused_element, unused_local_variable, dead_code, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import '../../../../screen/Property/Map/ToFromDate_ForSale.dart';
import '../comparable_1/Edit_Comparable.dart';

// comparable_search Api search
class ComparableListnews extends StatefulWidget {
  ComparableListnews({super.key, required this.name});
  String? name;

  @override
  State<ComparableListnews> createState() => _ComparableListnewsState();
}

class _ComparableListnewsState extends State<ComparableListnews> {
  // A function that converts a response body into a List<Photo>.
  List list = [];
  int on_row = 20;
  String? id_ds;
  Future<void> _comparable_search_() async {
    _wait_search_ = true;
    await Future.wait([
      Comparable_search(),
    ]);
    setState(() {
      _wait_search_ = false;
    });
  }

  Future<void> Comparable_search() async {
    setState(() {});
    try {
      final response = await http.get(Uri.parse(
          //  'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparable_search?start=2023-03-01&end=2024-03-01'));
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparable_search?search=$_search'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        list = jsonBody;

        setState(() {
          list;
        });
      } else {
        print('Error Comparable Search');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  bool _wait_search_ = false;
  bool _wait_search = false;
  Future<void> _comparable_search() async {
    _wait_search = true;
    await Future.wait([
      ComparableList_search_data(),
    ]);
    setState(() {
      _wait_search = false;
    });
  }

  Future<void> ComparableList_search_data() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparable_search_date?start=$start&end=$end'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        list = jsonBody;
        setState(() {
          list;
        });
      } else {
        print('Error Comparable Date');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  @override
  void initState() {
    // ComparableList();
  }

  String? start;
  String? end;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.deepPurple[900],
      //   title: Text('List Comparable'),
      //   centerTitle: true,
      // ),
      body: _wait_search
          ? Center(
              child: CircularProgressIndicator(),
            )
          : comparable_list(context),
    );
  }

  String? _search;
  Widget comparable_list(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
          child: Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.65,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _search = value;
                          // _comparable_search_();
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        hintText: 'Search listing here...',
                      )),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GFButton(
                color: Color.fromARGB(255, 186, 186, 192),
                size: MediaQuery.of(context).size.height * 0.07,
                elevation: 12,
                onPressed: () {
                  setState(() {
                    if (start != null && end != null) {
                      ComparableList_search_data();
                    } else {
                      _comparable_search_();
                    }
                  });
                },
                text: "Search",
                textStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ToFromDate_p(
          fromDate: (value) {
            setState(() {
              start = value.toString();
              start;
            });
          },
          toDate: (value) {
            setState(() {
              end = value.toString();
              end;
            });
          },
        ),
        _wait_search_
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                width: MediaQuery.of(context).size.width * 1,
                padding: EdgeInsets.all(5),
                child: PaginatedDataTable(
                  columnSpacing: 50.0,
                  horizontalMargin: 5.0,
                  // arrowHeadColor: Colors.blueAccent[300],
                  columns: const [
                    DataColumn(
                        label: Text(
                      'No',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Action',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Proerty Type',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Land Size',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Building Size',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Asking',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Offered',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Bought',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Sold Out',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Location',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Agency',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Code',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Survey Date',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                  ],
                  dataRowHeight: 50,
                  rowsPerPage: on_row,
                  onRowsPerPageChanged: (value) {
                    setState(() {
                      on_row = value!;
                    });
                  },
                  source: _DataSource(list, list.length, context, widget.name),
                ),
              )
      ],
    ));
  }
}

void DeTail_screen(BuildContext context, list, int index) async {
  Navigator.push(context, MaterialPageRoute(
    builder: (context) {
      return Detail_Screen(
        index: index.toString(),
        list: list,
      );
    },
  ));
}

class _DataSource extends DataTableSource {
  final List data;
  final String? name;
  final int count_row;
  final BuildContext context;
  _DataSource(this.data, this.count_row, this.context, this.name);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];

    return DataRow(
        selected: true,
        // color: MaterialStateProperty.resolveWith<Color?>(
        //   (Set<MaterialState> states) {
        //     if (states.contains(MaterialState.selected)) {
        //       return index % 2 == 0
        //           ? Color.fromARGB(168, 73, 83, 224)
        //           : Colors.white;
        //     }
        //     return index % 2 == 0
        //         ? Color.fromARGB(255, 255, 162, 162)
        //         : Colors.white;
        //   },
        // ),
        cells: [
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  index.toString(),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 20,
                  width: 50,
                  child: GFButton(
                    color: Colors.green,
                    onPressed: () {
                      DeTail_screen(context, data, index);
                    },
                    text: "Edit",
                    shape: GFButtonShape.pills,
                    fullWidthButton: true,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                SizedBox(
                  height: 20,
                  width: 60,
                  child: GFButton(
                    color: Colors.red,
                    onPressed: () {
                      DeTail_screen(context, data, index);
                    },
                    text: "Delete",
                    shape: GFButtonShape.pills,
                    fullWidthButton: true,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                SizedBox(
                  height: 20,
                  width: 60,
                  child: GFButton(
                    onPressed: () {
                      DeTail_screen(context, data, index);
                    },
                    text: "Update",
                    shape: GFButtonShape.pills,
                    fullWidthButton: true,
                  ),
                )
              ],
            ),
            // Text(
            //   //item['comparable_property_id'].toString(),
            //   //style: TextStyle(fontSize: 10),
            //   //overflow: TextOverflow.ellipsis,
            // ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  index.toString(),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            Text(
              item['comparable_land_total'].toString(),
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {},
          ),
          DataCell(
            Text(
              item['comparable_sold_total'].toString(),
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            Text(
              item['comparable_adding_price'].toString(),
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
              Text(
                item['comparable_sold_total_price'].toString(),
                style: TextStyle(fontSize: 10),
                overflow: TextOverflow.ellipsis,
              ), onTap: () {
            DeTail_screen(context, data, index);
          }),
          DataCell(
            Text(
              item['bank_name'].toString(),
              style: TextStyle(fontSize: 10),
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            Text(
              item['comparableaddprice'].toString(),
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            Text(
              item['comparable_address'].toString(),
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            Text(
              // '${name}',
              'N/A',
              // '${name}',
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            Text(
              item['comparable_id'].toString(),
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
              Text(
                item['comparable_survey_date'].toString(),
                style: TextStyle(fontSize: 10),
                overflow: TextOverflow.ellipsis,
              ), onTap: () {
            DeTail_screen(context, data, index);
          }),
        ]);
  }

  @override
  int get rowCount => count_row;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
//