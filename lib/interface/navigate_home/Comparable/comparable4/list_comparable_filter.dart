// ignore_for_file: override_on_non_overriding_member, unused_element, unnecessary_null_comparison, unused_field

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:http/http.dart' as http;
import '../../../../screen/Property/Map/ToFromDate_ForSale.dart';
import '../comparable3/detail_screen_sav.dart';

class List_comparable_filter extends StatefulWidget {
  const List_comparable_filter({super.key});

  @override
  State<List_comparable_filter> createState() => _List_comparable_filterState();
}

class _List_comparable_filterState extends State<List_comparable_filter> {
  bool _wait_search_0 = false;
  bool _wait_search_ = false;
  @override
  void initState() {
    super.initState();
    get_comparable_filter();
  }

  String? list_data;
  @override
  Future<void> _await() async {
    _wait_search_ = true;
    await Future.wait([
      get_comparable_filter(),
    ]);
    setState(() {
      _wait_search_ = false;
    });
  }

  Future<void> _await_search() async {
    _wait_search_0 = true;
    await Future.wait([
      Comparable_search(),
    ]);
    setState(() {
      _wait_search_0 = false;
    });
  }

  Future<void> _await_search_date() async {
    _wait_search_0 = true;
    await Future.wait([
      Comparable_search_date(),
    ]);
    setState(() {
      _wait_search_0 = false;
    });
  }

  int on_row = 10;
  String? start, end;
  List list = [];
  Future<List> get_comparable_filter() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparable/search_map_list?compare_status=1'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        list = jsonData;
        // print('ok');
      });
    }
    return list;
  }

  Future<List> Comparable_search() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparable/search_map_list_button?search=$_search'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        list = jsonData;
        // print('ok');
      });
    }
    return list;
  }

  Future<List> Comparable_search_date() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparable/search_date?start=$start&end=$end'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        list = jsonData;
        // print('ok');
      });
    }
    return list;
  }

// /comparablecode_comparable/{comparablecode}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        centerTitle: true,
        title: Text('Comparable List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            comparable_list(context),
          ],
        ),
      ),
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
                          _search = value.toString();
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
                color: Color.fromARGB(255, 9, 19, 125),
                size: MediaQuery.of(context).size.height * 0.07,
                elevation: 12,
                onPressed: () {
                  if (start != null && end != null) {
                    _await_search_date();
                  } else {}
                  _await_search();
                },
                text: "Search",
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
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
        _wait_search_0
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                width: MediaQuery.of(context).size.width * 1,
                padding: const EdgeInsets.all(5),
                child: PaginatedDataTable(
                  horizontalMargin: 5.0,
                  arrowHeadColor: Colors.blueAccent[300],
                  columns: const [
                    DataColumn(
                        label: Text(
                      'No',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Code',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Date',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'User',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Location',
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
                  source: new _DataSource(list, list.length, context),
                ),
              )
      ],
    ));
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
                  ? const Color.fromARGB(168, 73, 83, 224)
                  : Colors.white;
            }
            return index % 2 == 0
                ? const Color.fromARGB(255, 255, 162, 162)
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
                  index.toString(),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return List_search_marker(
                      comparable_code: item['comparablecode'].toString());
                },
              ));
            },
          ),
          DataCell(
            Text(
              item['comparablecode'].toString(),
              style: const TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return List_search_marker(
                      comparable_code: item['comparablecode'].toString());
                },
              ));
            },
          ),
          DataCell(
            Text(
              '${(item['comparable_date'] == null) ? '-' : item['comparable_date'].toString()}',
              style: const TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return List_search_marker(
                      comparable_code: item['comparablecode'].toString());
                },
              ));
            },
          ),
          DataCell(
            Text(
              item['comparablUser'].toString(),
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return List_search_marker(
                      comparable_code: item['comparablecode'].toString());
                },
              ));
            },
          ),
          DataCell(
            Text(
              '${(item['provinces_name'] == null) ? '' : item['provinces_name'].toString()} ${(item['district_name'] == null) ? '' : item['district_name'].toString()} ${(item['commune_name'] == null) ? '' : item['commune_name'].toString()}',
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return List_search_marker(
                      comparable_code: item['comparablecode'].toString());
                },
              ));
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
