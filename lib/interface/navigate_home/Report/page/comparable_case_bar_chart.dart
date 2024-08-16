import 'dart:math';

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
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:fl_chart/fl_chart.dart';

class ComparableCaseBarChartPage extends StatefulWidget {
  const ComparableCaseBarChartPage({Key? key}) : super(key: key);

  @override
  State<ComparableCaseBarChartPage> createState() =>
      _ComparableCaseBarChartPageState();
}

class _ComparableCaseBarChartPageState
    extends State<ComparableCaseBarChartPage> {
  List<Map<String, dynamic>> _reportData = [];
  List<Map<String, dynamic>> _agencyData = [];
  bool _isLoading = true;
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
      appBar: AppBar(
        title: const Text('Comparable Case Bar Chart'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildDateInputs(),
              const SizedBox(height: 16),
              _buildTableControls(),
              const SizedBox(height: 16),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildDataTableAndBarChart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateInputs() {
    return SizedBox(
      child: Row(
        children: [
          InputDatetshow(
            fieldName: 'Start Date',
            dateNotifier: _startDateNotifier,
            flex: 1,
          ),
          const SizedBox(width: 16),
          InputDatetshow(
            fieldName: 'End Date',
            dateNotifier: _endDateNotifier,
            flex: 1,
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            child: const Text('Search'),
            onPressed: fetchAgencyAndReportData,
          ),
        ],
      ),
    );
  }

  Widget _buildTableControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // DropdownButton<int>(
            //   value: _rowsPerPage,
            //   items: [25, 50, 75, 100, _reportData.length].map((int value) {
            //     return DropdownMenuItem<int>(
            //       value: value,
            //       child: Text(value == _reportData.length
            //           ? 'Show All'
            //           : 'Show $value Rows'),
            //     );
            //   }).toList(),
            //   onChanged: (int? newValue) {
            //     if (newValue != null) {
            //       setState(() {
            //         _rowsPerPage = newValue;
            //       });
            //     }
            //   },
            // ),
            const SizedBox(width: 16),
            const SizedBox(width: 16),
            ElevatedButton(
              child: const Text('Print'),
              onPressed: _printAsPdf,
            ),
          ],
        ),
        SizedBox(
          width: 200,
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            ),
            onChanged: _filterReportData,
          ),
        ),
      ],
    );
  }

  Widget _buildDataTableAndBarChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Table(
              border: TableBorder.all(),
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(50),
                1: FlexColumnWidth(),
                2: FixedColumnWidth(100),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  children: const [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'No',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Agence',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Total',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                ..._filteredReportData.asMap().entries.map((entry) {
                  final index = entry.key;
                  final report = entry.value;
                  return TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('${index + 1}'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(report['agenttype_name'] ?? '-'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(report['total'].toString()),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 80),
        Container(
          height: MediaQuery.of(context).size.height * 0.6, // Fixed height
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: max(_reportData.length * 50.0, constraints.maxWidth),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: _reportData.isNotEmpty
                          ? _reportData
                              .map((e) => e['total'] as int)
                              .reduce((a, b) => a > b ? a : b)
                              .toDouble()
                          : 100,
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.blueGrey,
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            return BarTooltipItem(
                              '${_reportData[groupIndex]['agenttype_name']}\n',
                              const TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${rod.toY.toStringAsFixed(0)} cases',
                                  style: const TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value.toInt() >= 0 &&
                                  value.toInt() < _reportData.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Transform.rotate(
                                    angle: _reportData.length > 15
                                        ? -45 * 3.1415927 / 180
                                        : 0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        _reportData[value.toInt()]
                                            ['agenttype_name'],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return const Text('');
                            },
                            reservedSize: _reportData.length > 15
                                ? 60
                                : 30, // Increased to accommodate rotated text when needed
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      barGroups: _reportData.asMap().entries.map((entry) {
                        final index = entry.key;
                        final data = entry.value;
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: data['total'].toDouble(),
                              color: Colors.blue,
                              width: 16,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(4),
                              ),
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                toY: _reportData
                                    .map((e) => e['total'] as int)
                                    .reduce((a, b) => a > b ? a : b)
                                    .toDouble(),
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                          showingTooltipIndicators: [0],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _printAsPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Comparable Case Report',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 16),
              pw.Container(
                decoration: pw.BoxDecoration(
                  color: PdfColors.white,
                  borderRadius: pw.BorderRadius.circular(8),
                  boxShadow: const [
                    pw.BoxShadow(
                      color: PdfColors.grey300,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: PdfPoint(0, 3),
                    ),
                  ],
                ),
                child: pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.grey300),
                  children: [
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.grey300),
                      children: [
                        pw.Text('No',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text('Agence',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text('Total',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                    ..._reportData.asMap().entries.map((entry) {
                      final index = entry.key;
                      final report = entry.value;
                      return pw.TableRow(
                        children: [
                          pw.Text('${index + 1}'),
                          pw.Text(report['agenttype_name']),
                          pw.Text(report['total'].toString()),
                        ],
                      );
                    }).toList(),
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.grey300),
                      children: [
                        pw.Text(''),
                        pw.Text('Total',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text(
                            _reportData
                                .map((e) => e['total'] as int)
                                .reduce((a, b) => a + b)
                                .toString(),
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 16),
              pw.Container(
                height: 300,
                decoration: pw.BoxDecoration(
                  color: PdfColors.white,
                  borderRadius: pw.BorderRadius.circular(8),
                  boxShadow: const [
                    pw.BoxShadow(
                      color: PdfColors.grey300,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: PdfPoint(0, 3),
                    ),
                  ],
                ),
                child: pw.Chart(
                  title: pw.Text(
                    'Comparable Case Report',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  grid: pw.CartesianGrid(
                    xAxis: pw.FixedAxis.fromStrings(
                      List.generate(
                          _reportData.length,
                          (index) =>
                              _reportData[index]['agenttype_name'] +
                              ' (${_reportData[index]['total'].toString()})'),
                      marginStart: 30,
                      marginEnd: 30,
                      angle: _reportData.length > 15 ? 45 : 0,
                    ),
                    yAxis: pw.FixedAxis(
                      [
                        0,
                        _reportData.isNotEmpty
                            ? _reportData
                                .map((e) => e['total'] as int)
                                .reduce((a, b) => a > b ? a : b)
                            : 100
                      ],
                      format: (v) => v.toInt().toString(),
                    ),
                  ),
                  datasets: [
                    pw.BarDataSet(
                      color: PdfColors.blue,
                      data: List.generate(
                        _reportData.length,
                        (index) => pw.PointChartValue(
                          index.toDouble(),
                          _reportData[index]['total'].toDouble(),
                        ),
                      ),
                      legend: 'Total Cases',
                      valuePosition: pw.ValuePosition.top,
                      borderColor: PdfColors.black,
                      borderWidth: 1,
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                'Total Cases: ${_reportData.map((e) => e['total'] as int).reduce((a, b) => a + b)}',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          );
        },
      ),
    );
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
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
        DataCell(Text(report['agenttype_name'] ?? '-')),
        DataCell(Text(report['total'].toString())),
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
