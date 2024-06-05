import 'package:flutter/material.dart';

import '../../navigate_home/User/detail_notivigtion.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key, required this.listnotificationlist});
  final List listnotificationlist;
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  int onrow = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        padding: const EdgeInsets.all(5),
        child: PaginatedDataTable(
          horizontalMargin: 5.0,
          arrowHeadColor: Colors.blueAccent[300],
          columns: const [
            DataColumn(
                label: Text(
              'UseID',
              style: TextStyle(color: Colors.green),
            )),
            DataColumn(
                label: Text(
              'Name',
              style: TextStyle(color: Colors.green),
            )),
            DataColumn(
                label: Text(
              'Gender',
              style: TextStyle(color: Colors.green),
            )),
            DataColumn(
                label: Text(
              'Phone',
              style: TextStyle(color: Colors.green),
            )),
          ],
          dataRowHeight: 50,
          rowsPerPage: onrow,
          onRowsPerPageChanged: (value) {
            setState(() {
              onrow = value!;
            });
          },
          source: DataSource(widget.listnotificationlist,
              widget.listnotificationlist.length, context),
        ),
      ),
    );
  }
}

class DataSource extends DataTableSource {
  final List data;
  final int count_row;
  final BuildContext context;
  DataSource(this.data, this.count_row, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];
    return DataRow(
        selected: true,
        color: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return index % 2 == 0
                  ? const Color.fromARGB(168, 73, 83, 224)
                  : Colors.white;
            }
            return index % 2 == 0
                ? const Color.fromARGB(255, 255, 162, 162)
                : Colors.white;
          },
        ),
        cells: [
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  item['id'].toString(),
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => Detail_Notivigation2(
                          list_widget: item,
                          id: item['id'].toString(),
                        )),
              );
            },
          ),
          DataCell(
            Text(
              item['username'].toString(),
              style: const TextStyle(fontSize: 10),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => Detail_Notivigation2(
                          list_widget: item,
                          id: item['id'].toString(),
                        )),
              );
            },
          ),
          DataCell(
            Text(
              item['gender'].toString(),
              style: const TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => Detail_Notivigation2(
                          list_widget: item,
                          id: item['id'].toString(),
                        )),
              );
            },
          ),
          DataCell(
            Text(
              item['tel_num'].toString(),
              style: const TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => Detail_Notivigation2(
                          list_widget: item,
                          id: item['id'].toString(),
                        )),
              );
            },
          ),
        ]);
  }

  @override
  int get rowCount => count_row;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
