import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Adjust the import according to your file structure

class TableModel extends ChangeNotifier {
  List<DataRow> _rows = [];

  TableModel() {
    _addInitialRow();
  }

  List<DataRow> get rows => _rows;

  void _addInitialRow() {
    _rows.add(
      DataRow(
        cells: [
          DataCell(Text('Column 1')),
          DataCell(Text('Column 2')),
          DataCell(Text('Column 3')),
        ],
      ),
    );
    notifyListeners();
  }

  void addRow() {
    _rows.add(
      DataRow(
        cells: [
          DataCell(Text('Row ${_rows.length - 1} Col 1')),
          DataCell(Text('Row ${_rows.length - 1} Col 2')),
          DataCell(Text('Row ${_rows.length - 1} Col 3')),
        ],
      ),
    );
    notifyListeners();
  }
}

class ListenableBuilderExample extends StatefulWidget {
  @override
  State<ListenableBuilderExample> createState() =>
      _ListenableBuilderExampleState();
}

class _ListenableBuilderExampleState extends State<ListenableBuilderExample> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TableModel(),
      child: MaterialApp(
        home: TableExample(),
      ),
    );
  }
}

class TableExample extends StatefulWidget {
  @override
  State<TableExample> createState() => _TableExampleState();
}

class _TableExampleState extends State<TableExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic DataTable Rows'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Consumer<TableModel>(
          builder: (context, tableModel, child) {
            return DataTable(
              columns: [
                DataColumn(label: Text('Column 1')),
                DataColumn(label: Text('Column 2')),
                DataColumn(label: Text('Column 3')),
              ],
              rows: tableModel.rows,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<TableModel>(context, listen: false).addRow();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
