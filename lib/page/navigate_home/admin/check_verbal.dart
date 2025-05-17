import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_admin/components/colors.dart';
import 'package:web_admin/components/colors/colors.dart';
import 'package:web_admin/components/waiting.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/appbar.dart';
import '../../../Profile/components/Drop_down.dart';
import '../../../components/Excel.dart';
import '../../../components/Excel_verbal.dart';
import '../../../getx/active_users.dart';
import '../../../getx/verbal_checks.dart';
import '../Customer/component/date_customer.dart';
import 'account.dart';

class CheckVerbals extends StatefulWidget {
  const CheckVerbals({super.key});

  @override
  State<CheckVerbals> createState() => _CheckVerbalsState();
}

class _CheckVerbalsState extends State<CheckVerbals> {
  List listTitle = [
    {'title': "No"},
    {'title': "Code"},
    {'title': "UserName"},
    {'title': "Tel Number"},
    {'title': "Bank Name"},
    {'title': "Address"},
    {'title': "Lat"},
    {'title': "Log"},
    {'title': "Verbal Date"},
  ];
  int onRow = 10;
  String bankName = '';
  int selectIndex = 0;
  int indexs = 0;
  String startDate = "";
  String endDate = "";
  void _setState(VoidCallback fn) {
    setState(fn);
  }

  TextEditingController searchController = TextEditingController();
  var listUsers;
  bool checkActive = false;
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-dd-MM');
    String dateNow = formatter.format(now);
    final controller = Get.put(VerbalControllerAdmin());
    return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
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
                  // Obx(
                  //   () {
                  //     if (controller.isdrop.value) {
                  //       return const WaitingFunction();
                  //     } else if (controller.listBankDrop.isEmpty) {
                  //       return const SizedBox();
                  //     } else {
                  //       // return Text(controller.listBankDrop.toString());
                  //       return Container(
                  //         height: 40,
                  //         width: 200,
                  //         decoration: BoxDecoration(
                  //             border:
                  //                 Border.all(width: 1, color: kPrimaryColor),
                  //             borderRadius: BorderRadius.circular(10)),
                  //         child: DropdownSearch<Map<dynamic, dynamic>>(
                  //             items: controller.listBankDrop,
                  //             compareFn: (item1, item2) {
                  //               return item1['bank_name'] == item2['bank_name'];
                  //             },
                  //             popupProps: PopupProps.menu(
                  //               isFilterOnline: true,
                  //               showSearchBox: true,
                  //               showSelectedItems: true,
                  //               itemBuilder: (context, item, isSelected) {
                  //                 return ListTile(
                  //                   title: Text(item['bank_name'] ?? ''),
                  //                   selected: isSelected,
                  //                 );
                  //               },
                  //               searchFieldProps: const TextFieldProps(
                  //                 decoration: InputDecoration(
                  //                   border: OutlineInputBorder(),
                  //                   hintText: 'Search a Property',
                  //                 ),
                  //               ),
                  //             ),
                  //             onChanged: (value) {
                  //               setState(() {
                  //                 bankName = value!['bank_name'].toString();
                  //               });
                  //               controller.methodListUsers(
                  //                   "",
                  //                   "",
                  //                   value!['bank_name'].toString(),
                  //                   selectIndex,
                  //                   "");
                  //               // });
                  //               // }
                  //             },
                  //             selectedItem: const {"bank_name": "Bank"},
                  //             dropdownDecoratorProps: DropDownDecoratorProps(
                  //               dropdownSearchDecoration: InputDecoration(
                  //                 hintText: 'Select one',
                  //                 labelText: 'Bank',
                  //                 labelStyle: TextStyle(
                  //                   color: blueColor,
                  //                   fontSize: 17,
                  //                 ),
                  //                 prefixIcon: const Icon(
                  //                     Icons.business_outlined,
                  //                     color: kImageColor),
                  //                 filled: true,
                  //                 contentPadding:
                  //                     const EdgeInsets.symmetric(vertical: 8),
                  //                 fillColor: Colors.white,
                  //                 focusedBorder: OutlineInputBorder(
                  //                   borderSide: const BorderSide(
                  //                       color: kPrimaryColor, width: 2.0),
                  //                   borderRadius: BorderRadius.circular(5),
                  //                 ),
                  //                 enabledBorder: OutlineInputBorder(
                  //                   borderSide: const BorderSide(
                  //                       width: 1, color: kPrimaryColor),
                  //                   borderRadius: BorderRadius.circular(5),
                  //                 ),
                  //                 errorBorder: OutlineInputBorder(
                  //                   borderSide: const BorderSide(
                  //                       width: 1, color: kerror),
                  //                   borderRadius: BorderRadius.circular(5),
                  //                 ),
                  //                 focusedErrorBorder: OutlineInputBorder(
                  //                   borderSide: const BorderSide(
                  //                     width: 5,
                  //                     color: kerror,
                  //                   ),
                  //                   borderRadius: BorderRadius.circular(5),
                  //                 ),
                  //                 border: InputBorder.none,
                  //               ),
                  //             ),
                  //             filterFn: (item, filter) {
                  //               return item['bank_name']
                  //                       ?.toLowerCase()
                  //                       .contains(filter.toLowerCase()) ??
                  //                   false;
                  //             },
                  //             itemAsString: (item) => item['bank_name']),
                  //       );
                  //     }
                  //   },
                  // ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: whileColors,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 0.5, color: greyColorNolot)),
                    height: 40,
                    width: 250,
                    child: TextFormField(
                      controller: searchController,
                      // onFieldSubmitted: (value) {
                      //   // changeSeradch(value);
                      // },
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(9),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        // suffixIcon: InkWell(
                        //   onTap: () async {
                        //     // await changeSeradch(controller.text);
                        //   },
                        //   child: Container(
                        //       height: 60,
                        //       width: 60,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(5),
                        //         color: appback,
                        //         border:
                        //             Border.all(width: 0.5, color: greyColor),
                        //       ),
                        //       child: Icon(
                        //         Icons.search,
                        //         color: whiteColor,
                        //       )),
                        // ),
                        icon: const SizedBox(width: 10),
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              searchController.clear();
                            });
                          },
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: blackColor,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: '  Search Users here...',
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Obx(() {
                    if (controller.isActive.value) {
                      return const WaitingFunction();
                    } else if (controller.listVerbals.isEmpty) {
                      return const SizedBox();
                    } else {
                      return ClassExcelVerbal(
                          username: dateNow, list: controller.listVerbals);
                    }
                  }),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () async {
                      await controller.methodVerbalList(
                          startDate, endDate, bankName, searchController.text);
                      // setState(() {
                      //   searchController.clear();
                      // });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: appback,
                      ),
                      height: 40,
                      // width: 100,
                      child: Icon(
                        Icons.search,
                        color: whileColors,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Obx(
              () {
                if (controller.isActive.value) {
                  return const WaitingFunction();
                } else if (controller.listVerbals.isEmpty) {
                  return const SizedBox();
                } else {
                  return Container(
                    decoration: BoxDecoration(
                      color: whileColors,
                    ),
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: SingleChildScrollView(
                      child: PaginatedDataTable(
                        // headingRowHeight: 6,
                        horizontalMargin: 5.0,
                        arrowHeadColor: Colors.blueAccent[300],
                        columns: [
                          for (int i = 0; i < listTitle.length; i++)
                            DataColumn(
                              label: Text(
                                listTitle[i]['title'].toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 5, 11, 67)),
                              ),
                            ),
                        ],
                        dataRowHeight: 50,
                        rowsPerPage: onRow,
                        onRowsPerPageChanged: (value) {
                          setState(() {
                            onRow = value!;
                          });
                        },
                        source: _DataSource(
                            controller.listVerbals,
                            controller.listVerbals.length,
                            context,
                            1,
                            _setState, (value) {
                          setState(() {
                            listUsers = value;
                            showBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) => Column(
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.7,
                                            width: 600,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: greyColorNolots),
                                                color: whileColors,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child:
                                                Account(listUsers: listUsers),
                                          ),
                                        ),
                                      ],
                                    ));
                          });
                        }),
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  final List data;
  final int countRow;
  final BuildContext context;
  final int device;

  final Function setStateCallback;
  final OnChangeCallback listback;
  _DataSource(this.data, this.countRow, this.context, this.device,
      this.setStateCallback, this.listback);

  int selectindex = -1;

  String formatAmount(String amount) {
    // Try to parse the amount to a double
    double parsedAmount = double.tryParse(amount) ?? 0.0;

    // Format the amount to 2 decimal places
    String formattedAmount =
        NumberFormat("###,###.00", "en_US").format(parsedAmount);

    // Check currency and return formatted amount with symbol
    return formattedAmount;
  }

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];

    return DataRow(
      color: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          return index % 2 == 0
              ? const Color.fromARGB(168, 181, 181, 183)
              : Colors.white;
        },
      ),
      cells: [
        buildDataCell("${index + 1}", true, item),
        buildDataCell("${item['verbal_id'] ?? "N/A"}", true, item),
        buildDataCell("${item['username'] ?? "N/A"}", true, item),
        buildDataCell("${item['tel_num'] ?? "N/A"}", true, item),
        buildDataCell("${item['bank_name'] ?? "N/A"}", true, item),
        buildDataCell('${item['verbal_address'] ?? "N/A"}', true, item),
        buildDataCell('${item['latlong_la'] ?? "N/A"}', true, item),
        buildDataCell('${item['latlong_log'] ?? "N/A"}', true, item),
        buildDataCell('${item['verbal_date'] ?? "N/A"}', true, item),
      ],
    );
  }

  DataCell buildDataCell(String text, bool fw, var listUsers) {
    return DataCell(
      onTap: () {
        setStateCallback(() {
          listback(listUsers);
          // print(listUsers.toString());
        });
      },
      Text(
        text,
        style: TextStyle(
            fontSize: 13,
            color: greyColor,
            fontWeight: fw ? FontWeight.bold : null),
      ),
    );
  }

  @override
  int get rowCount => countRow;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
