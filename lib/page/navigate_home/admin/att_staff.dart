import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:web_admin/components/colors.dart';
import 'package:web_admin/components/waiting.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/appbar.dart';
import '../../../components/DropdownOption.dart';
import '../../../components/colors/colors.dart';
import '../../../components/list_agent.dart';
import '../../../getx/att.dart';
import '../Customer/component/date_customer.dart';
import 'Excel.dart';

class AttTable extends StatefulWidget {
  const AttTable({super.key, required this.listUsers});
  final List listUsers;
  @override
  State<AttTable> createState() => _AttTableState();
}

class _AttTableState extends State<AttTable> {
  List listTitle = [
    {"title": "Add Zone", "type": "add_zone"},
    {"title": "Approver", "type": "approver"},
    {"title": "Comparable", "type": "comparable"},
    {"title": "Market Price and Road", "type": "market_price_road"},
    {"title": "Add VPoint", "type": "add_vpoint"},
    {"title": "Set Admin", "type": "set_admin"},
    {"title": "Property", "type": "property"},
    {"title": "Check DashBord", "type": "check_dashbord"},
    {"title": "Clear All", "type": "blockOption"},
  ];
  late NumberPaginatorController _inputController;
  @override
  void initState() {
    super.initState();
    _inputController = NumberPaginatorController();
  }

  List dataList = [
    {"ID": 1, "Name": "John Doe", "Age": 30},
    {"ID": 2, "Name": "Jane Doe", "Age": 25},
    {"ID": 3, "Name": "Alice Smith", "Age": 28},
  ];
  int agencyId = 0;
  String startDate = "";
  String endDate = "";
  bool isPageChanging = false;
  int page = 1;
  int selectPiganation = 0;
  var sizebox10 = const SizedBox(height: 10);
  @override
  Widget build(BuildContext context) {
    final controllerAtt = Get.put(AttController());
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 40,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 10),
                Obx(
                  () {
                    if (controllerAtt.isagent.value) {
                      return const CircularProgressIndicator();
                    } else if (controllerAtt.listAgency.isEmpty) {
                      return const SizedBox(
                        child: Text(''),
                      );
                    } else {
                      return DropdownAgent(
                        icon: Icons.support_agent_outlined,
                        dataid: "agency",
                        dataname: "username",
                        lists: controllerAtt.listAgency,
                        lable: "Agent",
                        value: (value) {
                          setState(() {
                            agencyId = int.parse(value);
                          });
                        },
                        valuenameback: (value) {},
                      );
                    }
                  },
                ),
                const SizedBox(width: 10),
                DateExpaned(
                    value: (value) {
                      setState(() {
                        startDate = value;
                      });
                    },
                    filedname: "Start"),
                const SizedBox(width: 10),
                DateExpaned(
                    value: (value) {
                      setState(() {
                        endDate = value;
                      });
                    },
                    filedname: "End"),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    controllerAtt.attController(agencyId, startDate, endDate);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5), color: appback),
                    height: 40,
                    width: 80,
                    child: Icon(
                      Icons.search,
                      size: 30,
                      color: whileColors,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Obx(
                () {
                  if (controllerAtt.isAtt.value) {
                    return const Center(child: WaitingFunction());
                  } else if (controllerAtt.listAtt.isEmpty) {
                    return const SizedBox();
                  } else {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: controllerAtt.listAtt.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                margin:
                                    const EdgeInsets.only(right: 15, left: 15),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        width: 1, color: greyColorNolots)),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        textsB('No.${index + 1}'),
                                        const SizedBox(width: 20),
                                        ExcelExporterPage(
                                          list: controllerAtt.listAtt,
                                          name: widget.listUsers[0]['username']
                                              .toString(),
                                        )
                                      ],
                                    ),
                                    sizebox10,
                                    textsB(
                                        'Name : ${controllerAtt.listAtt[index]['name']}'),
                                    sizebox10,
                                    texts(
                                        'Time : ${controllerAtt.listAtt[index]['time_table']}'),
                                    sizebox10,
                                    texts(
                                        'Date Work : ${controllerAtt.listAtt[index]['date_work'] ?? "N/A"}'),
                                    sizebox10,
                                    Row(
                                      children: [
                                        textsB(
                                            'Check In : ${controllerAtt.listAtt[index]['clock_in'] ?? "N/A"}'),
                                        const SizedBox(width: 20),
                                        textsB(
                                            'Check Out : ${controllerAtt.listAtt[index]['clock_out'] ?? "N/A"}'),
                                      ],
                                    ),
                                    sizebox10,
                                    texts(
                                        'Address : ${controllerAtt.listAtt[index]['address']}'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, top: 20),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(width: 0.2, color: greyColor)),
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: NumberPaginator(
                                      controller: _inputController,
                                      numberPages: controllerAtt.lastPage.value,
                                      onPageChange: (int index) async {
                                        if (!isPageChanging) {
                                          isPageChanging =
                                              true; // Prevent multiple calls

                                          if (index > 0) {
                                            page = index + 1;
                                            selectPiganation = index;
                                          }
                                          await controllerAtt.attController(
                                              agencyId, startDate, endDate);
                                          Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            isPageChanging =
                                                false; // Reset flag after execution
                                          });
                                        }
                                      },
                                      initialPage: selectPiganation,
                                      config: NumberPaginatorUIConfig(
                                        buttonShape: BeveledRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(1),
                                        ),
                                        buttonUnselectedForegroundColor:
                                            blackColor,
                                        buttonUnselectedBackgroundColor:
                                            whiteNotFullColor,
                                        buttonSelectedForegroundColor:
                                            whiteColor,
                                        buttonSelectedBackgroundColor: appback,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        )
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget texts(String title) {
    return Text(
      title,
      style: TextStyle(color: greyColor, fontSize: 14),
    );
  }

  Widget textsB(String title) {
    return Text(
      title,
      style: TextStyle(
          color: greyColor, fontSize: 14, fontWeight: FontWeight.bold),
    );
  }
}
