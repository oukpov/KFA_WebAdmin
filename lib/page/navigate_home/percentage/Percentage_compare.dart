import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_admin/components/colors.dart';
import 'package:web_admin/components/colors/colors.dart';
import 'package:web_admin/components/waiting.dart';
import 'package:web_admin/getx/percentage/controller.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/appbar.dart';

import '../../../components/DropdownOption.dart';
import '../Customer/component/date_customer_cotroller.dart';

class PercentageClass extends StatefulWidget {
  const PercentageClass({super.key, required this.listUsers});
  final List listUsers;
  @override
  State<PercentageClass> createState() => _PercentageClassState();
}

class _PercentageClassState extends State<PercentageClass> {
  Future<void> _loadStringList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      listagentData = prefs.getStringList('agentlist') ?? [];

      listagents = listagentData
          .map((item) => json.decode(item))
          .cast<Map<String, dynamic>>()
          .toList();
    });

    if (listagentData.isEmpty) {
      agentList();
    } else {
      for (int i = 0; i < listagents.length; i++) {
        listvalueModel.add(listagents[i]);
      }
    }
  }

  bool switchbt = false;
  List<Map<dynamic, dynamic>> listvalueModel = [];
  List listagents = [];
  List<String> listagentData = [];
  Future<void> agentList() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/agent/list',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = response.data;
      setState(() {
        listagentData = responseData.map((item) => json.encode(item)).toList();
        agentListlocal(listagentData);
      });
    }
  }

  // List<Map<dynamic, dynamic>> listCommuneModel = [];
  // List listCommunes = [];
  // List<String> listCommuneData = [];
  // bool isCommune = false;

  String communeName = "";
  String agency = "";
  agentListlocal(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('agentlist', list);
    setState(() {
      listagentData = list;
      listagents = list
          .map((item) => json.decode(item))
          .cast<Map<String, dynamic>>()
          .toList();
      for (int i = 0; i < listagents.length; i++) {
        listvalueModel.add(listagents[i]);
      }
    });
  }

  late NumberPaginatorController _inputController;
  List<Map<dynamic, dynamic>> listCommuneModel = [];
  List listCommunes = [];
  List<String> listCommuneData = [];
  bool isCommune = false;
  Future<void> percentageMethod(String agencyID) async {
    setState(() {
      listCommuneModel.clear();
      listCommunes.clear();
    });
    try {
      setState(() {
        isCommune = true;
      });
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({"comparabl_user": agencyID});
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/fetchCwCM/commune',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        setState(() {
          listCommunes = response.data;

          for (int i = 0; i < listCommunes.length; i++) {
            listCommuneModel.add(listCommunes[i]);
          }
        });
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    } finally {
      setState(() {
        isCommune = false;
      });
    }
  }

  @override
  void initState() {
    _loadStringList();
    _inputController = NumberPaginatorController();
    super.initState();
  }

  int page = 1;
  bool isPageChanging = false;
  int selectPiganation = 0;
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  bool typeListing = false;
  int ministry = 0;
  TextEditingController agenttypeCon = TextEditingController();
  TextEditingController communeCon = TextEditingController();
  TextEditingController percentageCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PercentageController());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20),
              height: 60,
              width: double.infinity,
              color: appback,
              child: Row(
                children: [
                  !typeListing
                      ? Expanded(
                          child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownOption(
                                icon: Icons.support_agent_outlined,
                                dataid: "agenttype_id",
                                dataname: "agenttype_name",
                                listData: listvalueModel,
                                lable: "Agent",
                                value: (value) {
                                  setState(() {
                                    agency = value;
                                  });
                                  percentageMethod(agency);
                                },
                                valuenameback: (value) {},
                              ),
                            ),
                            if (isCommune == false && listCommuneModel.isEmpty)
                              const SizedBox()
                            else if (isCommune == true)
                              const Center(child: WaitingFunction())
                            else if (listCommuneModel.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownOption(
                                  icon: Icons.map_outlined,
                                  dataid: "commune",
                                  dataname: "commune",
                                  listData: listCommuneModel,
                                  lable: "Commune",
                                  value: (value) {
                                    setState(() {
                                      communeName = value;
                                    });
                                  },
                                  valuenameback: (value) {},
                                ),
                              ),
                            const SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: whileColors),
                              height: 40,
                              width: 130,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Ministry\t\t',
                                    style: TextStyle(color: greyColor),
                                  ),
                                  Switch(
                                    value: switchbt,
                                    onChanged: (value) async {
                                      setState(() {
                                        switchbt = !switchbt;
                                        if (switchbt == true) {
                                          ministry = 1;
                                        } else {
                                          ministry = 0;
                                        }
                                      });
                                    },
                                    activeColor: blueColor,
                                    inactiveThumbColor: greyColorNolots,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            Obx(() {
                              if (controller.isPercent.value) {
                                return const CircularProgressIndicator();
                              } else if (controller
                                  .listPercentageList.isEmpty) {
                                return const SizedBox();
                              } else {
                                return CircleAvatar(
                                  radius: 25,
                                  backgroundColor: whileColors,
                                  child: Center(
                                    child: Text(
                                      "${controller.loardings.toString()}%",
                                      style: TextStyle(
                                          color: colorsRed,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              }
                            }),
                            const SizedBox(width: 10),
                            Obx(
                              () {
                                if (controller.isPercent.value) {
                                  return const WaitingFunction();
                                } else if (controller
                                    .listPercentageList.isEmpty) {
                                  return const SizedBox();
                                } else {
                                  return SizedBox(
                                    height: 40,
                                    width: 170,
                                    child: TextFormField(
                                      validator: (value) {
                                        return null;
                                      },
                                      controller: percentageCon,
                                      keyboardType: TextInputType.number,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 5),
                                        prefixIcon: const Icon(
                                          Icons.percent,
                                          color: kImageColor,
                                          size: 20,
                                        ),
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              AwesomeDialog(
                                                width: 400,
                                                context: context,
                                                dialogType: DialogType.question,
                                                animType: AnimType.rightSlide,
                                                headerAnimationLoop: false,
                                                title:
                                                    'Do you want to up (${percentageCon.text}%) for Comparable in ($communeName)',
                                                // desc: "",
                                                btnOkOnPress: () async {
                                                  controller.countPercentage(
                                                      widget.listUsers[0]
                                                              ['agency']
                                                          .toString(),
                                                      percentageCon.text,
                                                      communeName,
                                                      controller.counts.value,
                                                      controller
                                                          .listPercentageList);
                                                  // print(data[index].toString());
                                                },
                                                btnCancelOnPress: () {},
                                                btnCancelColor: greyColorNolot,
                                                btnOkColor: greyColorNolot,
                                              ).show();
                                              // controller.updateMethod(
                                              //     '12436238', '10000', percentageCon.text);
                                            },
                                            icon: Icon(
                                              Icons.arrow_circle_up_rounded,
                                              color: colorsRed,
                                            )),
                                        hintText: 'Percentage',
                                        hintStyle:
                                            TextStyle(color: greyColorNolots),
                                        fillColor: kwhite,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: kPrimaryColor, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1, color: kPrimaryColor),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(width: 20),
                            InkWell(
                              onTap: () {
                                controller.percentageMethod(
                                    communeName, agency, ministry.toString());
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: whileColors,
                                child: Icon(
                                  Icons.search,
                                  color: blackColor,
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ))
                      : Expanded(
                          child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownOption(
                                icon: Icons.support_agent_outlined,
                                dataid: "agenttype_id",
                                dataname: "agenttype_name",
                                listData: listvalueModel,
                                lable: "Agent",
                                value: (value) {
                                  setState(() {
                                    // comparableUser = int.parse(value);
                                    // agenttypeid = int.parse(value);
                                  });
                                },
                                valuenameback: (value) {},
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DateExpanedController(
                                  todate: startDate,
                                  value: (value) {
                                    setState(() {
                                      startDate.text = value;
                                    });
                                  },
                                  filedname: "Start"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DateExpanedController(
                                  todate: endDate,
                                  value: (value) {
                                    setState(() {
                                      endDate.text = value;
                                    });
                                  },
                                  filedname: "End"),
                            ),
                            const SizedBox(width: 20),
                            InkWell(
                              onTap: () async {
                                // controller.listPercentage();
                                await controller.listPercentage(
                                    page, startDate.text, endDate.text);
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: whileColors,
                                child: Icon(
                                  Icons.search,
                                  color: blackColor,
                                ),
                              ),
                            ),
                          ],
                        )),
                  InkWell(
                    onTap: () {
                      setState(() {
                        typeListing = !typeListing;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: whileColors,
                          border: Border.all(width: 0.5, color: blueColor)),
                      height: 40,
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            !typeListing ? 'History\t\t' : 'Percentage\t\t',
                            style: TextStyle(
                                color: greyColor,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.history_rounded,
                            color: greyColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            if (!typeListing)
              Expanded(child: Obx(() {
                if (controller.isPercent.value) {
                  return const WaitingFunction();
                } else if (controller.listPercentageList.isEmpty) {
                  return const SizedBox();
                } else {
                  return Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 20),
                            itemCount: controller.listPercentageList.length,
                            itemBuilder: (context, index) => Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(
                                  bottom: 15, right: 10, left: 15),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: greyColorNolots),
                                  borderRadius: BorderRadius.circular(5),
                                  color: whileColors),
                              width: double.infinity,
                              child: Wrap(
                                spacing: 15, // Adds spacing between elements
                                runSpacing:
                                    10, // Adds spacing between wrapped lines
                                children: [
                                  Text('No.${index + 1}'),
                                  Text(
                                      'ComparableID : ${controller.listPercentageList[index]['comparable_id']}'),
                                  Text(
                                    'Price : \$${controller.listPercentageList[index]['comparable_adding_price']}',
                                    style: TextStyle(color: redColors),
                                  ),
                                  Text(
                                      'Commune : ${controller.listPercentageList[index]['commune']}'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   height: 50,
                      //   width: double.infinity,
                      //   color: redColors,
                      // )
                    ],
                  );
                }
              }))
            else
              Expanded(child: Obx(() {
                if (controller.isPercents.value) {
                  return const WaitingFunction();
                } else if (controller.listPercentModel.isEmpty) {
                  return const SizedBox();
                } else {
                  return Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 20),
                            itemCount: controller.listPercentModel.length,
                            itemBuilder: (context, index) => Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(
                                  bottom: 15, right: 10, left: 15),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: greyColorNolots),
                                  borderRadius: BorderRadius.circular(5),
                                  color: whileColors),
                              width: double.infinity,
                              child: Wrap(
                                spacing: 15, // Adds spacing between elements
                                runSpacing:
                                    10, // Adds spacing between wrapped lines
                                children: [
                                  Text('No.${index + 1}'),
                                  Text(
                                      'Commune : ${controller.listPercentModel[index]['commune_name']}'),
                                  Text(
                                    'percentage : ${controller.listPercentModel[index]['percentage']}%',
                                    style: TextStyle(color: redColors),
                                  ),
                                  Text(
                                      'Date : ${controller.listPercentModel[index]['date_percentage']}'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 20),
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
                                    numberPages: controller.lastPage.value,
                                    onPageChange: (int index) async {
                                      if (!isPageChanging) {
                                        isPageChanging =
                                            true; // Prevent multiple calls

                                        setState(() {
                                          page = index + 1;
                                          selectPiganation = index;
                                        });
                                        await controller.listPercentage(
                                            page, startDate.text, endDate.text);
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
                                        borderRadius: BorderRadius.circular(1),
                                      ),
                                      buttonUnselectedForegroundColor:
                                          blackColor,
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
                  );
                }
              }))
          ],
        ),
      ),
    );
  }
}
