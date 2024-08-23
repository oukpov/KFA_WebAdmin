import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import '../component/List/list.dart';

class CandoCase extends StatefulWidget {
  final List january;
  final List february;
  final List march;
  final List april;
  final List may;
  final List june;
  final List july;
  final List august;
  final List september;
  final List october;
  final List november;
  final List december;
  const CandoCase(
      {super.key,
      required this.january,
      required this.february,
      required this.march,
      required this.april,
      required this.may,
      required this.june,
      required this.july,
      required this.august,
      required this.september,
      required this.october,
      required this.november,
      required this.december});
  @override
  State<CandoCase> createState() => _CandoCaseState();
}

class _CandoCaseState extends State<CandoCase> {
  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            height: 300,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: chartToRun(),
            )),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              border: TableBorder.all(width: 0.3),
              columns: <DataColumn>[
                for (int i = 0; i < monthsList.length; i++)
                  DataColumn(
                    label: Text(
                      monthsList[i]['title'].toString(),
                      style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                        '${widget.january.length + widget.february.length + widget.march.length + widget.april.length + widget.may.length + widget.june.length + widget.july.length + widget.august.length + widget.september.length + widget.october.length + widget.november.length + widget.december.length}')),
                    DataCell(Text(widget.january.length.toString())),
                    DataCell(Text(widget.february.length.toString())),
                    DataCell(Text(widget.march.length.toString())),
                    DataCell(Text(widget.april.length.toString())),
                    DataCell(Text(widget.may.length.toString())),
                    DataCell(Text(widget.june.length.toString())),
                    DataCell(Text(widget.july.length.toString())),
                    DataCell(Text(widget.august.length.toString())),
                    DataCell(Text(widget.september.length.toString())),
                    DataCell(Text(widget.october.length.toString())),
                    DataCell(Text(widget.november.length.toString())),
                    DataCell(Text(widget.december.length.toString())),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget chartToRun() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();

    chartData = ChartData(
      dataRows: [
        [
          double.parse(widget.january.length.toString()),
          double.parse(widget.february.length.toString()),
          double.parse(widget.march.length.toString()),
          double.parse(widget.april.length.toString()),
          double.parse(widget.may.length.toString()),
          double.parse(widget.june.length.toString()),
          double.parse(widget.july.length.toString()),
          double.parse(widget.august.length.toString()),
          double.parse(widget.september.length.toString()),
          double.parse(widget.october.length.toString()),
          double.parse(widget.november.length.toString()),
          double.parse(widget.december.length.toString()),
        ],
      ],
      xUserLabels: [
        'January (${widget.january.length})',
        'February (${widget.february.length})',
        'March (${widget.march.length})',
        'April (${widget.april.length})',
        'May (${widget.may.length})',
        'June (${widget.june.length})',
        'July (${widget.july.length})',
        'August (${widget.august.length})',
        'September (${widget.september.length})',
        'October (${widget.october.length})',
        'November (${widget.november.length})',
        'December (${widget.december.length})',
      ],
      dataRowsLegends: [
        'Case All ${widget.january.length + widget.february.length + widget.march.length + widget.april.length + widget.may.length + widget.june.length + widget.july.length + widget.august.length + widget.september.length + widget.october.length + widget.november.length + widget.december.length}',
      ],
      dataRowsColors: const [
        Color.fromARGB(255, 233, 11, 11),
      ],
      chartOptions: chartOptions,
    );
    var lineChartContainer = LineChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var lineChart = LineChart(
      painter: LineChartPainter(
        lineChartContainer: lineChartContainer,
      ),
    );
    return lineChart;
  }
}
