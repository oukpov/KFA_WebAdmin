import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/components/colors.dart';
import 'package:web_admin/components/waiting.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/appbar.dart';
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
  void allowOption() async {}
  @override
  Widget build(BuildContext context) {
    final allowAgent = Get.put(AllowAgent());
    return Obx(
      () {
        if (allowAgent.isAgent.value) {
          return const WaitingFunction();
        } else if (allowAgent.listAgent.isEmpty) {
          return const SizedBox();
        } else {
          return ListView.builder(
            itemCount: allowAgent.listAgent.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                margin: const EdgeInsets.only(right: 15, left: 15),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1)),

                width: double.infinity,
                // color: redColors,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          style: TextStyle(color: blackColor, fontSize: 15),
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
                        for (int i = 0; i < listTitle.length; i++)
                          SizedBox(
                            height: 40,
                            width: 250,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'No.${i + 1} ',
                                  style: TextStyle(
                                      color: blackColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '(${listTitle[i]['title']})',
                                  style: TextStyle(
                                    color: greyColorNolot,
                                  ),
                                ),
                                Switch(
                                  value: (int.tryParse(allowAgent
                                                  .listAgent[index]
                                                      [listTitle[i]['type']]
                                                  ?.toString() ??
                                              '0') ==
                                          1)
                                      ? true
                                      : false,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      if (allowAgent.listAgent[index]
                                              [listTitle[i]['type']] ==
                                          '0') {
                                        allowAgent.listAgent[index]
                                            [listTitle[i]['type']] = '1';
                                        allowAgent.allowAgent(
                                            allowAgent.listAgent,
                                            1,
                                            listTitle[i]['type'],
                                            index);
                                      } else {
                                        allowAgent.listAgent[index]
                                            [listTitle[i]['type']] = '0';
                                        allowAgent.allowAgent(
                                            allowAgent.listAgent,
                                            0,
                                            listTitle[i]['type'],
                                            index);
                                      }
                                      if (listTitle[i]['type'] ==
                                          "blockOption") {
                                        for (var item in listTitle) {
                                          allowAgent.listAgent[index]
                                              [item['type']] = '0';
                                        }
                                      }
                                    });
                                  },
                                  activeColor: appback,
                                  activeTrackColor:
                                      const Color.fromARGB(255, 20, 3, 147),
                                  inactiveThumbColor: Colors.grey,
                                  inactiveTrackColor: Colors.grey.shade400,
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
          );
        }
      },
    );
  }
}
