import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../Profile/components/FieldBox.dart';
import '../../../../components/colors.dart';
import '../../Customer/component/Web/simple/dropdown.dart';

class customerCaseinOut extends StatefulWidget {
  const customerCaseinOut({super.key});

  @override
  State<customerCaseinOut> createState() => _customerCaseinOutState();
}

class _customerCaseinOutState extends State<customerCaseinOut> {
  TextEditingController controller = TextEditingController();
  bool waitSearch = false;
  List listTitle = [
    {"title": "Nº"},
    {"title": "DATE IN"},
    {"title": "DATE OUT"},
    {"title": "REMARK"},
    {"title": "OWNER'S NAME"},
    {"title": "TEL"},
    {"title": "CASE FROM"},
    {"title": "OR Nº"},
    {"title": "BANK OFFICER"},
    {"title": "TEL"},
    {"title": "BOOK Nº "},
    {"title": "FEE CHARGE"},
    {"title": "First Paid"},
    {"title": "Paid By"},
    {"title": "Second Paid"},
    {"title": "Paid By"},
    {"title": "TOTAL PAID"},
    {"title": "UNPAID"},
    {"title": "APPRAISER"},
    {"title": "ACCOMPANY BY"},
  ];
  List monthsList = [
    {
      "title": "All Month",
      "index": 0,
    },
    {
      "title": "January",
      "index": '01',
    },
    {
      "title": "February",
      "index": '02',
    },
    {
      "title": "March",
      "index": '03',
    },
    {
      "title": "April",
      "index": '04',
    },
    {
      "title": "May",
      "index": '05',
    },
    {
      "title": "June",
      "index": '06',
    },
    {
      "title": "July",
      "index": '07',
    },
    {
      "title": "August",
      "index": '08',
    },
    {
      "title": "September",
      "index": '09',
    },
    {
      "title": "October",
      "index": '10',
    },
    {
      "title": "November",
      "index": '11',
    },
    {
      "title": "December",
      "index": '12',
    },
  ];
  List yearsList = [
    {
      "title": "2030",
    },
    {
      "title": "2029",
    },
    {
      "title": "2028",
    },
    {
      "title": "2027",
    },
    {
      "title": "2026",
    },
    {
      "title": "2025",
    },
    {
      "title": "2024",
    },
    {
      "title": "2023",
    },
    {
      "title": "2022",
    },
    {
      "title": "2021",
    },
    {
      "title": "2020",
    },
    {
      "title": "2019",
    },
    {
      "title": "2018",
    },
    {
      "title": "2017",
    },
    {
      "title": "2016",
    },
    {
      "title": "2015",
    },
    {
      "title": "2014",
    },
    {
      "title": "2013",
    },
    {
      "title": "2012",
    },
    {
      "title": "2011",
    },
  ];
  List listall = [];

  List listmid = [];
  Future<void> customerAll() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/customercase/out',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        listmid = listall = jsonDecode(json.encode(response.data));
      });
    }
  }

  Future<void> customersearch(query) async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/customersearch?search=$query',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        listmid = jsonDecode(json.encode(response.data));
      });
    }
  }

  @override
  void initState() {
    customerAll();
    super.initState();
  }

  String years = '';
  String months = '01';

  void searchYearMonth() {
    listmid = listall.where((element) {
      List<String> dateParts = element['customerdate'].toString().split('-');
      if (dateParts.length >= 2 && dateParts.isNotEmpty) {
        String elementYear = dateParts[0];
        String elementMonth = dateParts[1];
        return (elementYear == years && elementMonth == months);
      } else {
        return false;
      }
    }).toList();
  }

  int onrow = 20;
  @override
  void dispose() {
    controller.dispose();

    super.dispose();
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
              Row(
                children: [
                  DropDown(
                      validator: false,
                      flex: 2,
                      value: (value) {
                        months = value.toString();
                      },
                      list: monthsList,
                      valuedropdown: 'index',
                      valuetxt: 'title',
                      filedName: 'Month'),
                  const SizedBox(width: 10),
                  DropDown(
                      validator: false,
                      flex: 2,
                      value: (value) {
                        setState(() {
                          years = value;
                        });
                      },
                      list: yearsList,
                      valuedropdown: 'title',
                      valuetxt: 'title',
                      filedName: 'Year *'),
                  const SizedBox(width: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        height: 35,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextFormField(
                          controller: controller,
                          onChanged: (value) {
                            setState(() {
                              customersearch(value);
                            });
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                MediaQuery.textScaleFactorOf(context) * 12,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(9),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 0.4, color: greyColor)),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(5),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    searchYearMonth();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: blueColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  height: 35,
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
                                setState(() {
                                  listmid = listall;
                                  controller.clear();
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
                      InkWell(
                        onTap: () {
                          setState(() {
                            listmid = listall;
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
                ],
              ),
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
                        source: _DataSource(
                            (value) async {}, listmid, listmid.length, context),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List data;

  final int countrow;
  final BuildContext context;

  final OnChangeCallback backdelete;
  _DataSource(this.backdelete, this.data, this.countrow, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length + 1) {
      return null;
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
                  index.toString(),
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
                  '${item['customerdate'] ?? ""}',
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
                  '${item['customerdate'] ?? ""}',
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
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['gendername'] ?? ""}${item['customerengname'] ?? ""}',
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
                  '${item['bank_name'] ?? ""}',
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
                  '${item['customerorn'] ?? ""}',
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
                  '${item['customercode'] ?? ""}${item['customer_code_num'] ?? ""}',
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
                  '${double.parse(item['customerservicecharge'] ?? "0") - double.parse(item['customerservicechargeunpaid'] ?? "0")}',
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
                  '${item['appraisers_name'] ?? ""}',
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
                  '${item['accompany_name'] ?? ""}',
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
