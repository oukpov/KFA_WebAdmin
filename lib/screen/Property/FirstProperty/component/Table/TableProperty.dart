// import 'package:flutter/material.dart';

// class TableProperty extends StatefulWidget {
//   const TableProperty({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<TableProperty> createState() => _MyDataTableState();
// }

// class _MyDataTableState extends State<TableProperty> {
//   bool isSelected = false;
//   List<Map<String, String>> listTitle = [
//     {"title": "No"},
//     {"title": "Action"},
//     {"title": "Print"},
//     {"title": "Property Type"},
//     {"title": "Land Size"},
//     {"title": "Building Size"},
//     {"title": "Asking"},
//     {"title": "Offered"},
//     {"title": "Bought"},
//     {"title": "Sold Out"},
//     {"title": "Location"},
//     {"title": "Survey Date"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return DataTable(
//       columns: [
//         for (int i = 0; i < listTitle.length; i++)
//           DataColumn(label: Text('${listTitle[i]['title']}')),
//       ],
//       rows: [
//         for (int x = 0; x < 16; x++)
//           DataRow(cells: [
//             for (int i = 0; i < listTitle.length; i++)
//               DataCell(Container(
//                 color: Colors.red,
//               )),
//           ]),
//       ],
//     );
//   }
// }
//     //  Container(
//     //             height: MediaQuery.of(context).size.height * 0.4,
//     //             width: double.infinity,
//     //             child: ListView(
//     //               children: const [
//     //                 SingleChildScrollView(
//     //                   scrollDirection: Axis.horizontal,
//     //                   child: SingleChildScrollView(
//     //                       scrollDirection: Axis.vertical,
//     //                       child: TableProperty()),
//     //                 ),
//     //               ],
//     //             ))