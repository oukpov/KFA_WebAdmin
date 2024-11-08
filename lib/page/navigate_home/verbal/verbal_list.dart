import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:web_admin/components/colors.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/appbar.dart';

import '../../../components/colors/colors.dart';
import '../../../getx/verbal/verbal_agent.dart';
import '../Approvel/component/pdf.dart';

class VerbalList extends StatefulWidget {
  const VerbalList({super.key, required this.listUser});
  final List listUser;
  @override
  State<VerbalList> createState() => _VerbalListState();
}

class _VerbalListState extends State<VerbalList> {
  late NumberPaginatorController _inputController;
  int page = 1;
  int perPage = 10;
  @override
  void initState() {
    _inputController = NumberPaginatorController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(VerbalAgents(iduser: widget.listUser[0]['agency'].toString()));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appback,
        centerTitle: true,
        title: Text(
          "Verbal List ${widget.listUser[0]['agency'].toString()}",
          style: TextStyle(color: whiteColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () {
                if (controller.isVerbalAgent.value) {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.85,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Center(child: CircularProgressIndicator()),
                        ],
                      ));
                } else if (controller.listVerbalAgent.isEmpty) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.85,
                    width: double.infinity,
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.85,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: controller.listVerbalAgent.length,
                      itemBuilder: (context, index) =>
                          cards(index, controller.listVerbalAgent),
                    ),
                  );
                }
              },
            ),
            if (controller.listVerbalAgent.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 20),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 0.2, color: greyColor)),
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        SizedBox(
                            height: 50,
                            width: 70,
                            child: SizedBox(
                              height: 40,
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                onChanged: (newValue) async {
                                  setState(() {
                                    perPage = int.parse(newValue ?? '0');
                                  });
                                },
                                items: controller.listVerbalAgent
                                    .map<DropdownMenuItem<String>>(
                                      (value) => DropdownMenuItem<String>(
                                        value: value["page"].toString(),
                                        child: Text(
                                          value["page"].toString(),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                icon: const Icon(Icons.arrow_drop_down,
                                    color: kImageColor),
                                decoration: InputDecoration(
                                  fillColor: kwhite,
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
                                  labelText: "Page",
                                  hintText: controller.perPage.value.toString(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: kPrimaryColor, width: 1),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: kPrimaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            )),
                        Expanded(
                          flex: 9,
                          child: NumberPaginator(
                            controller: _inputController,
                            numberPages: controller.lastPage.value,
                            onPageChange: (int index) async {
                              setState(() {
                                page = index + 1;
                              });
                            },
                            initialPage: 0,
                            config: NumberPaginatorUIConfig(
                              buttonShape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(1),
                              ),
                              buttonUnselectedForegroundColor: blackColor,
                              buttonUnselectedBackgroundColor:
                                  whiteNotFullColor,
                              buttonSelectedForegroundColor: whiteColor,
                              buttonSelectedBackgroundColor: appback,
                            ),
                          ),
                        ),
                      ],
                    )),
              )
          ],
        ),
      ),
    );
  }

  Widget cards(int index, List list) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          height: 200,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              color: const Color.fromARGB(217, 255, 255, 255),
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Verbal ID',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'ReferrentN',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        // SizedBox(height: 2),
                        // Text(
                        //   'Bank',
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //     fontSize: 12,
                        //   ),
                        // ),
                        // SizedBox(height: 2),
                        // Text(
                        //   'Bank Branch',
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //     fontSize: 12,
                        //   ),
                        // ),
                        // SizedBox(height: 2),
                        // Text(
                        //   'Property Type',
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //     fontSize: 12,
                        //   ),
                        // ),
                        SizedBox(height: 2),
                        Text(
                          'Date',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " : ${list[index]['verbal_id']}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          " : ${list[index]['referrenceN'] ?? "N/A"}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 2),
                        // Text(
                        //   " : ${list[index]['bank_name'] ?? "N/A"}",
                        //   style: const TextStyle(
                        //     color: Colors.black,
                        //     fontSize: 12,
                        //     overflow: TextOverflow.ellipsis,
                        //   ),
                        // ),
                        // const SizedBox(height: 2),
                        // Text(
                        //   " : ${list[index]['bank_branch_name'] ?? "N/A"}",
                        //   style: const TextStyle(
                        //     color: Colors.black,
                        //     fontSize: 12,
                        //     overflow: TextOverflow.ellipsis,
                        //   ),
                        // ),
                        // const SizedBox(height: 2),
                        // Text(
                        //   " : ${list[index]['property_type_name'] ?? "N/A"}",
                        //   style: const TextStyle(
                        //     color: Colors.black,
                        //     fontSize: 12,
                        //     overflow: TextOverflow.ellipsis,
                        //   ),
                        // ),
                        const SizedBox(height: 2),
                        Text(
                          " : ${list[index]['verbal_created_date'] ?? "N/A"}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 150,
                              child: Image.asset("assets/images/GoogleMap.png"),
                              // child: FadeInImage.assetNetwork(
                              //   fit: BoxFit.cover,
                              //   placeholderFit: BoxFit.contain,
                              //   placeholder: 'assets/earth.gif',
                              //   image:
                              //       "https://maps.googleapis.com/maps/api/staticmap?center=${(list[index]["latlong_log"] > list[index]["latlong_la"]) ? "${list[index]["latlong_la"]},${list[index]["latlong_log"]}" : "${list[index]["latlong_log"]},${list[index]["latlong_la"]}"}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${(list[index]["latlong_log"] > list[index]["latlong_la"]) ? "${list[index]["latlong_la"]},${list[index]["latlong_log"]}" : "${list[index]["latlong_log"]},${list[index]["latlong_la"]}"}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8",
                              // ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${list[index]['verbal_address'] ?? "N/A"}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (list[index]["verbal_user"] ==
                            widget.listUser[0]["id"])
                          GFButton(
                            onPressed: () async {
                              // await checkDone.checkAllow();
                              // if (checkDone.checkDoneList[0]['checks']
                              //         .toString() ==
                              //     "1") {
                              //   component.handleTap(
                              //       "Comming Soon!", "System is updating!");
                              // } else {
                              //   showModalBottomSheet(
                              //     backgroundColor: Colors.transparent,
                              //     context: context,
                              //     isScrollControlled: true,
                              //     builder: (BuildContext context) {
                              //       return Padding(
                              //         padding: const EdgeInsets.only(
                              //             left: 50, top: 100),
                              //         child: Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.center,
                              //           children: [
                              //             Container(
                              //               decoration: BoxDecoration(
                              //                   color: whileColors,
                              //                   border: Border.all(width: 1),
                              //                   borderRadius:
                              //                       BorderRadius.circular(10)),
                              //               height: 400,
                              //               width: 400,
                              //               child: Padding(
                              //                 padding: const EdgeInsets.all(10),
                              //                 child: Column(
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.start,
                              //                   children: [
                              //                     const SizedBox(height: 20),
                              //                     Row(
                              //                       children: [
                              //                         Text(
                              //                           "Submit To Agent Check",
                              //                           style: TextStyle(
                              //                               color: greyColor,
                              //                               fontSize: 15,
                              //                               fontWeight:
                              //                                   FontWeight
                              //                                       .bold),
                              //                         ),
                              //                         const Spacer(),
                              //                         IconButton(
                              //                             onPressed: () {
                              //                               Navigator.pop(
                              //                                   context);
                              //                             },
                              //                             icon: Icon(
                              //                               Icons
                              //                                   .dangerous_outlined,
                              //                               color: greyColor,
                              //                             ))
                              //                       ],
                              //                     ),
                              //                     const SizedBox(height: 10),
                              //                     SizedBox(
                              //                       height: 250,
                              //                       width: 400,
                              //                       child: TextFormField(
                              //                         onChanged: (value) {
                              //                           setState(() {
                              //                             comment = value;
                              //                           });
                              //                         },
                              //                         maxLines: 10,
                              //                         decoration:
                              //                             InputDecoration(
                              //                           border: OutlineInputBorder(
                              //                               borderRadius:
                              //                                   BorderRadius
                              //                                       .circular(
                              //                                           10),
                              //                               borderSide: BorderSide(
                              //                                   width: 1.5,
                              //                                   color:
                              //                                       blueColor)),
                              //                           hintText: 'Comment',
                              //                         ),
                              //                       ),
                              //                     ),
                              //                     Row(
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment
                              //                               .center,
                              //                       children: [
                              //                         InkWell(
                              //                           onTap: () {
                              //                             if (list[index][
                              //                                     "approvel"] ==
                              //                                 100) {
                              //                               if (list[index][
                              //                                       "verbal_published"] ==
                              //                                   3) {
                              //                                 component.handleTap(
                              //                                     "Please waiting agent check 1hour/Day",
                              //                                     "");
                              //                               } else {
                              //                                 component.handleTap(
                              //                                     "It have been approved by agent",
                              //                                     "");
                              //                               }
                              //                             } else {
                              //                               AwesomeDialog(
                              //                                 padding:
                              //                                     const EdgeInsets
                              //                                             .only(
                              //                                         right: 30,
                              //                                         left: 30,
                              //                                         bottom:
                              //                                             10,
                              //                                         top: 10),
                              //                                 alignment:
                              //                                     Alignment
                              //                                         .center,
                              //                                 width: 350,
                              //                                 context: context,
                              //                                 dialogType:
                              //                                     DialogType
                              //                                         .question,
                              //                                 animType: AnimType
                              //                                     .rightSlide,
                              //                                 headerAnimationLoop:
                              //                                     false,
                              //                                 title:
                              //                                     "Submit to agent",
                              //                                 desc: "",
                              //                                 btnOkOnPress: () {
                              //                                   submitAgent(
                              //                                       controller.listVerbalAgent,
                              //                                       i);
                              //                                   setState(() {
                              //                                     list[index]
                              //                                         [
                              //                                         'verbal_published'] = 3;
                              //                                   });
                              //                                 },
                              //                                 btnCancelOnPress:
                              //                                     () {},
                              //                               ).show();
                              //                             }
                              //                           },
                              //                           child: Container(
                              //                             alignment:
                              //                                 Alignment.center,
                              //                             height: 35,
                              //                             width: 150,
                              //                             decoration:
                              //                                 BoxDecoration(
                              //                               color: const Color
                              //                                       .fromARGB(
                              //                                   255,
                              //                                   6,
                              //                                   31,
                              //                                   223),
                              //                               border: Border.all(
                              //                                   width: 1,
                              //                                   color: Colors
                              //                                       .black),
                              //                               borderRadius:
                              //                                   BorderRadius
                              //                                       .circular(
                              //                                           5),
                              //                             ),
                              //                             child: const Text(
                              //                               "Submit",
                              //                               style: TextStyle(
                              //                                   fontSize: 14,
                              //                                   color: Colors
                              //                                       .white),
                              //                             ),
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       );
                              //     },
                              //   );
                              // }
                            },
                            text: (list[index]["approvel"] == 100 &&
                                    list[index]["verbal_published"] == 0)
                                ? "Approved ✅"
                                : (list[index]["verbal_published"] == 3)
                                    ? "Padding ⏳"
                                    : "Submit Agent",
                            color: (list[index]["approvel"] == 100 &&
                                    list[index]["verbal_published"] == 0)
                                ? colorsRed
                                : (list[index]["verbal_published"] == 3)
                                    ? greyColorNolots
                                    : const Color.fromARGB(255, 13, 1, 103),
                            icon: Image.asset('assets/images/agent_icon.png',
                                height: 25, fit: BoxFit.fitHeight),
                          )
                        //  GFButton(
                        //   onPressed: () {
                        //     component.handleTap(
                        //         "It have been approved by agent", "");
                        //   },
                        //   text: "Padding",
                        //   color: whiteColor,
                        //   icon: Image.asset('assets/images/agent_icon.png',
                        //       height: 25, fit: BoxFit.fitHeight),
                        // ),
                        ,
                        if (list[index]["verbal_user"] ==
                            widget.listUser[0]["id"])
                          const SizedBox(width: 10),
                        GFButton(
                            onPressed: () {
                              // showModalBottomSheet(
                              //   backgroundColor: Colors.transparent,
                              //   context: context,
                              //   isScrollControlled: true,
                              //   builder: (BuildContext context) {
                              //     return save_image_after_add_verbal(
                              //       check: false,
                              //       listUser: widget.listUser,
                              //       type: (value) {
                              //         setState(() {
                              //           widget.type(value);
                              //         });
                              //       },
                              //       list: controller.listVerbalAgent,
                              //       i: i,
                              //       verbalId: (list[index]["type_value"] == "T")
                              //           ? list[index]["verbal_landid"]
                              //               .toString()
                              //           : list[index]["verbal_land_id"]
                              //               .toString(),
                              //     );
                              //   },
                              // );
                            },
                            text: "Get Image",
                            color: Colors.green,
                            icon: Image.asset(
                              'assets/images/save_image.png',
                              height: 25,
                            )),
                        const SizedBox(width: 10),
                        // if (imagelogo != null)
                        //   PDfButton(
                        //     listUser: widget.listUser,
                        //     position: false,
                        //     type: (value) {},
                        //     title: "",
                        //     check: (value) {
                        //       // setState(() {
                        //       //   check = value;
                        //       // });
                        //     },
                        //     list: list,
                        //     i: i,
                        //     imagelogo: imagelogo,
                        //     iconpdfcolor: Colors.white,
                        //   )
                        // else
                        //   const Center(
                        //     child: CircularProgressIndicator(),
                        //   ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
