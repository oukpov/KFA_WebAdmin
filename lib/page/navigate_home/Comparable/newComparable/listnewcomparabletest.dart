// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:getwidget/components/button/gf_button.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:web_admin/interface/navigate_home/Comparable/newComparable/responsivenewcomparableget.dart';
// import 'package:web_admin/interface/navigate_home/Comparable/newComparable/responsiveupdate.dart';
// import '../../../../screen/Property/Map/ToFromDate_ForSale.dart';

// class List_newcomparabletest extends StatefulWidget {
//   List_newcomparabletest({super.key, required this.name});
//   final String name;
//   @override
//   State<List_newcomparabletest> createState() => _List_newcomparabletestState();
// }

// TextEditingController? _log;
// TextEditingController? _lat;
// String? comparabledate;
// String? genderList;
// String? provnce_id;
// String? songkat;
// String? compare_bank_id;
// String? compare_bank_branch_id;
// String? com_bank_brand;
// String? com_bankofficer;
// String? zoning_id;
// String? provice_map;
// String? khan;
// String? latlong_la;
// String? latlong_log;
// String? value_d;
// String? com_property_type;
// String? total_b;
// String? lproperty;
// String? w;
// String? wb;
// String? ltotal;
// String? lb;
// String? lwproperty;
// String? officer_price_total;
// String? comparable_add_price;
// String? comparable_addprice_total;
// String? askingprice;
// String? comparable_phone;
// String? comparable_remark;
// String? officer_price;
// String? sqm_total;
// String? Amount;
// String? condtion;
// String? condition;
// String? year;
// String? comparable_bought_price;
// String? comparable_bought_price_total;
// String? comparable_sold_price;
// String? comparable_sold_total_price;
// String? address;
// String? district_id;
// String? cummune_id;
// String? com_bank_officer = '';
// String? com_bankofficer_contact;
// String? comparable_road;
// String? province;
// String provinceName = '';
// String? district;
// String? commune;
// String? comparable_adding_price;
// String? comparable_land_total;
// String? comparable_land_length;
// String? comparable_land_width;
// String? comparable_sold_length;
// String? comparable_survey_date;
// String? comparable_property_id;
// String? comparable_sold_width;
// String? comparable_sold_total;
// String? comparable_adding_total;
// String? comparableaddprice;
// String? comparableaddpricetotal;
// String? comparableboughtprice;
// String? comparableboughtpricetotal;
// String? comparableAmount;
// String? comparable_condition_id;
// String? comparable_year;
// String? comparable_address;
// String? comparableDate;
// TextEditingController _controllerL = TextEditingController();
// TextEditingController _controllerW = TextEditingController();
// List list = [];

// class _List_newcomparabletestState extends State<List_newcomparabletest> {
//   int on_row = 20;

//   bool wait = false;
//   bool _wait = false;
//   String? _search;
//   String? end;
//   String? start;
//   String? name;
//   Future getdataval() async {
//     wait = true;
//     await Future.wait([getdata()]);
//     setState(() {
//       wait = false;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     searchbetween();
//   }

//   void _setSate(VoidCallback fn) {
//     setState(fn);
//   }

//   Future getdata() async {
//     try {
//       final response = await http.get(Uri.parse(
//           // 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparable_search?start=2022-01-1&end=2022-02-1'));
//           'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparable_search?search=$_search'));
//       if (response.statusCode == 200) {
//         final List<dynamic> jsonBody = jsonDecode(response.body);
//         list = jsonBody;

//         setState(() {
//           list;
//         });
//       } else {
//         print('Error Comparable Search');
//       }
//     } catch (e) {
//       print('Error value_all_list $e');
//     }
//   }

//   Future search() async {
//     _wait = true;
//     await Future.wait([searchbetween()]);
//     setState(() {
//       _wait = false;
//     });
//   }

//   Future searchbetween() async {
//     try {
//       final response = await http.get(Uri.parse(
//           'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparable_search?start=2022-01-1&end=2024-02-1'));
//       // 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparable_search_date?start=$start&end=$end'));
//       //'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparable_search?search=$_search'));
//       if (response.statusCode == 200) {
//         final List<dynamic> jsonBody = jsonDecode(response.body);
//         list = jsonBody;

//         setState(() {
//           list;
//         });
//       } else {
//         print('Error Comparable Search');
//       }
//     } catch (e) {
//       print('Error value_all_list $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     setState(() {
//       // searchbetween();
//       // getdata();
//     });
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("New verbal list"),
//       ),
//       body: _wait
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : comparable(context),
//     );
//   }

//   Widget comparable(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Row(
//             children: [
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 width: MediaQuery.of(context).size.width * 0.65,
//                 child: Padding(
//                   padding: const EdgeInsets.all(1.0),
//                   child: TextFormField(
//                       onChanged: (value) {
//                         setState(() {
//                           _search = value;
//                         });
//                       },
//                       decoration: const InputDecoration(
//                         prefixIcon: Icon(Icons.search),
//                         border: OutlineInputBorder(),
//                         hintText: 'Id Search here...',
//                       )),
//                 ),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               GFButton(
//                 color: Color.fromARGB(255, 9, 19, 125),
//                 size: MediaQuery.of(context).size.height * 0.07,
//                 elevation: 12,
//                 onPressed: () {
//                   setState(() {
//                     if (start != null && end != null) {
//                       searchbetween();
//                     } else {
//                       getdataval();
//                     }
//                   });
//                 },
//                 text: "Search",
//                 icon: const Icon(
//                   Icons.search,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           ToFromDate_p(
//             fromDate: (value) {
//               setState(() {
//                 start = value.toString();
//                 start;
//               });
//             },
//             toDate: (value) {
//               setState(() {
//                 end = value.toString();
//                 end;
//               });
//             },
//           ),
//           wait
//               ? const Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : Container(
//                   width: MediaQuery.of(context).size.width * 1,
//                   padding: const EdgeInsets.all(5),
//                   child: PaginatedDataTable(
//                     columnSpacing: 40.0,
//                     horizontalMargin: 5.0,
//                     // arrowHeadColor: Colors.blueAccent[300],
//                     columns: const [
//                       DataColumn(
//                           label: Text(
//                         'No',
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       )),
//                       DataColumn(
//                           label: Text(
//                         'Action',
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       )),
//                       DataColumn(
//                           label: Text(
//                         'Proerty Type',
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       )),
//                       DataColumn(
//                           label: Text(
//                         'Land Size',
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       )),
//                       DataColumn(
//                           label: Text(
//                         'Building Size',
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       )),
//                       DataColumn(
//                           label: Text(
//                         'Asking',
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       )),
//                       DataColumn(
//                           label: Text(
//                         'Offered',
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       )),
//                       DataColumn(
//                           label: Text(
//                         'Bought',
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       )),
//                       DataColumn(
//                           label: Text(
//                         'Sold Out',
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       )),
//                       DataColumn(
//                           label: Text(
//                         'Location',
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       )),
//                       DataColumn(
//                           label: Text(
//                         'Agency',
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       )),
//                       DataColumn(
//                           label: Text(
//                         'Code',
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       )),
//                       DataColumn(
//                           label: Text(
//                         'Survey Date',
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       )),
//                     ],
//                     dataRowHeight: 35,
//                     rowsPerPage: on_row,
//                     onRowsPerPageChanged: (value) {
//                       setState(() {
//                         on_row = value!;
//                       });
//                     },
//                     source: _DataSource(
//                         data: list,
//                         context: context,
//                         count_row: list.length,
//                         name: widget.name,
//                         setstate: _setSate,
//                         waiting: (value) {
//                           setState(() {
//                             _wait = value;
//                           });
//                         }),
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
// }

// void DeTail_screen(BuildContext context, list, int index, String name) async {
//   Navigator.push(context, MaterialPageRoute(
//     builder: (context) {
//       return ResponsivenewcomparableGet(
//         index: index,
//       );
//     },
//   ));
// }

// class _DataSource extends DataTableSource {
//   final BuildContext context;
//   final int count_row;
//   final String name;
//   final List data;
//   final Function setstate;
//   final OnChangeCallback waiting;
//   _DataSource(
//       {required this.data,
//       required this.count_row,
//       required this.context,
//       required this.setstate,
//       required this.waiting,
//       required this.name});
//   Future<void> _clones() async {
//     waiting(true);
//     await Future.wait([clonecomparable()]);
//   }

//   Future<void> deleteverify(String id) async {
//     waiting(true);
//     await Future.wait([deletecomparable(id)]);
//   }

//   @override
//   DataRow? getRow(int index) {
//     if (index >= data.length) {
//       return null;
//     }
//     final item = data[index];
//     Future<void> saveclone() async {
//       compare_bank_id = item['compare_bank_id'].toString();
//       compare_bank_branch_id = (item['compare_bank_branch_id'] == null ||
//               item['compare_bank_branch_id'] == "")
//           ? ''
//           : item['compare_bank_branch_id'].toString();
//       com_bankofficer = item['com_bankofficer'].toString();
//       com_bankofficer_contact = item['com_bankofficer_contact'].toString();
//       zoning_id = item['zoning_id'].toString();
//       comparable_property_id = item['comparable_property_id'].toString();
//       comparable_land_total = item['comparable_land_total'].toString();
//       comparable_road = item['comparable_road'].toString();
//       comparable_land_length = item['comparable_land_length'].toString();
//       comparable_land_width = item['comparable_land_width'].toString();
//       comparable_sold_length = item['comparable_sold_length'].toString();
//       comparable_sold_width = item['comparable_sold_width'].toString();
//       comparable_sold_total = item['comparable_sold_total'].toString();
//       comparable_adding_price = item['comparable_adding_price'].toString();
//       comparable_adding_total = item['comparable_adding_total'].toString();
//       comparableaddprice = item['comparableaddprice'].toString();
//       comparableaddpricetotal = item['comparableaddpricetotal'].toString();
//       comparableboughtprice = item['comparableboughtprice'].toString();
//       comparableboughtpricetotal =
//           item['comparableboughtpricetotal'].toString();
//       comparable_sold_price = item['comparable_sold_price'].toString();
//       comparable_sold_total_price =
//           item['comparable_sold_total_price'].toString();
//       comparableAmount = item['comparableAmount'].toString();
//       comparable_condition_id = item['comparable_condition_id'].toString();
//       comparable_year = item['comparable_year'].toString();
//       comparable_address = item['comparable_address'].toString();
//       province = item['province'].toString();
//       district = item['district'].toString();
//       commune = item['commune'].toString();
//       comparableDate = item['comparableDate'].toString();
//       comparable_remark = item['comparable_remark'].toString();
//       comparable_survey_date = item['comparable_survey_date'].toString();
//       comparable_phone = item['comparable_phone'].toString();
//       latlong_log = item['latlong_log'].toString();
//       latlong_la = item['latlong_la'].toString();
//     }

//     return DataRow(selected: true, cells: [
//       DataCell(
//         placeholder: true,
//         Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Text(
//               "${index + 1}",
//               style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         onTap: () {
//           // DeTail_screen(context, data, index);
//           print(data[index].toString());
//         },
//       ),
//       DataCell(
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             InkWell(
//               onTap: () {
//                 // DeTail_screen(context, data, index);
//                 Navigator.push(context, MaterialPageRoute(
//                   builder: (context) {
//                     return ResponsiveHomePupdate(
//                       list: item,
//                     );
//                   },
//                 ));
//               },
//               child: const Icon(
//                 Icons.edit,
//                 color: Colors.black,
//                 size: 24,
//               ),
//             ),
//             // SizedBox(
//             //   height: 20,
//             //   width: 50,
//             //   child: GFButton(
//             //     color: Colors.green,
//             //     onPressed: () {
//             //       // DeTail_screen(context, data, index);
//             //       Navigator.push(context, MaterialPageRoute(
//             //         builder: (context) {
//             //           return ResponsiveHomePupdate(
//             //             list: item,
//             //           );
//             //         },
//             //       ));
//             //     },
//             //     text: "Edit",
//             //     shape: GFButtonShape.pills,
//             //     fullWidthButton: true,
//             //   ),
//             // ),
//             SizedBox(
//               width: 5,
//             ),
//             InkWell(
//               onTap: () {
//                 // DeTail_screen(context, data, index);
//                 setstate(() {
//                   //deletecomparable(item['comparable_id'].toString());
//                   deleteverify(item['comparable_id'].toString());
//                 });
//               },
//               child: const Icon(
//                 Icons.delete,
//                 color: Colors.red,
//                 size: 24,
//               ),
//             ),
//             // SizedBox(
//             //   height: 20,
//             //   width: 60,
//             //   child: GFButton(
//             //     color: Colors.red,
//             //     onPressed: () {
//             //       setstate(() {
//             //         //deletecomparable(item['comparable_id'].toString());
//             //         deleteverify(item['comparable_id'].toString());
//             //       });
//             //       // DeTail_screen(context, data, index);
//             //     },
//             //     text: "Delete",
//             //     shape: GFButtonShape.pills,
//             //     fullWidthButton: true,
//             //   ),
//             // ),
//             SizedBox(
//               width: 5,
//             ),
//             SizedBox(
//               width: 5,
//             ),
//             InkWell(
//               onTap: () {
//                 // DeTail_screen(context, data, index);
//                 setstate(() async {
//                   saveclone();
//                   // await clonecomparable();
//                   _clones();
//                   //print(latlong_la);
//                 });
//               },
//               child: const Icon(
//                 Icons.file_copy_sharp,
//                 color: Colors.blueAccent,
//                 size: 24,
//               ),
//             )
//             // SizedBox(
//             //   height: 20,
//             //   width: 60,
//             //   child: GFButton(
//             //     onPressed: () {
//             //       setstate(() async {
//             //         saveclone();
//             //         // await clonecomparable();
//             //         _clones();
//             //         //print(latlong_la);
//             //       });
//             //       //DeTail_screen(context, data, index);
//             //       // Navigator.push<void>(
//             //       //   context,
//             //       //   MaterialPageRoute<void>(
//             //       //     builder: (BuildContext context) => PaginatedTest(
//             //       //       name: '',
//             //       //     ),
//             //       //   ),
//             //       // );
//             //     },
//             //     text: "Clone",
//             //     shape: GFButtonShape.pills,
//             //     fullWidthButton: true,
//             //   ),
//             // ),
//             //)
//           ],
//         ),
//         onTap: () {
//           setstate(() {});
//           DeTail_screen(context, item, index, name);
//         },
//       ),
//       DataCell(
//         Text(
//           ((item['comparable_property_id'].toString()) == 'null')
//               ? ''
//               : item['comparable_property_id'].toString(),
//           style: TextStyle(fontSize: 10),
//           overflow: TextOverflow.ellipsis,
//         ),
//         onTap: () {
//           DeTail_screen(context, item, index, name);
//         },
//       ),
//       DataCell(
//         Text(
//           ((item['comparable_land_total'].toString()) == 'null')
//               ? ''
//               : item['comparable_land_total'].toString(),
//           style: TextStyle(fontSize: 10),
//           overflow: TextOverflow.ellipsis,
//         ),
//         onTap: () {
//           // DeTail_screen(context, item);
//           DeTail_screen(context, item, index, name);
//         },
//       ),
//       DataCell(
//         Text(
//           ((item['comparable_sold_total'].toString()) == 'null')
//               ? ''
//               : item['comparable_sold_total'].toString(),
//           style: TextStyle(fontSize: 10),
//           overflow: TextOverflow.ellipsis,
//         ),
//         onTap: () {
//           DeTail_screen(context, item, index, name);
//         },
//       ),
//       DataCell(
//         Text(
//           ((item['comparableAmount'].toString()) == 'null')
//               ? ''
//               : item['comparableAmount'].toString(),
//           style: TextStyle(fontSize: 10),
//           overflow: TextOverflow.ellipsis,
//         ),
//         onTap: () {
//           DeTail_screen(context, item, index, name);
//         },
//       ),
//       DataCell(
//           Text(
//             ((item['comparable_sold_total_price'].toString()) == 'null')
//                 ? ''
//                 : item['comparable_sold_total_price'].toString(),
//             style: TextStyle(fontSize: 10),
//             overflow: TextOverflow.ellipsis,
//           ), onTap: () {
//         DeTail_screen(context, item, index, name);
//       }),
//       DataCell(
//         Text(
//           ((item['comparableboughtprice'].toString()) == 'null')
//               ? ''
//               : item['comparableboughtprice'].toString(),
//           style: TextStyle(fontSize: 10),
//         ),
//         onTap: () {
//           DeTail_screen(context, item, index, name);
//         },
//       ),
//       DataCell(
//         Text(
//           ((item['comparable_sold_price'].toString()) == 'null')
//               ? ''
//               : item['comparable_sold_price'].toString(),
//           style: TextStyle(fontSize: 10),
//           overflow: TextOverflow.ellipsis,
//         ),
//         onTap: () {
//           DeTail_screen(context, item, index, name);
//         },
//       ),
//       DataCell(
//         Text(
//           ((item['comparable_address'].toString()) == 'null')
//               ? ''
//               : item['comparable_address'].toString(),
//           style: TextStyle(fontSize: 10),
//           overflow: TextOverflow.ellipsis,
//         ),
//         onTap: () {
//           DeTail_screen(context, item, index, name);
//         },
//       ),
//       DataCell(
//         Text(
//           // '${name}',
//           'N/A',
//           // '${name}',
//           style: TextStyle(fontSize: 10),
//           overflow: TextOverflow.ellipsis,
//         ),
//         onTap: () {
//           DeTail_screen(context, item, index, name);
//         },
//       ),
//       DataCell(
//         Text(
//           ((item['comparable_id'].toString()) == 'null')
//               ? ''
//               : item['comparable_id'].toString(),
//           style: TextStyle(fontSize: 10),
//           overflow: TextOverflow.ellipsis,
//         ),
//         onTap: () {
//           DeTail_screen(context, item, index, name);
//         },
//       ),
//       DataCell(
//           Text(
//             ((item['comparable_survey_date'].toString()) == 'null')
//                 ? ''
//                 : item['comparable_survey_date'].toString(),
//             style: TextStyle(fontSize: 10),
//             overflow: TextOverflow.ellipsis,
//           ), onTap: () {
//         DeTail_screen(context, item, index, name);
//       }),
//     ]);
//   }

//   @override
//   int get rowCount => count_row;

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get selectedRowCount => 0;
//   Future<void> clonecomparable() async {
//     var headers = {'Content-Type': 'application/json'};
//     var data = json.encode({
//       "compare_bank_id": compare_bank_id.toString(),
//       "compare_bank_branch_id": compare_bank_branch_id.toString(),
//       "com_bankofficer":
//           (com_bankofficer == null) ? 'null' : com_bankofficer.toString(),
//       "com_bankofficer_contact": (com_bankofficer_contact == null)
//           ? 'null'
//           : com_bankofficer_contact.toString(),
//       "zoning_id": ((zoning_id == null) ? '' : zoning_id.toString()),
//       "comparable_property_id": comparable_property_id.toString(),
//       "comparable_road": (comparable_road == null)
//           ? null
//           : int.parse(comparable_road.toString()),
//       "comparable_land_length": comparable_land_length.toString(),
//       "comparable_land_width": comparable_land_width.toString(),
//       "comparable_land_total": comparable_land_total.toString(),
//       "comparable_sold_length": (comparable_sold_length == null)
//           ? 'null'
//           : comparable_sold_length.toString(),
//       "comparable_sold_width": comparable_sold_width.toString(),
//       "comparable_sold_total": comparable_sold_total.toString(),
//       "comparable_adding_price": (comparable_adding_price == null)
//           ? ''
//           : comparable_adding_price.toString(),
//       "comparable_adding_total": (comparable_adding_total == null)
//           ? 'null'
//           : comparable_adding_total.toString(),
//       "comparableaddprice":
//           (comparableaddprice == null) ? 'null' : comparableaddprice.toString(),
//       "comparableaddpricetotal": (comparableaddpricetotal == null)
//           ? 'null'
//           : comparableaddpricetotal.toString(),
//       "comparableboughtprice": (comparableboughtprice == null)
//           ? 'null'
//           : comparableboughtprice.toString(),
//       "comparableboughtpricetotal": (comparableboughtpricetotal == null)
//           ? null
//           : comparableboughtpricetotal.toString(),
//       "comparable_sold_price": (comparable_sold_price == null)
//           ? null
//           : comparable_sold_price.toString(),
//       "comparable_sold_total_price": (comparable_sold_total_price == null)
//           ? null
//           : comparable_sold_total_price.toString(),
//       "comparableAmount":
//           (comparableAmount == null) ? 'null' : comparableAmount.toString(),
//       "comparable_condition_id": (comparable_condition_id == null)
//           ? null
//           : comparable_condition_id.toString(),
//       "comparable_year":
//           (comparable_year == null) ? 'null' : comparable_year.toString(),
//       "comparable_address":
//           (comparable_address == null) ? 'null' : comparable_address.toString(),
//       "province": province.toString(),
//       "district": district.toString(),
//       "commune": commune.toString(),
//       "comparableDate":
//           (comparableDate == null) ? 'null' : comparableDate.toString(),
//       "comparable_remark":
//           (comparable_remark == null) ? 'null' : comparable_remark.toString(),
//       "comparable_survey_date": (comparable_survey_date == null)
//           ? 'null'
//           : comparable_survey_date.toString(),
//       "comparable_phone":
//           (comparable_phone == null) ? null : comparable_phone.toString(),
//       "latlong_log": double.parse(latlong_log.toString()),
//       "latlong_la": double.parse(latlong_la.toString()),
//     });
//     var dio = Dio();
//     var response = await dio.request(
//       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/new_comparable',
//       options: Options(
//         method: 'POST',
//         headers: headers,
//       ),
//       data: data,
//     );

//     if (response.statusCode == 200) {
//       print(json.encode(response.data));
//       setstate(() {
//         waiting(false);
//       });
//     } else {
//       print(response.statusMessage);
//     }
//   }

//   Future<void> deletecomparable(String id) async {
//     var data = '''''';
//     var dio = Dio();
//     var response = await dio.request(
//       "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/delete_comparable/${id.toString()}}",
//       options: Options(
//         method: 'DELETE',
//       ),
//       data: data,
//     );

//     if (response.statusCode == 200) {
//       print(json.encode(response.data));
//       setstate(() {
//         waiting(false);
//       });
//     } else {
//       print(response.statusMessage);
//     }
//   }
// }
