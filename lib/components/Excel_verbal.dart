import 'dart:html' as html;
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

class ClassExcelVerbal extends StatefulWidget {
  final String username;
  final List list;
  const ClassExcelVerbal(
      {super.key, required this.username, required this.list});
  @override
  State<ClassExcelVerbal> createState() => _ClassExcelState();
}

class _ClassExcelState extends State<ClassExcelVerbal> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          createAndDownloadExcel(widget.username, widget.list);
        });
      },
      child: Image.asset(
        'assets/images/excel_logo.png',
        height: 35,
        width: 35,
      ),
    );
  }

  Future<void> createAndDownloadExcel(String name, List list) async {
    // Create a new Excel document
    var excel = Excel.createExcel();

    // Select the default sheet or create a new one
    Sheet sheetObject = excel[widget.username];

    // Define bold style
    CellStyle boldStyle = CellStyle(
      bold: true,
    );

    // Add headers with bold style
    for (int i = 0; i < listTitle.length; i++) {
      var cell = sheetObject
          .cell(CellIndex.indexByString(listTitle[i]['type'].toString()));
      cell.value = listTitle[i]['title'].toString();
      cell.cellStyle = boldStyle;
    }

    // Add data to the sheet in a loop
    for (int i = 0; i < list.length; i++) {
      sheetObject.cell(CellIndex.indexByString("A${i + 2}")).value = i + 1;
      sheetObject.cell(CellIndex.indexByString("B${i + 2}")).value =
          "${list[i]['verbal_id'] ?? "N/A"}";
      sheetObject.cell(CellIndex.indexByString("C${i + 2}")).value =
          "${list[i]['username'] ?? "N/A"}";
      sheetObject.cell(CellIndex.indexByString("D${i + 2}")).value =
          "${list[i]['tel_num'] ?? "N/A"}";
      sheetObject.cell(CellIndex.indexByString("E${i + 2}")).value =
          "${list[i]['bank_name'] ?? "N/A"}";
      sheetObject.cell(CellIndex.indexByString("F${i + 2}")).value =
          "${list[i]['verbal_address'] ?? "N/A"}";
      sheetObject.cell(CellIndex.indexByString("G${i + 2}")).value =
          "${list[i]['latlong_la'] ?? "N/A"}";
      sheetObject.cell(CellIndex.indexByString("G${i + 2}")).value =
          "${list[i]['latlong_log'] ?? "N/A"}";
      sheetObject.cell(CellIndex.indexByString("I${i + 2}")).value =
          "${list[i]['verbal_date'] ?? "N/A"}";
    }

    // Save the file to a Uint8List
    var fileBytes = excel.save(fileName: '$name.xlsx');

    // Convert Uint8List to Blob
    final blob = html.Blob([fileBytes],
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');

    // Create a download link and click it
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.Url.revokeObjectUrl(url);
  }

  List<Map<String, String>> listTitle = [
    {"title": "No", "type": "A1"},
    {"title": "Code", "type": "B1"},
    {"title": "UserName", "type": "C1"},
    {"title": "Tel Number", "type": "D1"},
    {"title": "Bank Name", "type": "E1"},
    {"title": "Address", "type": "F1"},
    {"title": "Lat", "type": "G1"},
    {"title": "Log", "type": "H1"},
    {"title": "Verbal Date", "type": "I1"},
  ];
}
