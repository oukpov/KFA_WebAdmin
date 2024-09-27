// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:number_paginator/number_paginator.dart';

// import '../../../components/colors.dart';
// import '../../../getx/component/getx._snack.dart';
// import '../../../getx/submit_agent/agent_admin.dart';
// import '../../../screen/Property/FirstProperty/component/Colors/appbar.dart';

// class ListSubmitAdmin extends StatefulWidget {
//   const ListSubmitAdmin({
//     super.key,
//     required this.device,
//     required this.listUser,
//   });
//   final String device;
//   final List listUser;

//   @override
//   State<ListSubmitAdmin> createState() => _ListSubmitAdminState();
// }

// class _ListSubmitAdminState extends State<ListSubmitAdmin> {
//   @override
//   void initState() {
//     super.initState();
//     _inputController = NumberPaginatorController();
//   }

//   List listPage = [
//     {"page": 10},
//     {"page": 20},
//     {"page": 40},
//     {"page": 60},
//     {"page": 80},
//     {"page": 100},
//   ];
//   late NumberPaginatorController _inputController;
//   ListAgent listAgent = ListAgent();

//   double fontTitle = 13;
//   double fontvalue = 13;
//   var sizeH = const SizedBox(height: 6);
//   int countData = 0;
//   String documentId = '';
//   String searchQuery = '';
//   int page = 1;
//   int perPage = 10;
//   int lastpage = 1;
//   Component component = Component();
//   @override
//   Widget build(BuildContext context) {
//     listAgent = Get.put(ListAgent());
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         children: [
//           SizedBox(child: Obx(
//             () {
//               if (listAgent.isAgent.value) {
//                 return SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.75,
//                   width: double.infinity,
//                   child: const Center(child: CircularProgressIndicator()),
//                 );
//               } else if (listAgent.listAgentModel.isEmpty) {
//                 return SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.75,
//                   width: double.infinity,
//                 );
//               } else {
//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   setState(() {
//                     lastpage = listAgent.lastPage.value;
//                   });
//                 });
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.75,
//                       width: double.infinity,
//                       child: ListView.builder(
//                         itemCount: listAgent.listAgentModel.length,
//                         itemBuilder: (context, index) {
//                           return InkWell(
//                             onTap: () async {
//                               await listAgent.checkID(
//                                   context,
//                                   listAgent.listAgentModel,
//                                   index,
//                                   perPage,
//                                   page,
//                                   widget.listUser);
//                             },
//                             child: Column(
//                               children: [
//                                 Container(
//                                   height: 110,
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: (listAgent.listAgentModel[index]
//                                                 ['verbal_published'] ==
//                                             3
//                                         ? const Color.fromARGB(
//                                             255, 248, 214, 214)
//                                         : whiteColor),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         right: 15,
//                                         left: 15,
//                                         top: 10,
//                                         bottom: 10),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Icon(Icons.storage_rounded,
//                                                 color: greyColorNolot,
//                                                 size: 40),
//                                             const SizedBox(width: 20),
//                                             Row(
//                                               children: [
//                                                 Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     txtFieldTitle('ID'),
//                                                     sizeH,
//                                                     txtFieldTitle('Name'),
//                                                     sizeH,
//                                                     txtFieldTitle('Date'),
//                                                     sizeH,
//                                                     txtFieldTitle('Verify by'),
//                                                   ],
//                                                 ),
//                                                 const SizedBox(width: 10),
//                                                 Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     txtFieldValue(listAgent
//                                                         .listAgentModel[index]
//                                                             ['verbal_id']
//                                                         .toString()),
//                                                     sizeH,
//                                                     txtFieldValue(
//                                                         "${listAgent.listAgentModel[index]['username'] ?? ""}"),
//                                                     sizeH,
//                                                     txtFieldValue(listAgent
//                                                         .listAgentModel[index]
//                                                             ['verbal_date']
//                                                         .toString()),
//                                                     sizeH,
//                                                     txtFieldValues((listAgent
//                                                                         .listAgentModel[
//                                                                     index][
//                                                                 'verbal_published'] ==
//                                                             3)
//                                                         ? "wating agent approve"
//                                                         : "${listAgent.listAgentModel[index]['agenttype_name'] ?? "Approved!"}"),
//                                                   ],
//                                                 )
//                                               ],
//                                             ),
//                                             const Spacer(),
//                                             (listAgent.listAgentModel[index]
//                                                         ['verbal_published'] ==
//                                                     3)
//                                                 ? Container(
//                                                     height: 30,
//                                                     width: 75,
//                                                     alignment: Alignment.center,
//                                                     decoration: BoxDecoration(
//                                                         color: whiteColor,
//                                                         border: Border.all(
//                                                             width: 1),
//                                                         borderRadius:
//                                                             const BorderRadius
//                                                                     .only(
//                                                                 topRight: Radius
//                                                                     .circular(
//                                                                         20),
//                                                                 bottomLeft: Radius
//                                                                     .circular(
//                                                                         20))),
//                                                     child: const Text(
//                                                       'Pending',
//                                                       style: TextStyle(
//                                                           color: Colors.red,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           fontSize: 14),
//                                                     ),
//                                                   )
//                                                 : Text(
//                                                     'Approved',
//                                                     style: TextStyle(
//                                                         color: greyColorNolot,
//                                                         fontSize: 14),
//                                                   ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                     padding: const EdgeInsets.only(
//                                         right: 15, left: 15),
//                                     child: Divider(height: 2, color: greyColor))
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 );
//               }
//             },
//           )),
//           Padding(
//             padding: const EdgeInsets.only(right: 10, left: 10, top: 20),
//             child: Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(width: 0.2, color: greyColor)),
//                 height: 40,
//                 width: MediaQuery.of(context).size.width,
//                 child: Row(
//                   children: [
//                     SizedBox(
//                         height: 50,
//                         width: 70,
//                         child: SizedBox(
//                           height: 40,
//                           child: DropdownButtonFormField<String>(
//                             isExpanded: true,
//                             onChanged: (newValue) async {
//                               setState(() {
//                                 perPage = int.parse(newValue ?? '0');
//                               });
//                               await listAgent.listAgent(perPage, page);
//                             },
//                             items: listPage
//                                 .map<DropdownMenuItem<String>>(
//                                   (value) => DropdownMenuItem<String>(
//                                     value: value["page"].toString(),
//                                     child: Text(
//                                       value["page"].toString(),
//                                       style: const TextStyle(fontSize: 12),
//                                     ),
//                                   ),
//                                 )
//                                 .toList(),
//                             icon: const Icon(Icons.arrow_drop_down,
//                                 color: kImageColor),
//                             decoration: InputDecoration(
//                               fillColor: kwhite,
//                               filled: true,
//                               contentPadding: const EdgeInsets.symmetric(
//                                   vertical: 8, horizontal: 10),
//                               labelText: "Page",
//                               hintText: perPage.toString(),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: const BorderSide(
//                                     color: kPrimaryColor, width: 1),
//                                 borderRadius: BorderRadius.circular(5.0),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: const BorderSide(
//                                   width: 1,
//                                   color: kPrimaryColor,
//                                 ),
//                                 borderRadius: BorderRadius.circular(5.0),
//                               ),
//                             ),
//                           ),
//                         )),
//                     Expanded(
//                       flex: 9,
//                       child: NumberPaginator(
//                         controller: _inputController,
//                         numberPages: lastpage,
//                         onPageChange: (int index) async {
//                           setState(() {
//                             page = index + 1;
//                           });
//                           await listAgent.listAgent(perPage, page);
//                         },
//                         initialPage: 0,
//                         config: NumberPaginatorUIConfig(
//                           buttonShape: BeveledRectangleBorder(
//                             borderRadius: BorderRadius.circular(1),
//                           ),
//                           buttonUnselectedForegroundColor: blackColor,
//                           buttonUnselectedBackgroundColor: whiteNotFullColor,
//                           buttonSelectedForegroundColor: whiteColor,
//                           buttonSelectedBackgroundColor: appback,
//                         ),
//                       ),
//                     ),
//                   ],
//                 )),
//           )
//         ],
//       ),
//     );
//   }

//   Widget txtFieldTitle(title) {
//     return Text("$title",
//         style: TextStyle(
//             color: const Color.fromARGB(255, 143, 140, 140),
//             fontWeight: FontWeight.bold,
//             fontSize: fontTitle));
//   }

//   Widget txtFieldValue(value) {
//     return Text(" :  $value",
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontvalue));
//   }

//   Widget txtFieldValues(value) {
//     return Text(" :  $value",
//         style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: fontvalue,
//             color: Colors.red));
//   }
// }
