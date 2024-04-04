import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/colors.dart';
import '../../Customer/List/customerCando.dart';
import '../../Customer/component/List/list.dart';
import '../../Customer/component/Web/simple/dropdown.dart';
import '../../Customer/component/Web/simple/inputdate.dart';

class customercasebar extends StatefulWidget {
  const customercasebar({super.key});

  @override
  State<customercasebar> createState() => _customercasebarState();
}

class _customercasebarState extends State<customercasebar> {
  @override
  void initState() {
    status();
    super.initState();
  }

  String statused = '1';
  String query = '';
  int caseall = 0;
  bool changetype = false;
  Future<void> search() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/customercase/cando?$query&status=$statused'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        setState(() {
          january = jsonBody['1'];
          february = jsonBody['2'];
          march = jsonBody['3'];
          april = jsonBody['4'];
          may = jsonBody['5'];
          june = jsonBody['6'];
          july = jsonBody['7'];
          august = jsonBody['8'];
          september = jsonBody['9'];
          october = jsonBody['10'];
          november = jsonBody['11'];
          december = jsonBody['12'];
          caseall = january.length +
              february.length +
              march.length +
              april.length +
              may.length +
              june.length +
              july.length +
              august.length +
              september.length +
              october.length +
              november.length +
              december.length;
        });
      }
    } catch (e) {
      throw "$e";
    }
  }

  bool wait = false;
  Future<void> awaitcustomer() async {
    wait = true;
    Future.wait([search()]);
    setState(() {
      wait = false;
    });
  }

  String statusname = 'Not Checked';
  List january = [];
  List february = [];
  List march = [];
  List april = [];
  List may = [];
  List june = [];
  List july = [];
  List august = [];
  List september = [];
  List october = [];
  List november = [];
  List december = [];
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

  String startdate = '';
  String enddate = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 30, left: 30, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Row(
                children: [
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        awaitcustomer();
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: greyColorNolot),
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 216, 214, 214)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search, color: greyColor),
                          Text(
                            'Search',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: greyColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  InputDate(
                    filedName: 'From',
                    flex: 3,
                    value: (value) {
                      setState(() {
                        startdate = value;
                        query = 'start=$startdate&end=$enddate';
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  InputDate(
                    filedName: 'To Date',
                    flex: 3,
                    value: (value) {
                      setState(() {
                        enddate = value;
                        query = 'start=$startdate&end=$enddate';
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  DropDown(
                      validator: false,
                      flex: 2,
                      value: (value) {
                        setState(() {
                          statused = value;
                        });
                      },
                      list: statusList,
                      valuedropdown: 'status_id',
                      valuetxt: 'status_name',
                      filedName: 'Status'),
                  const SizedBox(width: 10),
                  DropDown(
                      validator: false,
                      flex: 2,
                      value: (value) {
                        setState(() {
                          query = 'year=$value';
                        });
                      },
                      list: yearsList,
                      valuedropdown: 'title',
                      valuetxt: 'title',
                      filedName: 'Year'),
                ],
              ),
              const SizedBox(height: 20),
              Text('Customer Case in Case Out',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: greyColor)),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: DataTable(
                  border: TableBorder.all(width: 0.3),
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'No',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Status',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Case',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('1')),
                        if (statused == '1')
                          const DataCell(Text('Not Checked'))
                        else if (statused == '2')
                          const DataCell(Text('Processing'))
                        else if (statused == '3')
                          const DataCell(Text('Completed'))
                        else if (statused == '4')
                          const DataCell(Text('Cancel'))
                        else if (statused == '5')
                          const DataCell(Text('Invoice Issue'))
                        else if (statused == '6')
                          const DataCell(Text('Pending'))
                        else if (statused == '7')
                          const DataCell(Text('Survey')),
                        DataCell(Text(caseall.toString()))
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text('Chart Customer Case in Case Out',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: greyColor)),
              const SizedBox(height: 20),
              CandoCase(
                  january: january,
                  february: february,
                  march: march,
                  april: april,
                  may: may,
                  june: june,
                  july: july,
                  august: august,
                  september: september,
                  october: october,
                  november: november,
                  december: december)
            ],
          ),
        ),
      ),
    );
  }
}
