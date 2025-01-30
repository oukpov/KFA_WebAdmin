import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:web_admin/components/colors.dart';
import 'package:web_admin/components/waiting.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/appbar.dart';
import '../../../components/colors/colors.dart';
import '../../../getx/allow_agent.dart';

class AllowOptions extends StatefulWidget {
  const AllowOptions({super.key, required this.listUsers});
  final List listUsers;
  @override
  State<AllowOptions> createState() => _AllowOptionsState();
}

class _AllowOptionsState extends State<AllowOptions> {
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

  TextEditingController controller = TextEditingController();
  bool isPageChanging = false;
  int page = 1;
  int selectPiganation = 0;
  @override
  Widget build(BuildContext context) {
    final allowAgent = Get.put(AllowAgent());
    return SizedBox(
      width: double.infinity,
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
                Container(
                  decoration: BoxDecoration(
                      color: whileColors,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 0.5, color: greyColorNolot)),
                  width: 500,
                  child: TextFormField(
                    controller: controller,
                    onFieldSubmitted: (value) async {
                      isPageChanging = true;
                      await allowAgent.listAgentFunction(
                          page, true, controller.text);
                      Future.delayed(const Duration(milliseconds: 500), () {
                        isPageChanging = false;
                      });
                    },
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: -3),
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      suffixIcon: InkWell(
                        onTap: () async {
                          isPageChanging = true; // Prevent multiple calls
                          await allowAgent.listAgentFunction(
                              page, true, controller.text);
                          Future.delayed(const Duration(milliseconds: 500), () {
                            isPageChanging =
                                false; // Reset flag after execution
                          });
                        },
                        child: Container(
                            height: 40,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: appback,
                              border: Border.all(width: 0.5, color: greyColor),
                            ),
                            child: Icon(
                              Icons.search,
                              color: whiteColor,
                            )),
                      ),
                      icon: const SizedBox(width: 10),
                      suffix: IconButton(
                        onPressed: () async {
                          setState(() {
                            isPageChanging = true; // Prevent multiple calls
                            controller.clear();
                          });
                          await allowAgent.listAgentFunction(page, true, "");
                          Future.delayed(const Duration(milliseconds: 500), () {
                            isPageChanging =
                                false; // Reset flag after execution
                          });
                        },
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: blackColor,
                        ),
                      ),
                      border: InputBorder.none,
                      hintText: '  Search listing here...',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                    onPressed: () async {
                      setState(() {
                        isPageChanging = true;
                        controller.clear();
                      });
                      await allowAgent.listAgentFunction(page, true, "");
                      Future.delayed(const Duration(milliseconds: 500), () {
                        isPageChanging = false;
                      });
                    },
                    icon: const Icon(
                      Icons.refresh,
                      size: 30,
                    ))
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Obx(
                () {
                  if (allowAgent.isAgent.value) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.75,
                        width: double.infinity,
                        child: const WaitingFunction());
                  } else if (allowAgent.listAgent.isEmpty) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      width: double.infinity,
                    );
                  } else {
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: ListView.builder(
                                itemCount: allowAgent.listAgent.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 15, left: 15),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: whiteColor,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(width: 1)),

                                    width: double.infinity,
                                    // color: redColors,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "No.${index + 1} ( ID : ${allowAgent.listAgent[index]['agency']} )",
                                          style: TextStyle(
                                              color: blackColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text(
                                              "Agent's Name : ",
                                              style: TextStyle(
                                                  color: blackColor,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              "${allowAgent.listAgent[index]['username']}",
                                              style: TextStyle(
                                                  color: colorsRed,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Divider(
                                          thickness: 0.8,
                                          color: blackColor,
                                        ),
                                        Wrap(
                                          children: [
                                            for (int i = 0;
                                                i < listTitle.length;
                                                i++)
                                              SizedBox(
                                                height: 40,
                                                width: 250,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'No.${i + 1} ',
                                                      style: TextStyle(
                                                          color: blackColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      '(${listTitle[i]['title']})',
                                                      style: TextStyle(
                                                        color: greyColorNolot,
                                                      ),
                                                    ),
                                                    Switch(
                                                      value: (int.tryParse(allowAgent
                                                                      .listAgent[
                                                                          index]
                                                                          [
                                                                          listTitle[i]
                                                                              [
                                                                              'type']]
                                                                      ?.toString() ??
                                                                  '0') ==
                                                              1)
                                                          ? true
                                                          : false,
                                                      onChanged:
                                                          (bool newValue) {
                                                        // if (allowAgent.listAgent[index]
                                                        //         [listTitle[i]['type']] ==
                                                        //     '0') {
                                                        //   setState(() {
                                                        //     allowAgent.listAgent[index][
                                                        //         listTitle[i]
                                                        //             ['type']] = '1';
                                                        //   });
                                                        //   allowAgent.allowAgent(
                                                        //       allowAgent.listAgent,
                                                        //       1,
                                                        //       listTitle[i]['type'],
                                                        //       index);
                                                        // } else {
                                                        //   setState(() {
                                                        //     allowAgent.listAgent[index][
                                                        //         listTitle[i]
                                                        //             ['type']] = '0';
                                                        //   });
                                                        //   allowAgent.allowAgent(
                                                        //       allowAgent.listAgent,
                                                        //       0,
                                                        //       listTitle[i]['type'],
                                                        //       index);
                                                        // }
                                                        // if (listTitle[i]['type'] ==
                                                        //     "blockOption") {
                                                        //   setState(() {
                                                        //     for (var item in listTitle) {
                                                        //       allowAgent.listAgent[index]
                                                        //           [item['type']] = '0';
                                                        //     }
                                                        //   });
                                                        // }
                                                      },
                                                      activeColor: appback,
                                                      activeTrackColor:
                                                          const Color.fromARGB(
                                                              255, 20, 3, 147),
                                                      inactiveThumbColor:
                                                          Colors.grey,
                                                      inactiveTrackColor:
                                                          Colors.grey.shade400,
                                                    )
                                                  ],
                                                ),
                                              )
                                          ],
                                        )
                                      ],
                                    ),
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
                                    border: Border.all(
                                        width: 0.2, color: greyColor)),
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: NumberPaginator(
                                        controller: _inputController,
                                        numberPages: allowAgent.lastPage.value,
                                        onPageChange: (int index) async {
                                          if (!isPageChanging) {
                                            isPageChanging =
                                                true; // Prevent multiple calls

                                            if (index > 0) {
                                              page = index + 1;
                                              selectPiganation = index;
                                            }
                                            await allowAgent.listAgentFunction(
                                                page, false, "");
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 500), () {
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
                                          buttonSelectedBackgroundColor:
                                              appback,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
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
}
