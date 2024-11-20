import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:web_admin/components/colors.dart';

class AnimatedLineChartExample extends StatelessWidget {
  // Sample data for the chart (multiple datasets)
  final List<ChartData> chartData1 = [
    ChartData(DateTime(2023, 1, 1), 1),
    ChartData(DateTime(2023, 1, 2), 2.5),
    ChartData(DateTime(2023, 1, 3), 2),
    ChartData(DateTime(2023, 1, 4), 3.5),
    ChartData(DateTime(2023, 1, 5), 3),
    ChartData(DateTime(2023, 1, 6), 4),
  ];

  final List<ChartData> chartData2 = [
    ChartData(DateTime(2023, 1, 1), 2),
    ChartData(DateTime(2023, 1, 2), 3),
    ChartData(DateTime(2023, 1, 3), 3.5),
    ChartData(DateTime(2023, 1, 4), 4),
    ChartData(DateTime(2023, 1, 5), 4.5),
    ChartData(DateTime(2023, 1, 6), 5),
  ];

  final List<ChartData> chartData3 = [
    ChartData(DateTime(2023, 1, 1), 0.5),
    ChartData(DateTime(2023, 1, 2), 1.5),
    ChartData(DateTime(2023, 1, 3), 1),
    ChartData(DateTime(2023, 1, 4), 2),
    ChartData(DateTime(2023, 1, 5), 2.5),
    ChartData(DateTime(2023, 1, 6), 3),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat('MM/dd'), // Format the date labels
          intervalType: DateTimeIntervalType.days,
        ),
        primaryYAxis: NumericAxis(
          minimum: 0, // Minimum value for the Y-axis
          maximum: 6, // Maximum value for the Y-axis
          interval: 1, // Interval between Y-axis values
        ),
        series: <ChartSeries>[
          // First data series
          LineSeries<ChartData, DateTime>(
            dataSource: chartData1, // Data for the first series
            xValueMapper: (ChartData data, _) => data.date,
            yValueMapper: (ChartData data, _) => data.value,
            name: 'Dataset 1',
            markerSettings: MarkerSettings(isVisible: true),
            color: Colors.blue, // Customize line color
          ),
          // Second data series
          LineSeries<ChartData, DateTime>(
            dataSource: chartData2, // Data for the second series
            xValueMapper: (ChartData data, _) => data.date,
            yValueMapper: (ChartData data, _) => data.value,
            name: 'Dataset 2',
            markerSettings: MarkerSettings(isVisible: true),
            color: Colors.green, // Customize line color
          ),
          // Third data series
          LineSeries<ChartData, DateTime>(
            dataSource: chartData3, // Data for the third series
            xValueMapper: (ChartData data, _) => data.date,
            yValueMapper: (ChartData data, _) => data.value,
            name: 'Dataset 3',
            markerSettings: MarkerSettings(isVisible: true),
            color: Colors.red, // Customize line color
          ),
        ],
      ),
    );
  }
}

// Data model for chart data
class ChartData {
  final DateTime date;
  final double value;

  ChartData(this.date, this.value);
}
