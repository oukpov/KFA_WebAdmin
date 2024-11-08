// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// import '../../../../../../Profile/components/Drop_down.dart';
// import '../../../../../../components/colors.dart';
// import 'detail_Table.dart';

// class DataSource extends DataTableSource {
//   final List data;
//   final int count_row;
//   final BuildContext context;
//   final List list;
//   final Function setStateCallback;
//   // final OnChangeCallback listback;

//   DataSource({
//     required this.data,
//     required this.count_row,
//     required this.context,
//     required this.list,
//     required this.setStateCallback,
//     // required this.listback,
//     Key? key,
//   });
//   // DataSource( Key? key,this.data, this.count_row, this.context, this.device, this.list,
//   //     this.userID, this.setStateCallback, this.listback: super(key: key);

//   int selectindex = -1;

//   @override
//   DataRow? getRow(int index) {
//     if (index >= data.length) {
//       return null;
//     }

//     final item = data[index];

//     return DataRow(
//       color: MaterialStateProperty.resolveWith<Color?>(
//         (Set<MaterialState> states) {
//           return index % 2 == 0
//               ? const Color.fromARGB(168, 181, 181, 183)
//               : Colors.white;
//         },
//       ),
//       cells: [
//         buildDataCell("${index + 1}", true, index),
//         buildDataCell("${item['control_user'] ?? ""}", true, index),
//         buildDataCell("${item['username'] ?? ""}", true, index),
//         buildDataCell("${item['tel_num'] ?? ""}", false, index),
//       ],
//     );
//   }

//   DataCell buildDataCell(String text, bool fw, int index) {
//     return DataCell(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const ListDetailReport(),
//             ));
//       },
//       Text(
//         text,
//         style: TextStyle(
//             fontSize: 13,
//             color: greyColor,
//             fontWeight: fw ? FontWeight.bold : null),
//       ),
//     );
//   }

//   List listIcon = const [Icons.print, Icons.edit, Icons.delete];

//   @override
//   int get rowCount => count_row;

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get selectedRowCount => 0;
// }
