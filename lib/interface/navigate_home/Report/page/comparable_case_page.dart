import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'inputdateshow.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';
import 'dart:html' as html;

class ComparableCasePage extends StatefulWidget {
  const ComparableCasePage({super.key});

  @override
  State<ComparableCasePage> createState() => _ComparableCasePageState();
}

class _ComparableCasePageState extends State<ComparableCasePage> {
  List<Map<String, dynamic>> _reportData = [];
  List<Map<String, dynamic>> _agencyData = [];
  bool _isLoading = true;
  String _selectedAgencyName = '';
  final ValueNotifier<String?> _startDateNotifier = ValueNotifier(null);
  final ValueNotifier<String?> _endDateNotifier = ValueNotifier(null);
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredReportData = [];
  int _rowsPerPage = 25;

  @override
  void initState() {
    super.initState();
    _startDateNotifier.value =
        DateFormat('yyyy-MM-dd').format(DateTime(2023, 1, 1));
    _endDateNotifier.value =
        DateFormat('yyyy-MM-dd').format(DateTime(2023, 2, 1));
    fetchAgencyAndReportData();
  }

  Future<void> fetchAgencyAndReportData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var dio = Dio();
      var agencyResponse = await dio.get(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_agency');

      if (agencyResponse.statusCode == 200) {
        setState(() {
          _agencyData = List<Map<String, dynamic>>.from(agencyResponse.data);
          _agencyData.sort((a, b) =>
              (a['agenttype_name'] ?? '').compareTo(b['agenttype_name'] ?? ''));
          if (_agencyData.isNotEmpty) {
            _selectedAgencyName = _agencyData[0]['agenttype_name'] ?? '';
          }
        });

        final reportResponse = await dio.get(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/reportcomparable',
          queryParameters: {
            'start': _startDateNotifier.value,
            'end': _endDateNotifier.value,
          },
        );

        if (reportResponse.statusCode == 200) {
          final List<Map<String, dynamic>> allReportData =
              List<Map<String, dynamic>>.from(reportResponse.data);

          setState(() {
            _reportData = _agencyData
                .map((agency) {
                  final agencyName = agency['agenttype_name'] ?? '';
                  final agencyReports = allReportData
                      .where((report) => report['agenttype_name'] == agencyName)
                      .toList();
                  return {
                    'id': agency['id'],
                    'agenttype_name': agencyName,
                    'total': agencyReports.length,
                    'reports': agencyReports,
                  };
                })
                .where((report) => report['total'] > 0)
                .toList();

            // Sort _reportData by total in descending order
            _reportData.sort((a, b) => b['total'].compareTo(a['total']));
            _filteredReportData = List.from(_reportData);
          });
        } else {
          print('Failed to load report data: ${reportResponse.statusMessage}');
        }
      } else {
        print('Failed to load agencies: ${agencyResponse.statusMessage}');
      }
    } catch (e) {
      print('Error loading data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterReportData(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredReportData = List.from(_reportData);
      } else {
        _filteredReportData = _reportData
            .where((report) => report['agenttype_name']
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 8),
                SizedBox(
                  child: Row(
                    children: [
                      InputDatetshow(
                        fieldName: 'Start Date',
                        flex: 1,
                        dateNotifier: _startDateNotifier,
                      ),
                      const SizedBox(width: 8),
                      InputDatetshow(
                        fieldName: 'End Date',
                        flex: 1,
                        dateNotifier: _endDateNotifier,
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        child: const Text('Search'),
                        onPressed: () {
                          if (_startDateNotifier.value == null) {
                            _startDateNotifier.value =
                                DateFormat('yyyy-MM-dd').format(DateTime.now());
                          }
                          if (_endDateNotifier.value == null) {
                            _endDateNotifier.value =
                                DateFormat('yyyy-MM-dd').format(DateTime.now());
                          }
                          fetchAgencyAndReportData();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            DropdownButton<int>(
                              value: _rowsPerPage,
                              items: [25, 50, 75, 100, _reportData.length]
                                  .map((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(value == _reportData.length
                                      ? 'Show All'
                                      : 'Show $value Rows'),
                                );
                              }).toList(),
                              onChanged: (int? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _rowsPerPage = newValue;
                                  });
                                }
                              },
                            ),
                            // const SizedBox(width: 8),
                            // textcontainer('Copy', () {}),
                            const SizedBox(width: 8),
                            textcontainer('Excel', () {
                              _saveAsExcel();
                            }),
                            const SizedBox(width: 8),
                            textcontainer('Print', () {
                              _printAsPdf();
                            }),
                            // const SizedBox(width: 8),
                            // textcontainer('Column Visibility', () {}),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            const Text('Search'),
                            const SizedBox(width: 8),
                            SizedBox(
                              height: 35,
                              width: 200,
                              child: TextField(
                                controller: _searchController,
                                decoration: const InputDecoration(
                                  hintText: 'Search',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 0),
                                ),
                                onChanged: _filterReportData,
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : paginatedtable(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget paginatedtable() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: constraints.maxWidth,
            child: PaginatedDataTable(
              columns: const [
                DataColumn(
                  label: Expanded(
                    flex: 1,
                    child: Text(
                      'ID',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    flex: 2,
                    child: Text(
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    flex: 2,
                    child: Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
              source: _ReportDataSource(_filteredReportData),
              columnSpacing: 30,
              horizontalMargin: 10,
              rowsPerPage: _rowsPerPage,
            ),
          ),
        );
      },
    );
  }

  Container textcontainer(String text, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: onTap,
        child: Text(text),
      ),
    );
  }

  Future<void> _printAsPdf() async {
    final pdf = pw.Document();

    final int itemsPerPage = 35;
    final int pageCount = (_reportData.length / itemsPerPage).ceil();

    for (int pageNum = 0; pageNum < pageCount; pageNum++) {
      final startIndex = pageNum * itemsPerPage;
      final endIndex = (startIndex + itemsPerPage < _reportData.length)
          ? startIndex + itemsPerPage
          : _reportData.length;

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Start Date: ${_startDateNotifier.value}'),
                  pw.Text('End Date: ${_endDateNotifier.value}'),
                  pw.SizedBox(height: 20),
                  pw.Container(
                      child: pw.Column(
                    children: [
                      pw.Container(
                        alignment: pw.Alignment.center,
                        child: pw.Text('Comparable Case',
                            style: pw.TextStyle(
                                fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Container(
                        width: double.infinity,
                        child: pw.Table(
                          border: pw.TableBorder.all(),
                          children: [
                            pw.TableRow(
                              children: [
                                pw.Container(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text('ID'),
                                ),
                                pw.Container(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text('Name'),
                                ),
                                pw.Container(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text('Total'),
                                ),
                              ],
                            ),
                            ..._reportData
                                .sublist(startIndex, endIndex)
                                .asMap()
                                .entries
                                .map((entry) {
                              final index = startIndex + entry.key;
                              final report = entry.value;
                              return pw.TableRow(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text('${index + 1}'),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(report['agenttype_name']),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(report['total'].toString()),
                                  ),
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ],
                  )),
                  pw.Positioned(
                    bottom: 20,
                    right: 20,
                    child: pw.Text('Page ${pageNum + 1} of $pageCount'),
                  ),
                ]);
          },
        ),
      );
    }

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  Future<void> _saveAsExcel() async {
    try {
      final excel = Excel.createExcel();
      final sheet = excel['Sheet1'];

      // Add headers
      sheet.appendRow(['ID', 'Name', 'Total']);

      // Add data
      for (var i = 0; i < _reportData.length; i++) {
        final report = _reportData[i];
        sheet.appendRow([
          '${i + 1}',
          report['agenttype_name'],
          report['total'].toString(),
        ]);
      }

      // Encode the Excel file
      final List<int>? excelBytes = excel.encode();
      if (excelBytes == null) {
        throw Exception('Failed to generate Excel file');
      }

      // Convert to Uint8List
      final Uint8List excelData = Uint8List.fromList(excelBytes);

      // Create a blob and anchor element for downloading the file
      final blob = html.Blob([excelData],
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'comparable_case_report.xlsx')
        ..click();

      // Cleanup
      html.Url.revokeObjectUrl(url);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Excel file saved and downloaded')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving Excel file: ${e.toString()}')),
      );
    }
  }
}

class _ReportDataSource extends DataTableSource {
  final List<Map<String, dynamic>> _reportData;

  _ReportDataSource(this._reportData);

  @override
  DataRow? getRow(int index) {
    if (index >= _reportData.length) {
      return null;
    }
    final report = _reportData[index];

    return DataRow(
      cells: [
        DataCell(Text('${index + 1}')),
        DataCell(report['agenttype_name'] != null &&
                report['agenttype_name'].isNotEmpty
            ? Text(report['agenttype_name'])
            : const Text('-')),
        DataCell(
          report['total'] == 0
              ? const Text('-')
              : Text(report['total'].toString()),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _reportData.length;

  @override
  int get selectedRowCount => 0;
}
