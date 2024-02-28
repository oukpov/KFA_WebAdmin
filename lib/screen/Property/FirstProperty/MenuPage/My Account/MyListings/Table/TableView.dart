import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../../component/Colors/colors.dart';


class MyDataTable extends StatefulWidget {
  // List listBool = [];
  MyDataTable({Key? key, required this.list, required this.listPage})
      : super(key: key);
  List list = [];
  int listPage;
  @override
  State<MyDataTable> createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  bool isSelected = false;
  List<Map<String, String>> listTitle = [
    {"title": "No"},
    {"title": "Action"},
    {"title": "Click"},
    {"title": "Picture"},
    {"title": "Title"},
    {"title": "Property Type"},
    {"title": "Price"},
    {"title": "Price Per Sqm"},
    {"title": "Listing Date"},
    {"title": "Bed"},
    {"title": "Bath"},
    {"title": "L-Size"},
    {"title": "B-Size"},
  ];
  // List list = [];
  // Future<void> value() async {
  //   var headers = {'Content-Type': 'application/json'};
  //   var data =
  //       json.encode({"email": "oukpov@gmail.com", "password": "Pov8888"});
  //   var dio = Dio();
  //   var response = await dio.request(
  //     'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_all_Sale_all_2',
  //     options: Options(
  //       method: 'GET',
  //       headers: headers,
  //     ),
  //     data: data,
  //   );

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       list = jsonDecode(json.encode(response.data));
  //     });
  //   } else {
  //     print(response.statusMessage);
  //   }
  // }

  @override
  void initState() {
    // value();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Text('$isSelected');

    return DataTable(
      dataRowHeight: 120,
      dividerThickness: 1,
      border: TableBorder.all(width: 1, color: whiteNotFullColor),
      columns: [
        for (int i = 0; i < listTitle.length; i++)
          DataColumn(
            label: Text(
              '${listTitle[i]['title']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
      ],
      rows: [
        for (int i = 0; i < widget.list.length; i++)
          DataRow(
            cells: [
              DataCell(Text('0000$i')),
              DataCell(IconButton(
                  onPressed: () {
                    print('hello');
                  },
                  icon: const Icon(Icons.more_vert_outlined))),
              DataCell(Text('Click')),
              DataCell(Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.list[i]['url'].toString()),
                          fit: BoxFit.cover)),
                  width: 170,
                ),
              )),
              DataCell(Text(widget.list[i]['title'] ?? "")),
              DataCell(Text(widget.list[i]['hometype'] ?? "")),
              DataCell(Text("${widget.list[i]['price'] ?? ""}")),
              DataCell(Text("${widget.list[i]['price_sqm'] ?? ""}")),
              DataCell(Text(widget.list[i]['date'] ?? "")),
              DataCell(Text("${widget.list[i]['bed'] ?? ""}")),
              DataCell(Text("${widget.list[i]['bath'] ?? ""}")),
              DataCell(Text("${widget.list[i]['Size_l'] ?? ""}")),
              DataCell(Text("${widget.list[i]['size_house'] ?? ""}")),
            ],
          ),
      ],
    );
  }
}
