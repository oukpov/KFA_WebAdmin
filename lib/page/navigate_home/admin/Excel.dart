import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:universal_html/html.dart' as html;

class ExcelExporterPage extends StatelessWidget {
  const ExcelExporterPage({super.key, required this.list, required this.name});
  final List list; // Ensure list has key-value pairs
  final String name;

  void exportToExcel() {
    List<Map<String, dynamic>> convertLists = convertList(list);
    var excel = Excel.createExcel();
    var sheet = excel[name];

    // Add Headers
    if (convertLists.isNotEmpty) {
      sheet.appendRow(convertLists.first.keys.toList());
    }

    // Add Data Rows with "absent": null replaced with ""
    for (var data in convertLists) {
      sheet.appendRow(
        data.map((key, value) => MapEntry(key, value ?? "")).values.toList(),
      );
    }

    // Encode Excel File
    List<int>? excelBytes = excel.encode();
    if (excelBytes == null) return;

    // Convert to Blob and Create Download Link
    final blob = html.Blob([Uint8List.fromList(excelBytes)],
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "$name.xlsx")
      ..click();

    // Clean Up
    html.Url.revokeObjectUrl(url);
  }

  List<Map<String, dynamic>> convertList(List<dynamic> dataList) {
    return dataList.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        exportToExcel();
      },
      child: Image.asset(
        'assets/images/excel_logo.png',
        width: 35,
      ),
    );
  }
}
