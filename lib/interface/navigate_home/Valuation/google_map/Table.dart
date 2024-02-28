import 'package:flutter/material.dart';

import '../Print/print.dart';

class MyDataTable extends StatefulWidget {
  List list = [];
  List listBool = [];
  MyDataTable({Key? key, required this.list, required this.listBool})
      : super(key: key);

  @override
  State<MyDataTable> createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  bool isSelected = false;
  List<Map<String, String>> listTitle = [
    {"title": "No"},
    {"title": "Action"},
    {"title": "Print"},
    {"title": "Property Type"},
    {"title": "Land Size"},
    {"title": "Building Size"},
    {"title": "Asking"},
    {"title": "Offered"},
    {"title": "Bought"},
    {"title": "Sold Out"},
    {"title": "Location"},
    {"title": "Survey Date"},
  ];

  @override
  Widget build(BuildContext context) {
    // return Text('$isSelected');
    return DataTable(
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
        if (widget.list.length > 0)
          for (int x = 0; x < widget.listBool.length; x++)
            DataRow(
              cells: [
                DataCell(Text(
                  '$x',
                )),
                DataCell(
                  Switch(
                    value: widget.listBool[x]['select'],
                    onChanged: (value) {
                      setState(() {
                        // print('No $x : ${widget.listBool[x]['select']}');
                        widget.listBool[x]['select'] = value;

                        if (value == true) {
                          // selectedMain(x);
                          // print('True');
                        } else {
                          // print('Else');
                          if (widget.listBool[x]["comparable_id"] ==
                              widget.list[x]['comparable_id']) {
                            widget.listBool[x]["select"] = value;
                            // print(widget.listBool[x]["comparable_id"]);
                          }
                        }
                      });
                    },
                  ),
                ),
                DataCell(
                  PrinterPDF(index: x.toString(), list: widget.list),
                ),
                DataCell(InkWell(
                  onTap: () {
                    print('List => ${widget.listBool}');
                    for (int d = 0; d < widget.listBool.length; d++) {
                      if (widget.listBool[d]['select'] == false) {
                        widget.listBool.removeWhere((item) =>
                            item['comparable_id'] ==
                            widget.list[d]['comparable_id']);
                        print(widget.listBool);
                      }
                    }
                  },
                  child: Text(
                    '${(widget.list[x]['property_type_name'].toString() == 'null' ? '' : widget.list[x]['property_type_name'])}',
                  ),
                )),
                DataCell(Text(
                  '${(widget.list[x]['comparable_land_total'].toString() == 'null' ? '' : widget.list[x]['comparable_land_total'])}',
                )),
                DataCell(Text(
                  '${(widget.list[x]['comparable_sold_total'].toString() == 'null' ? '' : widget.list[x]['comparable_sold_total'])}',
                )),
                DataCell(Text(
                  '${(widget.list[x]['comparable_adding_price'].toString() == 'null' ? '' : widget.list[x]['comparable_adding_price'])}',
                )),
                DataCell(Text(
                  '${(widget.list[x]['comparableaddprice'].toString() == 'null' ? '' : widget.list[x]['comparableaddprice'])}',
                )),
                DataCell(Text(
                  '${(widget.list[x]['comparableboughtprice'].toString() == 'null' ? '' : widget.list[x]['comparableboughtprice'])}',
                )),
                DataCell(Text(
                  '${(widget.list[x]['comparable_sold_price'].toString() == 'null' ? '' : widget.list[x]['comparable_sold_price'])}',
                )),
                DataCell(Text(
                  '${(widget.list[x]['provinces_name'].toString() == 'null' ? '' : widget.list[x]['provinces_name'].toString())}, ${(widget.list[x]['district_name'].toString() == 'null' ? '' : widget.list[x]['district_name'].toString())}, ${(widget.list[x]['commune_name'].toString() == 'null' ? '' : widget.list[x]['commune_name'].toString())}',
                )),
                DataCell(Text(
                  '${(widget.list[x]['comparable_survey_date'].toString() == 'null' ? '' : widget.list[x]['comparable_survey_date'])}',
                )),
              ],
            )
      ],
    );
  }
}
