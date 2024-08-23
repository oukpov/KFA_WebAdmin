import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_admin/components/autoVerbalType.dart';
import 'dart:convert';
import '../../../../screen/Property/FirstProperty/component/Colors/colors.dart';
import '../component/Web/simple/dropdown.dart';
import '../component/Web/simple/dropdownRow.dart';
import '../component/Web/simple/inputdate.dart';
import '../responsiveDevice.dart/editcustomer.dart';

// comparablesearchs Api search
class Customer_List extends StatefulWidget {
  const Customer_List({super.key});

  @override
  State<Customer_List> createState() => _ComparableListState();
}

class _ComparableListState extends State<Customer_List> {
  // A function that converts a response body into a List<Photo>.
  List list = [];
  int onrow = 20;

  Future<void> comparableSearch() async {
    waitSearch = true;
    await Future.wait([]);
    setState(() {
      waitSearch = false;
    });
  }

  @override
  void initState() {
    status();
    comparableListAll();
    // monthModel();
    // yearModel();
    inspector();
    bankModel();
    super.initState();
  }

  List listThirt = [];
  List listTitle = [
    {"title": "No"},
    {"title": "Action"},
    {"title": "Status"},
    {"title": "Property Type"},
    {"title": "Date In"},
    {"title": "Date Out"},
    {"title": "Customer Name"},
    {"title": "Tel"},
    {"title": "Case From"},
    {"title": "Book N"},
    {"title": "Bank Officer"},
    {"title": "Tel"},
    {"title": "Fee Charge"},
    {"title": "First Paid"},
    {"title": "Paid Date"},
    {"title": "Paid By"},
    {"title": "Final Pay"},
    {"title": "Paid Date"},
    {"title": "Paid By"},
    {"title": "Account Receivable(A/R)"},
    {"title": "inspector Name"},
    {"title": "Appraiser"},
    {"title": "Remark"},
  ];
  var sizeboxw40 = const SizedBox(width: 40);
  var sizebox40h = const SizedBox(height: 40);
  var sizebox10h = const SizedBox(height: 10);
  var sizebox = const SizedBox(width: 10);
  Future<void> comparableListAll() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search_all/customer',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        listThirt = list = jsonDecode(json.encode(response.data));
      });
    } else {
      print(response.statusMessage);
    }
  }

  void deletelocal(value) {
    list.removeWhere((element) => element['customer_id'].toString() == value);
    listThirt
        .removeWhere((element) => element['customer_id'].toString() == value);
  }

  Future<void> deletedlist(customerID) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/customer/deleted/$customerID',
      options: Options(
        method: 'DELETE',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  String inspectorID = '';
  Future<void> comparablesearch() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search_all/customer?start=$start&end=$end&customerbankname_id=$brankID&inspectorID=$inspectorID&statusID=$statusID',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        listThirt = jsonDecode(json.encode(response.data));
        print(listThirt.length.toString());
      });
    } else {
      print(response.statusMessage);
    }
  }

  bool waitSearch = false;
  Future comparableSearchs() async {
    waitSearch = true;
    await Future.wait([]);
    setState(() {
      waitSearch = false;
    });
  }

  String? brankID;
  String start = '';
  String end = '';
  String statusID = '';
  List statusList = [];
  Future<void> status() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Customer_status'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body);
          statusList = jsonBody;
        });
      } else {
        print('Error Comparbale List');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  List mothList = [];
  Future<void> monthModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/monthModel'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        mothList = jsonBody;

        setState(() {
          mothList;
        });
      } else {
        print('Error Comparbale List');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  List yearModels = [];
  Future<void> yearModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/yearModels'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        yearModels = jsonBody;

        setState(() {
          yearModels;
        });
      } else {
        print('Error Comparbale List');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  List listInspector = [];
  Future<void> inspector() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Inspector/name'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body)['data'];
          listInspector = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List bankModels = [];
  void bankModel() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/bank',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        var jsonDecodes = jsonDecode(json.encode(response.data))['banks'];
        bankModels = jsonDecodes;
      });
    } else {
      print(response.statusMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundScreen,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30),
        child: Column(
          children: [
            sizebox40h,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.textScaleFactorOf(context) * 12,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(9),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.4, color: greyColor)),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(5),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              comparablesearch();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: blueColor,
                                borderRadius: BorderRadius.circular(5)),
                            height: 45,
                            width: 50,
                            child: Icon(
                              Icons.search,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {});
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
                sizebox,
                InkWell(
                  onTap: () {
                    setState(() {
                      listThirt = list;
                    });
                  },
                  child: Container(
                    height: 35,
                    width: 90,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1, color: greyColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('All '),
                        Icon(Icons.list_alt_outlined),
                      ],
                    ),
                  ),
                )
              ],
            ),
            sizebox10h,
            Row(
              children: [
                DropDown(
                    validator: false,
                    flex: 3,
                    value: (value) {
                      setState(() {
                        inspectorID = value;
                      });
                    },
                    list: listInspector,
                    valuedropdown: 'person_id',
                    valuetxt: 'Inspector_name',
                    filedName: 'inspector Name'),
                sizebox,
                DropDown(
                    validator: false,
                    flex: 3,
                    value: (value) {
                      setState(() {
                        brankID = value;
                      });
                    },
                    list: bankModels,
                    valuedropdown: 'bank_id',
                    valuetxt: 'bank_name',
                    filedName: 'Bank'),
                sizebox,
                DropDown(
                    validator: false,
                    flex: 3,
                    value: (value) {
                      setState(() {
                        statusID = value;
                      });
                    },
                    list: statusList,
                    valuedropdown: 'status_id',
                    valuetxt: 'status_name',
                    filedName: 'Status'),
                sizebox,
                InputDate(
                  filedName: 'Start Date *',
                  flex: 3,
                  value: (value) {
                    setState(() {
                      start = value;
                    });
                  },
                ),
                sizebox,
                InputDate(
                  filedName: 'End Date *',
                  flex: 3,
                  value: (value) {
                    setState(() {
                      end = value;
                    });
                  },
                ),
              ],
            ),
            sizebox10h,
            waitSearch
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width * 1,
                    padding: const EdgeInsets.all(5),
                    child: PaginatedDataTable(
                      horizontalMargin: 5.0,
                      arrowHeadColor: Colors.blueAccent[300],
                      columns: [
                        for (int i = 0; i < listTitle.length; i++)
                          DataColumn(
                              label: Text(
                            listTitle[i]['title'],
                            style: const TextStyle(color: Colors.green),
                          )),
                      ],
                      dataRowHeight: 50,
                      rowsPerPage: onrow,
                      onRowsPerPageChanged: (value) {
                        setState(() {
                          onrow = value!;
                        });
                      },
                      source: _DataSource((value) async {
                        deletelocal(value);
                        await deletedlist(value);
                      }, listThirt, listThirt.length, context, statusList),
                    ),
                  )
          ],
        ),
      )),
    );
  }

  String? searchs;
}

void updatesStatus(context, customerID) async {
  var headers = {'Content-Type': 'application/json'};
  var data = json.encode({"customer_status": code});
  var dio = Dio();
  var response = await dio.request(
    'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/customer_EditStatus/$customerID',
    options: Options(
      method: 'POST',
      headers: headers,
    ),
    data: data,
  );

  if (response.statusCode == 200) {
    print(json.encode(response.data));
    AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.success,
        showCloseIcon: false,
        title: 'Save Successfully',
        autoHide: const Duration(seconds: 3),
        onDismissCallback: (type) {
          Navigator.pop(context);
        }).show();
  } else {
    print(response.statusMessage);
  }
}

int? statusID = 0;

String code = '';

class _DataSource extends DataTableSource {
  final List data;

  final int countrow;
  final BuildContext context;
  final List statusList;
  final OnChangeCallback backdelete;
  _DataSource(
      this.backdelete, this.data, this.countrow, this.context, this.statusList);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }
    void delete(index) {
      data.removeAt(index);
    }

    final item = data[index];

    return DataRow(
        selected: true,
        color: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return index % 2 == 0
                  ? const Color.fromARGB(168, 205, 205, 206)
                  : Colors.white;
            }
            return index % 2 == 0
                ? const Color.fromARGB(168, 205, 205, 206)
                : Colors.white;
          },
        ),
        cells: [
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '  $index',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataCell(
            placeholder: true,
            Row(children: [
              InkWell(
                onTap: () {},
                child: Container(
                  height: 25,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: blueColor,
                  ),
                  child: Icon(
                    Icons.print,
                    color: whiteColor,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResponsiveEditCustomer(
                            list: data,
                            email: 'oukpov@gmail.com',
                            idController: '96',
                            myIdController: '123132',
                            index: index.toString()),
                      ));
                },
                child: Container(
                  height: 25,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.green,
                  ),
                  child: Icon(
                    Icons.edit,
                    color: whiteColor,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {},
                            child: const Text(
                              'Do you want to delete?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    PopupMenuItem(
                        child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              backdelete(item['customercode'].toString());
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 35,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: greyColorNolots),
                              child: const Text('Yes'),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // Navigator.pop(context);
                              print(index.toString());
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 35,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: greyColorNolots),
                              child: const Text('Cancle'),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ];
                },
                child: Container(
                  height: 25,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red,
                  ),
                  child: Icon(
                    Icons.delete,
                    color: whiteColor,
                    size: 18,
                  ),
                ),
              ),
            ]),
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Text(
                              'Status',
                              style: TextStyle(color: greyColor, fontSize: 14),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.remove_circle_outline,
                                    color: greyColor))
                          ],
                        ),
                      )),
                      PopupMenuItem(
                          child: InkWell(
                        onTap: () {},
                        child: DropDownRow(
                            validator: false,
                            flex: 3,
                            value: (value) {
                              code = value;
                            },
                            list: statusList,
                            valuedropdown: 'status_id',
                            valuetxt: 'status_name',
                            filedName: 'Status'),
                      )),
                      PopupMenuItem(
                          child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color:
                                      const Color.fromARGB(255, 218, 216, 216),
                                ),
                                height: 30,
                                width: 70,
                                child: const Text('Close'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                updatesStatus(
                                    context, item['customer_id'].toString());
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: blueColor,
                                    borderRadius: BorderRadius.circular(5)),
                                height: 30,
                                width: 100,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.save_alt_outlined,
                                        color: whiteColor,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        'Update',
                                        style: TextStyle(color: whiteColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ];
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: blueColor,
                        border: Border.all(width: 0.3, color: greyColor),
                        borderRadius: BorderRadius.circular(5)),
                    height: 30,
                    width: 100,
                    child: Text(
                      '${item['status_name'] ?? ""}',
                      style: TextStyle(color: whiteColor, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['property_type_name'] ?? ""}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['customerstartdate'] ?? ""}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  ('${item['customerinspectingdate'] ?? ""}'),
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['customerengname'] ?? ""}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['customercontactbys'] ?? ""}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  (item['customercasefrom'].toString() == '0')
                      ? ''
                      : (item['customercasefrom'].toString() == '1')
                          ? 'Private'
                          : 'Bank',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['customercode'] ?? ""}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['officer_name'] ?? ""}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['office_tell'] ?? ""}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['customerservicecharge'] ?? ""}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['customerservicechargePaid'] ?? ""}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['date_dayment'] ?? ""}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['paid_by'] ?? ""}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['second_payment'] ?? ""}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['second_date_payment'] ?? ""}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['paid_bys'] ?? ""}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['customerservicechargeunpaid'] ?? ""}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['customerinspector'] ?? ""}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['customerappraisalname'] ?? ""}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['customerremark'] ?? ""}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ]);
  }

  @override
  int get rowCount => countrow;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
//
