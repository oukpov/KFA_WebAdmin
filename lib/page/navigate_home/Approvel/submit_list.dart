import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:web_admin/components/waiting.dart';
import '../../../components/colors.dart';
import '../../../getx/component/getx._snack.dart';
import '../../../getx/submit_agent/agent_admin.dart';
import '../../../screen/Property/FirstProperty/component/Colors/appbar.dart';
import 'component/pdf.dart';
import 'component/save_image_for_Autoverbal.dart';
import 'package:http/http.dart' as http;

class ListSubmitAdmin extends StatefulWidget {
  const ListSubmitAdmin({
    super.key,
    required this.device,
    required this.listUser,
  });
  final String device;
  final List listUser;

  @override
  State<ListSubmitAdmin> createState() => _ListSubmitAdminState();
}

class _ListSubmitAdminState extends State<ListSubmitAdmin> {
  @override
  void initState() {
    super.initState();
    pdfimage();
    _inputController = NumberPaginatorController();
  }

  List listPage = [
    {"page": 10},
    {"page": 20},
    {"page": 40},
    {"page": 60},
    {"page": 80},
    {"page": 100},
  ];
  late NumberPaginatorController _inputController;
  ListAgent listAgent = ListAgent();

  double fontTitle = 13;
  double fontvalue = 13;
  var sizeH = const SizedBox(height: 6);
  int countData = 0;
  String documentId = '';
  String searchQuery = '';
  int page = 1;
  int perPage = 10;
  int lastpage = 1;
  int checkType = 3;
  Component component = Component();
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  var imagelogo;
  List listPDF = [];
  Future<void> pdfimage() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get/pdf/15'));

    if (rs.statusCode == 200) {
      setState(() {
        listPDF = jsonDecode(rs.body);

        if (listPDF.isNotEmpty) {
          imagelogo = listPDF[0]['image'].toString();
        }
      });
    }
  }

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  double heightBox = 40;
  double wtBox = 90;
  @override
  Widget build(BuildContext context) {
    listAgent = Get.put(ListAgent());
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: greyColorNolot),
              borderRadius: BorderRadius.circular(5)),
          // height: 70,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                SizedBox(
                  height: heightBox,
                  width: 300,
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        // searchController.text = value;
                      });
                    },
                    onFieldSubmitted: (value) async {
                      setState(() {
                        if (startDateController.text == "" &&
                            endDateController.text == "") {
                          checkType = 3;
                        }
                        startDateController.clear();
                        endDateController.clear();
                      });
                      await listAgent.listAgent(
                          perPage,
                          page,
                          checkType,
                          startDateController.text,
                          endDateController.text,
                          searchController.text);
                    },
                    decoration: InputDecoration(
                        // icon: Icon(Icons.search, color: greyColor),
                        suffixIcon: IconButton(
                            onPressed: () async {
                              setState(() {
                                if (startDateController.text == "" &&
                                    endDateController.text == "") {
                                  checkType = 3;
                                }
                                startDateController.clear();
                                endDateController.clear();
                              });
                              await listAgent.listAgent(
                                  perPage,
                                  page,
                                  checkType,
                                  startDateController.text,
                                  endDateController.text,
                                  searchController.text);
                            },
                            icon: Icon(
                              Icons.search,
                              color: greyColor,
                            )),
                        hintText: "Search",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 150,
                  height: 40,
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                    controller: startDateController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.calendar_today,
                        color: kImageColor,
                        size: 20,
                      ),
                      labelText: "StartDate",
                      fillColor: kwhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: kPrimaryColor, width: 1.0),
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
                    readOnly: true,
                    onTap: () async {
                      setState(() {
                        checkType = 4;
                      });
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);

                        setState(() {
                          startDateController.text = formattedDate;
                          searchController.clear();
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 150,
                  height: 40,
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                    controller: endDateController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.calendar_today,
                        color: kImageColor,
                        size: 20,
                      ),
                      labelText: "EndDate",
                      fillColor: kwhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: kPrimaryColor, width: 1.0),
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
                    readOnly: true,
                    onTap: () async {
                      setState(() {
                        checkType = 4;
                      });
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);

                        setState(() {
                          endDateController.text = formattedDate;
                          searchController.clear();
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () async {
                    setState(() {
                      checkType = 3;
                      searchController.clear();
                      // changepage();
                    });
                    await listAgent.listAgent(perPage, page, checkType,
                        startDateController.text, endDateController.text, "");
                  },
                  child: SizedBox(
                    height: heightBox,
                    width: wtBox,
                    child: Row(
                      children: [
                        const Text("Padding"),
                        Icon((checkType == 3)
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank)
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () async {
                    setState(() {
                      checkType = 2;
                      searchController.clear();
                      // changepage();
                    });
                    await listAgent.listAgent(perPage, page, checkType,
                        startDateController.text, endDateController.text, "");
                  },
                  child: SizedBox(
                    height: heightBox,
                    width: wtBox,
                    child: Row(
                      children: [
                        const Text("Approved"),
                        Icon((checkType == 2)
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank)
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () async {
                    setState(() {
                      checkType = 1;
                      searchController.clear();
                      // changepage();
                    });
                    await listAgent.listAgent(perPage, page, checkType,
                        startDateController.text, endDateController.text, "");
                  },
                  child: SizedBox(
                    height: heightBox,
                    width: wtBox,
                    child: Row(
                      children: [
                        const Text("All Verbal"),
                        Icon((checkType == 1)
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank)
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () async {
                    setState(() {
                      searchController.clear();
                    });
                    await listAgent.listAgent(perPage, page, checkType,
                        startDateController.text, endDateController.text, "");
                  },
                  child: SizedBox(
                    height: heightBox,
                    width: wtBox,
                    child: Row(
                      children: [
                        const Text("Refresh  "),
                        Image.asset(
                          'assets/images/refresh.png',
                          height: 35,
                          fit: BoxFit.fitHeight,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // const SizedBox(height: 10),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  child: Obx(
                    () {
                      if (listAgent.isAgent.value) {
                        return const SizedBox(
                          width: double.infinity,
                          child: Center(child: WaitingFunction()),
                        );
                      } else if (listAgent.listAgentModel.isEmpty) {
                        return const SizedBox(
                          width: double.infinity,
                        );
                      } else {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            lastpage = listAgent.lastPage.value;
                          });
                        });
                        return ListView.builder(
                          itemCount: listAgent.listAgentModel.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                await listAgent.checkID(
                                    context,
                                    listAgent.listAgentModel,
                                    index,
                                    perPage,
                                    page,
                                    widget.listUser);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 110,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ((int.parse(
                                                  "${listAgent.listAgentModel[index]['VerifyAgent'] ?? 0}") ==
                                              100)
                                          ? whiteColor
                                          : const Color.fromARGB(
                                              255, 213, 213, 217)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15,
                                          left: 15,
                                          top: 10,
                                          bottom: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.storage_rounded,
                                                  color: greyColorNolot,
                                                  size: 40),
                                              const SizedBox(width: 20),
                                              Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      txtFieldTitle('ID'),
                                                      sizeH,
                                                      txtFieldTitle('Name'),
                                                      sizeH,
                                                      txtFieldTitle('Date'),
                                                      sizeH,
                                                      txtFieldTitle(
                                                          'Verify by'),
                                                    ],
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      txtFieldValue(listAgent
                                                          .listAgentModel[index]
                                                              ['verbal_id']
                                                          .toString()),
                                                      sizeH,
                                                      txtFieldValue(
                                                          "${listAgent.listAgentModel[index]['username'] ?? ""}"),
                                                      sizeH,
                                                      txtFieldValue(listAgent
                                                          .listAgentModel[index]
                                                              ['verbal_date']
                                                          .toString()),
                                                      sizeH,
                                                      txtFieldValues((int.parse(
                                                                  "${listAgent.listAgentModel[index]['verbal_published'] ?? 0}") ==
                                                              3)
                                                          ? "wating agent approve"
                                                          : "${listAgent.listAgentModel[index]['agenttype_name'] ?? "Done!"}"),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const Spacer(),
                                              GFButton(
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      context: context,
                                                      isScrollControlled: true,
                                                      builder: (BuildContext
                                                          context) {
                                                        return save_image_after_add_verbal(
                                                          listUser: listAgent
                                                              .listAgentModel,
                                                          check: false,
                                                          type: (value) {},
                                                          list: listAgent
                                                              .listAgentModel,
                                                          i: index,
                                                          verbalId: (listAgent.listAgentModel[
                                                                          index]
                                                                      [
                                                                      "type_value"] ==
                                                                  "T")
                                                              ? listAgent
                                                                  .listAgentModel[
                                                                      index][
                                                                      "verbal_landid"]
                                                                  .toString()
                                                              : listAgent
                                                                  .listAgentModel[
                                                                      index][
                                                                      "verbal_land_id"]
                                                                  .toString(),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  text: "Get Image",
                                                  color: Colors.green,
                                                  icon: Image.asset(
                                                    'assets/images/save_image.png',
                                                    height: 25,
                                                  )),
                                              const SizedBox(width: 10),
                                              if (imagelogo != null)
                                                PDfButton(
                                                  listUser: widget.listUser,
                                                  position: false,
                                                  type: (value) {},
                                                  title: "",
                                                  check: (value) {
                                                    // setState(() {
                                                    //   check = value;
                                                    // });
                                                  },
                                                  list:
                                                      listAgent.listAgentModel,
                                                  i: index,
                                                  imagelogo: imagelogo,
                                                  iconpdfcolor: Colors.white,
                                                )
                                              else
                                                const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              const SizedBox(width: 10),
                                              (int.parse("${listAgent.listAgentModel[index]['VerifyAgent'] ?? 0}") ==
                                                      100)
                                                  ? SizedBox(
                                                      width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Approved',
                                                            style: TextStyle(
                                                                color:
                                                                    greyColorNolot,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .check_box_outlined,
                                                            color: greenColors,
                                                            size: 30,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 30,
                                                      width: 120,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: whiteColor,
                                                          border: Border.all(
                                                              width: 1),
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20),
                                                                  bottomLeft:
                                                                      Radius.circular(
                                                                          20))),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Text(
                                                            'Pending ',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14),
                                                          ),
                                                          Icon(
                                                            Icons.access_time,
                                                            color: greyColor,
                                                            size: 30,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15, left: 15),
                                      child:
                                          Divider(height: 2, color: greyColor))
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
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
                        // SizedBox(
                        //     height: 50,
                        //     width: 70,
                        //     child: SizedBox(
                        //       height: 40,
                        //       child: DropdownButtonFormField<String>(
                        //         isExpanded: true,
                        //         onChanged: (newValue) async {
                        //           setState(() {
                        //             perPage = int.parse(newValue ?? '0');
                        //           });
                        //           await listAgent.listAgent(
                        //               perPage,
                        //               page,
                        //               checkType,
                        //               startDateController.text,
                        //               endDateController.text,
                        //               "");
                        //         },
                        //         items: listPage
                        //             .map<DropdownMenuItem<String>>(
                        //               (value) => DropdownMenuItem<String>(
                        //                 value: value["page"].toString(),
                        //                 child: Text(
                        //                   value["page"].toString(),
                        //                   style: const TextStyle(fontSize: 12),
                        //                 ),
                        //               ),
                        //             )
                        //             .toList(),
                        //         icon: const Icon(Icons.arrow_drop_down,
                        //             color: kImageColor),
                        //         decoration: InputDecoration(
                        //           fillColor: kwhite,
                        //           filled: true,
                        //           contentPadding: const EdgeInsets.symmetric(
                        //               vertical: 8, horizontal: 10),
                        //           labelText: "Page",
                        //           hintText: perPage.toString(),
                        //           focusedBorder: OutlineInputBorder(
                        //             borderSide: const BorderSide(
                        //                 color: kPrimaryColor, width: 1),
                        //             borderRadius: BorderRadius.circular(5.0),
                        //           ),
                        //           enabledBorder: OutlineInputBorder(
                        //             borderSide: const BorderSide(
                        //               width: 1,
                        //               color: kPrimaryColor,
                        //             ),
                        //             borderRadius: BorderRadius.circular(5.0),
                        //           ),
                        //         ),
                        //       ),
                        //     )),
                        Expanded(
                          child: NumberPaginator(
                            controller: _inputController,
                            numberPages: lastpage,
                            onPageChange: (int index) async {
                              setState(() {
                                page = index + 1;
                              });
                              await listAgent.listAgent(
                                  perPage,
                                  page,
                                  checkType,
                                  startDateController.text,
                                  endDateController.text,
                                  "");
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
      ],
    );
  }

  Widget txtFieldTitle(title) {
    return Text("$title",
        style: TextStyle(
            color: const Color.fromARGB(255, 143, 140, 140),
            fontWeight: FontWeight.bold,
            fontSize: fontTitle));
  }

  Widget txtFieldValue(value) {
    return Text(" :  $value",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontvalue));
  }

  Widget txtFieldValues(value) {
    return Text(" :  $value",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontvalue,
            color: Colors.red));
  }
}
