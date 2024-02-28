// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:kfa_project/screen/Property/FirstProperty/component/Colors/appbar.dart';
// import 'package:kfa_project/screen/Property/FirstProperty/component/Colors/colors.dart';
// import 'package:http/http.dart' as http;
// import '../../../../../../contants.dart';

// import '../../../component/OPtion/Option.dart';
// import '../MenuMoreOption/More/MoreOption.dart';
// import '../MenuMoreOption/Price/price.dart';

// typedef OnChangeCallback = void Function(dynamic value);

// class OptionDetail extends StatefulWidget {
//   const OptionDetail({
//     super.key,
//     required this.listOption,
//     required this.title,
//     required this.typeDrawer,
//     required this.opTion,
//     required this.list,
//   });
//   final OnChangeCallback listOption;
//   final OnChangeCallback title;
//   final String typeDrawer;
//   final List list;

//   final bool opTion;
//   @override
//   State<OptionDetail> createState() => _OptionDetailState();
// }

// class _OptionDetailState extends State<OptionDetail> {
//   @override
//   void initState() {
//     super.initState();
//     homeType();

//     if (widget.typeDrawer != '') {
//       drawer();
//       if (widget.typeDrawer == 'For Sale') {
//         typeTitle = 'FOR SALE';
//       } else if (widget.typeDrawer == 'For Rent') {
//         typeTitle = 'FOR RENT';
//       } else {
//         typeTitle = widget.typeDrawer;
//       }
//     } else {
//       propertyListing();
//     }
//   }

//   String min = '', max = '', province = '';
//   String minland = '', maxland = '';
//   List listTypeOptions = [
//     {"type": "For Sale"},
//   ];
//   bool priceBool = false;
//   double w = 0;
//   double l = 0;
//   double wOption = 0;
//   @override
//   Widget build(BuildContext context) {
//     w = MediaQuery.of(context).size.width;
//     if (w > 1199) {
//       l = (w - 1199) / 4;
//     }
//     if (w < 770) {
//       wOption = 250;
//     } else {
//       wOption = 200;
//     }
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Padding(
//         padding: EdgeInsets.only(right: l, left: l),
//         child: SizedBox(
//           height: 100,
//           width: double.infinity,
//           child: Wrap(
//             children: [
//               if (w >= 1199)
//                 Padding(
//                   padding: const EdgeInsets.only(right: 50, top: 20),
//                   child: Text('${listLenght.length} LISTING $typeTitle',
//                       style: TextStyle(
//                           fontSize: MediaQuery.textScaleFactorOf(context) * 25,
//                           color: appback)),
//                 ),
//               dropDown(' ${listTypeOption[0]['type']}', hometype,
//                   listTypeOption, 'type', 'type', wOption, 0),
//               dropDown(' ${listTypeOption[1]['type']}', hometype,
//                   listTypeOption, 'type', 'type', wOption, 1),
//               dropDown(' ${listTypeOption[2]['type']}', hometype, listhometype,
//                   'hometype', 'hometype', 160, 2),
//               dropDown(' ${listTypeOption[3]['type']}', hometype,
//                   listTypeOption, 'type', 'type', wOption, 3),
//               dropDown(' ${listTypeOption[4]['type']}', hometype,
//                   listTypeOption, 'type', 'type', wOption, 4),
//               dropDown(' ${listTypeOption[5]['type']}', hometype, searchList,
//                   'relationship', 'title', wOption, 5),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   int selectedIdx = -1;
//   bool select = false;
//   String typeOptions = '';

//   String hometype = '';
//   String price = '';
//   String more = '';
//   String search = '';
//   String query = '';
//   bool typeOpTion = false;
//   double wDropDown = 150;
//   int font = 11;
//   String typeTitle = '';
//   bool hinText = false;
//   Widget dropDown(text, values, List list, valueDrop, nameDropdown, w, i) {
//     return (i < 2)
//         ? InkWell(
//             onTap: () {
//               setState(() {
//                 selectedIdx = (selectedIdx == i) ? -1 : i;
//                 if (i == 0) {
//                   widget.title('FOR SALE');
//                   typeTitle = 'FOR SALE';
//                   if ((typeOptions == '' && first == '') || first == 'type') {
//                     first = 'type';
//                     getfirst = 'type=For Sale';
//                   } else {
//                     typeOptions = '&type=For Sale';
//                   }
//                 } else {
//                   typeTitle = 'FOR RENT';
//                   widget.title('FOR RENT');
//                   if ((typeOptions == '' && first == '') || first == 'type') {
//                     first = 'type';
//                     getfirst = 'type=For Rent';
//                   } else {
//                     typeOptions = '&type=For Rent';
//                   }
//                 }
//               });
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(top: 5, right: 10),
//               child: Container(
//                 alignment: Alignment.center,
//                 height: 35,
//                 width: wDropDown,
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                         width: (selectedIdx == i) ? 2 : 0.5,
//                         color: (selectedIdx == i) ? appback : greyColor),
//                     borderRadius: BorderRadius.circular(5)),
//                 child: Text(
//                   '${listTypeOption[i]['type']}',
//                   style: TextStyle(
//                       fontSize: MediaQuery.textScaleFactorOf(context) * font),
//                 ),
//               ),
//             ),
//           )
//         : (i == 3 || i == 4)
//             ? InkWell(
//                 onTap: () {
//                   setState(() {
//                     if (i == 3) {
//                       showModalBottomSheet(
//                         backgroundColor: Colors.transparent,
//                         context: context,
//                         isScrollControlled: true,
//                         builder: (BuildContext context) {
//                           return PriceOption(
//                             max: (value) {
//                               setState(() {
//                                 max = '&max=$value';
//                               });
//                             },
//                             min: (value) {
//                               setState(() {
//                                 min = '&min=$value';
//                               });
//                             },
//                           );
//                         },
//                       );
//                     } else {
//                       showModalBottomSheet(
//                         backgroundColor: Colors.transparent,
//                         context: context,
//                         isScrollControlled: true,
//                         builder: (BuildContext context) {
//                           return OptionshowModalBottomSheet(
//                             province: (value) {
//                               setState(() {
//                                 province = '&property_type_id=$value';
//                               });
//                             },
//                             min: (value) {
//                               setState(() {
//                                 minland = '&minland=$value';
//                               });
//                             },
//                             max: (value) {
//                               setState(() {
//                                 maxland = '&maxland=$value';
//                               });
//                             },
//                           );
//                         },
//                       );
//                     }
//                   });
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 5, right: 10),
//                   child: Container(
//                     alignment: Alignment.center,
//                     height: 35,
//                     width: wDropDown,
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                             width: (selectedIdx == i) ? 2 : 0.5,
//                             color: (selectedIdx == i) ? appback : greyColor),
//                         borderRadius: BorderRadius.circular(5)),
//                     child: Text(
//                       '${listTypeOption[i]['type']}',
//                       style: TextStyle(
//                           fontSize:
//                               MediaQuery.textScaleFactorOf(context) * font),
//                     ),
//                   ),
//                 ),
//               )
//             : Padding(
//                 padding: const EdgeInsets.only(top: 5, right: 10),
//                 child: Container(
//                   height: 35,
//                   width: wDropDown,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       border: Border.all(width: 0.5, color: greyColor)),
//                   child: DropdownButtonFormField<String>(
//                     icon: (i == 5)
//                         ? InkWell(
//                             onTap: () {
//                               moreOPTion();
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                   color: appback,
//                                   borderRadius: BorderRadius.circular(5)),
//                               width: 35,
//                               child: Icon(
//                                 Icons.search,
//                                 color: whiteColor,
//                               ),
//                             ),
//                           )
//                         : null,
//                     decoration: InputDecoration(
//                       icon: null,
//                       fillColor: kwhite,
//                       floatingLabelAlignment: FloatingLabelAlignment.center,
//                       filled: true,
//                       // labelText: text,
//                       labelStyle: TextStyle(
//                           fontSize:
//                               MediaQuery.of(context).textScaleFactor * font),
//                       hintText: text,
//                       hintStyle: TextStyle(color: blackColor),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: appback, width: 1.0),
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(
//                           width: 0.5,
//                           color: Color.fromARGB(255, 127, 127, 127),
//                         ),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       border: InputBorder.none,

//                       contentPadding: const EdgeInsets.symmetric(
//                           vertical: 8, horizontal: 0),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(
//                           width: 2,
//                           color: kerror,
//                         ),
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                     ),
//                     items: list
//                         .map<DropdownMenuItem<String>>(
//                           (value) => DropdownMenuItem<String>(
//                             value: value["$valueDrop"].toString(),
//                             child: Center(
//                               child: Text(
//                                 " ${value["$nameDropdown"]}",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize:
//                                       MediaQuery.textScaleFactorOf(context) *
//                                           font,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                         .toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedIdx = -1;
//                         if (i == 2) {
//                           if ((hometype == '' && first == '') ||
//                               first == 'hometype') {
//                             first == 'hometype';
//                             getfirst = 'hometype=$value';
//                           } else {
//                             hometype = '&hometype=$value';
//                           }
//                         } else if (i == 3) {
//                           print('Price');

//                           price = price;
//                         } else if (i == 4) {
//                           print('More');
//                           more = value!;
//                         } else if (i == 5) {
//                           searchbutton = value!;
//                         }
//                       });
//                     },
//                   ),
//                 ),
//               );
//   }

//   Future<void> propertyListing() async {
//     var dio = Dio();
//     var response = await dio.request(
//       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/More_option',
//       options: Options(
//         method: 'GET',
//       ),
//     );

//     if (response.statusCode == 200) {
//       var list = jsonDecode(json.encode(response.data));
//       widget.listOption(list);
//       listLenght = list;

//       print(query);
//     } else {
//       print(response.statusMessage);
//     }
//   }

//   List list = [];
//   List listLenght = [];
//   String first = '';
//   String getfirst = '';
//   Future<void> drawer() async {
//     if (widget.opTion == true) {
//       listLenght = list = widget.list;
//       widget.listOption(list);
//     } else {
//       var dio = Dio();
//       var response = await dio.request(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/More_option?type=${widget.typeDrawer}',
//         options: Options(
//           method: 'GET',
//         ),
//       );

//       if (response.statusCode == 200) {
//         var list = jsonDecode(json.encode(response.data));
//         widget.listOption(list);
//         listLenght = list;

//         print(query);
//       } else {
//         print(response.statusMessage);
//       }
//     }
//   }

//   bool searchbool = false;
//   String searchbutton = '';
//   Future<void> moreOPTion() async {
//     setState(() {
//       if (searchbutton == '') {
//         query = '$getfirst$hometype$min$max$minland$maxland$province';
//       } else {
//         query = searchbutton;
//       }
//     });
//     var dio = Dio();
//     var response = await dio.request(
//       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/More_option?$query',
//       options: Options(
//         method: 'GET',
//       ),
//     );

//     if (response.statusCode == 200) {
//       var list = jsonDecode(json.encode(response.data));
//       setState(() {
//         widget.listOption(list);
//         listLenght = list;
//         min = max = maxland = minland = province = '';
//       });

//       print(query);
//     } else {
//       print(response.statusMessage);
//     }
//   }

//   List listhometype = [];
//   Future<void> homeType() async {
//     try {
//       final response = await http.get(Uri.parse(
//           'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_all_homeytpe'));
//       if (response.statusCode == 200) {
//         var jsonBody = jsonDecode(response.body)['data'];
//         setState(() {
//           listhometype = jsonBody;
//         });
//       } else {
//         print('Error value_all_list');
//       }
//     } catch (e) {
//       print('Error value_all_list $e');
//     }
//   }
// }
