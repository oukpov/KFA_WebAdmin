import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/components/colors.dart';
import 'package:web_admin/components/colors/colors.dart';
import 'package:web_admin/components/waiting.dart';

import '../../../getx/active_users.dart';

class CheckUsers extends StatefulWidget {
  const CheckUsers({super.key});

  @override
  State<CheckUsers> createState() => _CheckUsersState();
}

class _CheckUsersState extends State<CheckUsers> {
  List listTitle = [
    {'title': "Day", "time": 0},
    {'title': "Week", "time": 1},
    {'title': "Month", "time": 2},
    {'title': "Year", "time": 3},
  ];
  String bankName = '';
  int selectIndex = 0;
  int indexs = 0;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ActiveController());
    return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  for (int i = 0; i < listTitle.length; i++)
                    SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  selectIndex = (selectIndex == i) ? -1 : i;
                                  indexs = i;
                                });

                                controller.listActiveMetod(indexs, bankName);
                              },
                              icon: Icon((selectIndex == i)
                                  ? Icons.check_box_outlined
                                  : Icons.check_box_outline_blank)),
                          Text('\t\t${listTitle[i]['title']}\t\t'),
                        ],
                      ),
                    ),
                  Obx(
                    () {
                      if (controller.isdrop.value) {
                        return const WaitingFunction();
                      } else if (controller.listBankDrop.isEmpty) {
                        return const SizedBox();
                      } else {
                        // return Text(controller.listBankDrop.toString());
                        return Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: kPrimaryColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownSearch<Map<dynamic, dynamic>>(
                              items: controller.listBankDrop,
                              compareFn: (item1, item2) {
                                return item1['bank_name'] == item2['bank_name'];
                              },
                              popupProps: PopupProps.menu(
                                isFilterOnline: true,
                                showSearchBox: true,
                                showSelectedItems: true,
                                itemBuilder: (context, item, isSelected) {
                                  return ListTile(
                                    title: Text(item['bank_name'] ?? ''),
                                    selected: isSelected,
                                  );
                                },
                                searchFieldProps: const TextFieldProps(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Search a Property',
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  bankName = value!['bank_name'].toString();
                                });
                                controller.listActiveMetod(
                                  indexs,
                                  value!['bank_name']
                                      .toString(), // Use bank_name
                                );
                                // });
                                // }
                              },
                              selectedItem: const {"bank_name": "Bank"},
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: 'Select one',
                                  labelText: 'Bank',
                                  labelStyle: TextStyle(
                                    color: blueColor,
                                    fontSize: 17,
                                  ),
                                  prefixIcon: const Icon(
                                      Icons.business_outlined,
                                      color: kImageColor),
                                  filled: true,
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: kPrimaryColor, width: 2.0),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: kPrimaryColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: kerror),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 5,
                                      color: kerror,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                              filterFn: (item, filter) {
                                return item['bank_name']
                                        ?.toLowerCase()
                                        .contains(filter.toLowerCase()) ??
                                    false;
                              },
                              itemAsString: (item) => item['bank_name']),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Obx(
              () {
                if (controller.isActive.value) {
                  return const WaitingFunction();
                } else if (controller.listActive.isEmpty) {
                  return const SizedBox();
                } else {
                  return Expanded(
                      child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: whileColors,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            blurRadius: 8,
                                            spreadRadius: 2,
                                            offset: const Offset(4, 2),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 1, color: greyColor)),
                                    height: MediaQuery.of(context).size.height *
                                        0.8,

                                    // width: double.infinity,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.only(top: 10),
                                      itemCount: controller.listActive.length,
                                      itemBuilder: (context, index) =>
                                          Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 10, right: 10, left: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: whileColors,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              blurRadius: 8,
                                              spreadRadius: 2,
                                              offset: const Offset(4, 2),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              'No.${index + 1}\t\t\tName : ',
                                              style: TextStyle(
                                                  color: greyColorNolot),
                                            ),
                                            Text(
                                              '${controller.listActive[index]['username']}',
                                              style: TextStyle(
                                                  color: greenColors,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text('\tOR\t'),
                                            Text(
                                                'Tele : ${controller.listActive[index]['tel_num']}',
                                                style: TextStyle(
                                                    color: greenColors,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const Spacer(),
                                            CircleAvatar(
                                              radius: 5,
                                              backgroundColor: greenColors,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                              const SizedBox(width: 10),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 1, color: greyColor)),
                                    height: MediaQuery.of(context).size.height *
                                        0.8,

                                    // width: double.infinity,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.only(top: 10),
                                      itemCount: controller.listUnActive.length,
                                      itemBuilder: (context, index) =>
                                          Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 10, right: 10, left: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: whileColors,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              blurRadius: 8,
                                              spreadRadius: 2,
                                              offset: const Offset(4, 2),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              'No.${index + 1}\t\t\tName : ',
                                              style: TextStyle(
                                                  color: greyColorNolot),
                                            ),
                                            Text(
                                              '${controller.listUnActive[index]['username']}',
                                              style: TextStyle(
                                                  color: greenColors,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text('\tOR\t'),
                                            Text(
                                                'Tele : ${controller.listUnActive[index]['tel_num']}',
                                                style: TextStyle(
                                                    color: greenColors,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const Spacer(),
                                            CircleAvatar(
                                              radius: 5,
                                              backgroundColor: greyColorNolots,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ));
                }
              },
            )
          ],
        ));
  }
}
