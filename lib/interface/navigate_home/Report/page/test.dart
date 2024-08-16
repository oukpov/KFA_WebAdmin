import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40),
    _SalesData('Jun', 35),
    _SalesData('Jul', 28),
    _SalesData('Aug', 34),
    _SalesData('Sep', 32),
    _SalesData('Oct', 40)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter chart'),
      ),
      body: Column(
        children: [
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(),
            title: ChartTitle(text: 'Half yearly sales analysis'),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries>[
              ColumnSeries<_SalesData, String>(
                dataSource: data,
                xValueMapper: (_SalesData sales, _) => sales.year,
                yValueMapper: (_SalesData sales, _) => sales.sales,
                name: 'Sales',
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
            zoomPanBehavior: ZoomPanBehavior(
              enablePinching: true,
              enableDoubleTapZooming: true,
              enablePanning: true,
            ),
            crosshairBehavior: CrosshairBehavior(enable: true),
          ),
          ElevatedButton(
            onPressed: _printAsPdf,
            child: Text('Print as PDF'),
          ),
        ],
      ),
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
              pw.Text('Half yearly sales analysis',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 16),
              pw.Container(
                height: 300,
                child: pw.Chart(
                  title: pw.Text(
                    'Sales Data',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  grid: pw.CartesianGrid(
                    xAxis: pw.FixedAxis.fromStrings(
                      List.generate(data.length, (index) => data[index].year),
                      marginStart: 30,
                      marginEnd: 30,
                    ),
                    yAxis: pw.FixedAxis(
                      [
                        0,
                        data.map((e) => e.sales).reduce((a, b) => a > b ? a : b)
                      ],
                      format: (v) => v.toInt().toString(),
                    ),
                  ),
                  datasets: [
                    pw.BarDataSet(
                      color: PdfColors.blue,
                      data: List.generate(
                        data.length,
                        (index) => pw.PointChartValue(
                          index.toDouble(),
                          data[index].sales,
                        ),
                      ),
                      legend: 'Sales',
                      valuePosition: pw.ValuePosition.top,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
