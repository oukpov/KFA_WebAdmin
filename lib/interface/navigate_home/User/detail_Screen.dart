// // ignore_for_file: must_be_immutable

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';

// class Detail_Notivigation extends StatefulWidget {
//   Detail_Notivigation({super.key, required this.list_widget, required this.id});
//   dynamic? list_widget;
//   String? id;

//   @override
//   State<Detail_Notivigation> createState() => _Detail_ScreenState();
// }

// class _Detail_ScreenState extends State<Detail_Notivigation> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Color.fromARGB(255, 63, 82, 224),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 90,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         IconButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             icon: Icon(
//                               Icons.arrow_back_ios_new_outlined,
//                               color: Colors.white,
//                               size: 30,
//                             ))
//                       ],
//                     ),
//                     Center(
//                       child: Text(
//                         'Personal',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 30,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(40),
//                           topRight: Radius.circular(40)),
//                       color: Colors.white),
//                   height: MediaQuery.of(context).size.height * 0.83,
//                   width: double.infinity,
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 30,
//                       ),
//                       (widget.list_widget['url'] != null)
//                           ? Stack(children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.only(left: 20, right: 20),
//                                 child: Container(
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.3,
//                                   width: double.infinity,
//                                   child: CachedNetworkImage(
//                                     imageUrl:
//                                         '${widget.list_widget['url'].toString()}',
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 top: MediaQuery.of(context).size.height * 0.195,
//                                 left: 20,
//                                 child: InkWell(
//                                   onTap: () {
//                                     showDialog(
//                                       context: context,
//                                       builder: (context) {
//                                         return Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 10, right: 10),
//                                           child: Container(
//                                             // child: Image.network(
//                                             //   list2_Sale223![index]['url']
//                                             //       .toString(),
//                                             // ),
//                                             child: CachedNetworkImage(
//                                               imageUrl: widget
//                                                   .list_widget['url']
//                                                   .toString(),
//                                               progressIndicatorBuilder:
//                                                   (context, url,
//                                                           downloadProgress) =>
//                                                       Center(
//                                                 child:
//                                                     CircularProgressIndicator(
//                                                         value: downloadProgress
//                                                             .progress),
//                                               ),
//                                               errorWidget:
//                                                   (context, url, error) =>
//                                                       Icon(Icons.error),
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     );
//                                   },
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         border: Border.all(width: 1)),
//                                     height: MediaQuery.of(context).size.height *
//                                         0.1,
//                                     width: MediaQuery.of(context).size.height *
//                                         0.14,
//                                     child: CachedNetworkImage(
//                                       imageUrl:
//                                           '${widget.list_widget['url'].toString()}',
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ])
//                           : Container(
//                               decoration:
//                                   BoxDecoration(border: Border.all(width: 2)),
//                               height: MediaQuery.of(context).size.height * 0.3,
//                               width: double.infinity,
//                               child: Image.asset('assets/images/noimage.png'),
//                             ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 20, right: 20),
//                         child: Container(
//                           height: MediaQuery.of(context).size.height * 0.26,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                               color: Color.fromARGB(255, 165, 200, 229),
//                               borderRadius: BorderRadius.circular(10)),
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 10, bottom: 10),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'ID User :',
//                                       style: TextStyle(
//                                           fontSize: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.022,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text(
//                                       'Email :',
//                                       style: TextStyle(
//                                           fontSize: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.022,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text(
//                                       'UseName:',
//                                       style: TextStyle(
//                                           fontSize: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.022,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text(
//                                       'Phone :',
//                                       style: TextStyle(
//                                           fontSize: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.022,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text(
//                                       'Gender :',
//                                       style: TextStyle(
//                                           fontSize: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.022,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       '${widget.list_widget['id']}',
//                                       style: TextStyle(
//                                           fontSize: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.022,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text(
//                                       '${widget.list_widget['email']}',
//                                       style: TextStyle(
//                                           fontSize: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.022,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text(
//                                       '${widget.list_widget['username']}',
//                                       style: TextStyle(
//                                           fontSize: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.022,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text(
//                                       '${widget.list_widget['tel_num']}',
//                                       style: TextStyle(
//                                           fontSize: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.022,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text(
//                                       '${widget.list_widget['gender']}',
//                                       style: TextStyle(
//                                           fontSize: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.022,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
