// ignore_for_file: unused_field

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:http/http.dart' as http;

import 'Edit_Appraiser.dart';

class Appraiser_List extends StatefulWidget {
  const Appraiser_List({super.key});

  @override
  State<Appraiser_List> createState() => _Assign_ListState();
}

class _Assign_ListState extends State<Appraiser_List> {
  @override
  void initState() {
    list();
    super.initState();
  }

  String? search;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(49, 27, 146, 1),
        centerTitle: true,
        title: Text('Appraiser List'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.66,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            search = value;
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
                  elevation: 10,
                  color: Color.fromARGB(255, 6, 6, 167),
                  onPressed: () {
                    setState(() {
                      list_search();
                    });
                  },
                  text: "Search",
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  shape: GFButtonShape.pills,
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 1,
            padding: EdgeInsets.all(5),
            child: PaginatedDataTable(
              horizontalMargin: 5.0,
              arrowHeadColor: Colors.blueAccent[300],
              columns: [
                DataColumn(
                    label: Text(
                  'No',
                  style: TextStyle(color: Colors.green),
                )),
                DataColumn(
                    label: Text(
                  'ID',
                  style: TextStyle(color: Colors.green),
                )),
                DataColumn(
                    label: Text(
                  'Name',
                  style: TextStyle(color: Colors.green),
                )),
                DataColumn(
                    label: Text(
                  'Action',
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
              source: new _DataSource(_list, _list.length, context),
            ),
          ),
        ],
      )),
    );
  }

  List _list = [];
  Future<void> list() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_Appraiser'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        _list = jsonBody;
        setState(() {});
      } else {
        print('Error bank');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  Future<void> list_search() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_Appraiser_search?search=$search'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        _list = jsonBody;
        setState(() {});
      } else {
        print('Error bank');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }
}

int on_row = 20;

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
                  index.toString(),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {},
          ),
          DataCell(
            Text(
              item['person_id'].toString(),
              style: TextStyle(fontSize: 10),
            ),
            onTap: () {},
          ),
          DataCell(
            Text(
              item['Appraiser_name'].toString(),
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {},
          ),
          DataCell(
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Edit_Appraiser(
                            index: index.toString(),
                            list: data,
                          );
                        },
                      ));
                    },
                    icon: Icon(
                      Icons.edit_document,
                      color: Color.fromARGB(255, 21, 130, 24),
                    )),
                IconButton(
                    onPressed: () {
                      AwesomeDialog(
                        context: context,
                        title: 'Confirmation',
                        desc: 'Are you sure you want to delete this item?',
                        btnOkText: 'Yes',
                        btnOkColor: Color.fromARGB(255, 72, 157, 11),
                        btnCancelText: 'No',
                        btnCancelColor: Color.fromARGB(255, 133, 8, 8),
                        btnOkOnPress: () {
                          delete(item['person_id'].toString());
                          // print(item['person_id'].toString());
                        },
                        btnCancelOnPress: () {},
                      ).show();
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 153, 22, 13),
                    )),
              ],
            ),
            onTap: () {},
          ),
        ]);
  }

  Future<void> delete(id) async {
    final response = await http.delete(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/delete_Appraiser/${id.toString()}'));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Appraiser_List();
        },
      ));
    } else {
      throw Exception('Delete error occured!');
    }
  }

  @override
  int get rowCount => count_row;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
