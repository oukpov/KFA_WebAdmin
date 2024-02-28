// ignore_for_file: unused_import, unnecessary_import, implementation_imports, non_constant_identifier_names, unused_field, must_call_super, prefer_const_constructors, unnecessary_string_interpolations, unused_element, unused_local_variable, dead_code, must_be_immutable

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:printing/printing.dart';
import '../../../../components/contants.dart';

import 'detail_screen.dart';

// comparable_search Api search
class Customer_List extends StatefulWidget {
  Customer_List({super.key, required this.name});
  String? name;

  @override
  State<Customer_List> createState() => _ComparableListState();
}

class _ComparableListState extends State<Customer_List> {
  // A function that converts a response body into a List<Photo>.
  List list = [];
  int on_row = 20;
  String? id_ds;
  Future<void> _comparable_search_() async {
    _wait_search_ = true;
    await Future.wait([]);
    setState(() {
      _wait_search_ = false;
    });
  }

  String? all_search = '';
  String? all_search_inspector = '';

  Future<void> Comparable_search_all() async {
    try {
      final response = await http.get(Uri.parse(
          //Inspector Name                                                                        //Bank                                                                                                                                                                            // Date                                                                                                       //status
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search_all/customer?${(all_search == 'inspector') ? '$first_search$Inspector_ids$bank_ids$date$status_ids' : ''}${(all_search == 'date') ? '$first_search$bank_ids$Inspector_ids$date$status_ids' : ''}${(all_search == 'date') ? '$first_search$date$bank_ids$Inspector_ids$status_ids' : ''}${(all_search == 'status') ? '$first_search$status_ids$date$bank_ids$Inspector_ids' : ''}'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        list = jsonBody;

        setState(() {
          list;
          print(list.toString());
        });
      } else {
        print('Error Comparbale List');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  List _status = [];
  Future<void> status() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Customer_status'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        _status = jsonBody;

        setState(() {
          _status;
        });
      } else {
        print('Error Comparbale List');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  List moth_list = [];
  Future<void> month_model() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/month_model'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        moth_list = jsonBody;

        setState(() {
          moth_list;
        });
      } else {
        print('Error Comparbale List');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  List year_model = [];
  Future<void> _year_model() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/year_model'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        year_model = jsonBody;

        setState(() {
          year_model;
        });
      } else {
        print('Error Comparbale List');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  TextEditingController todate = TextEditingController();
  String? st = '1';
  List _list_Inspector = [];
  Future<void> Inspector() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Inspector/name'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body)['data'];
        _list_Inspector = jsonBody;
        setState(() {
          _list_Inspector;
        });
      } else {
        print('Error bank_dristrict');
      }
    } catch (e) {
      print('Error bank_dristrict $e');
    }
  }

  List bank_model = [];
  void _bank_model() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/bank'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      // print(jsonData);
      // print(jsonData);

      setState(() {
        bank_model = jsonData['banks'];
      });
    }
  }

  bool _wait_search_ = false;

  @override
  void initState() {
    status();
    month_model();
    _year_model();
    Inspector();
    _bank_model();
  }

  String? start;
  String? end;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        title: Text('Customer List'),
        centerTitle: true,
      ),
      body: _wait_search_
          ? Center(
              child: CircularProgressIndicator(),
            )
          : comparable_list(context),
    );
  }

  String? first_search = '';
  String? year_id;
  String? Inspector_id;
  String? bank_id;
  String? status_id;
  String? date = '';
  String? year_ids = '';
  String? Inspector_ids = '';
  String? bank_ids = '';
  String? status_ids = '';
  String? _search;
  Widget comparable_list(BuildContext context) {
    var sizefont = TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.015,
        fontWeight: FontWeight.bold);
    return SingleChildScrollView(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
          child: Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.65,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _search = value;
                          print(_search);
                          // _comparable_search_();
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        hintText: 'Search listing here...',
                      )),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GFButton(
                color: Color.fromARGB(255, 9, 19, 125),
                size: MediaQuery.of(context).size.height * 0.07,
                elevation: 12,
                onPressed: () {
                  setState(() {
                    Comparable_search_all();
                  });
                },
                text: "Search",
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  //value: genderValue,
                  onChanged: (newValue) {
                    setState(() {
                      if (all_search == '') {
                        all_search = 'inspector';

                        first_search = '?customerinspector=$newValue';
                        print('Inspector_ids = 1');
                      } else if (all_search == 'inspector') {
                        // Inspector_ids = '&customerinspector=$newValue';
                        first_search = '?customerinspector=$newValue';
                        // Inspector_ids = '$newValue';
                        print('Inspector_ids = 2');
                      } else {
                        Inspector_ids = '&customerinspector=$newValue';
                        print('Inspector_ids = 3');
                      }
                    });
                  },
                  value: Inspector_id,
                  items: _list_Inspector
                      .map<DropdownMenuItem<String>>(
                        (value) => DropdownMenuItem<String>(
                          value: value["person_id"].toString(),
                          child: Text(
                            value["Inspector_name"].toString(),
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.textScaleFactorOf(context) * 13,
                                height: 0.1),
                          ),
                        ),
                      )
                      .toList(),
                  // add extra sugar..
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: kImageColor,
                  ),

                  decoration: InputDecoration(
                    fillColor: kwhite,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    labelText: 'Inspector Name',
                    hintText: 'Inspector Name',
                    prefixIcon: Icon(
                      Icons.app_registration_sharp,
                      color: kImageColor,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  //value: genderValue,
                  onChanged: (newValue) {
                    setState(() {
                      if (all_search == '') {
                        all_search = 'bank';

                        first_search = '?customerpropertybankname=$newValue';
                        print('customerpropertybankname = 1');
                      } else if (all_search == 'bank') {
                        // Inspector_ids = '&customerinspector=$newValue';
                        first_search = '?customerpropertybankname=$newValue';
                        // Inspector_ids = '$newValue';
                        print('customerpropertybankname = 2');
                      } else {
                        bank_ids = '&customerpropertybankname=$newValue';
                        print('customerpropertybankname = 3');
                      }
                    });
                  },
                  value: bank_id,
                  items: bank_model
                      .map<DropdownMenuItem<String>>(
                        (value) => DropdownMenuItem<String>(
                          value: value["bank_id"].toString(),
                          child: Text(
                            value["bank_name"].toString(),
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 7.5,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  // add extra sugar..
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: kImageColor,
                  ),

                  decoration: InputDecoration(
                    fillColor: kwhite,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    labelText: 'Bank',
                    hintText: 'Bank',
                    prefixIcon: Icon(
                      Icons.app_registration_sharp,
                      color: kImageColor,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 10,
            left: 10,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.065,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                    ),
                    controller: todate, //editing controller of this TextField
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: kImageColor,
                        size: MediaQuery.of(context).size.height * 0.025,
                      ), //icon of text field
                      labelText: 'Date',
                      fillColor: kwhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: kPrimaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ), //label text of field
                    ),
                    readOnly:
                        true, //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);

                        setState(() {
                          todate.text = formattedDate;

                          if (all_search == '') {
                            all_search = 'date';

                            first_search = '?customerstartdate=$formattedDate';
                            print('customerstartdate = 1');
                          } else if (all_search == 'date') {
                            // Inspector_ids = '&customerinspector=$newValue';
                            first_search = '?customerstartdate=$formattedDate';
                            // Inspector_ids = '$newValue';
                            print('customerstartdate = 2');
                          } else {
                            date = '&customerstartdate=$formattedDate';
                            print('customerstartdate = 3');
                          }
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    //value: genderValue,
                    onChanged: (newValue) {
                      setState(() {
                        if (all_search == '') {
                          all_search = 'status';

                          first_search = '?customer_status=$newValue';
                          print('customer_status = 1');
                        } else if (all_search == 'status') {
                          // Inspector_ids = '&customerinspector=$newValue';
                          first_search = '?customer_status=$newValue';
                          // Inspector_ids = '$newValue';
                          print('customer_status = 2');
                        } else {
                          status_ids = '&customer_status=$newValue';
                          print('customer_status = 3');
                        }
                      });
                    },
                    value: status_id,
                    items: _status
                        .map<DropdownMenuItem<String>>(
                          (value) => DropdownMenuItem<String>(
                            value: value["status_id"].toString(),
                            child: Text(
                              value["status_name"].toString(),
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.textScaleFactorOf(context) *
                                          13,
                                  height: 0.1),
                            ),
                          ),
                        )
                        .toList(),
                    // add extra sugar..
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: kImageColor,
                    ),

                    decoration: InputDecoration(
                      fillColor: kwhite,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      labelText: 'Status',
                      hintText: 'Status',
                      prefixIcon: Icon(
                        Icons.app_registration_sharp,
                        color: kImageColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: kPrimaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _wait_search_
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                width: MediaQuery.of(context).size.width * 1,
                padding: EdgeInsets.all(5),
                child: PaginatedDataTable(
                  horizontalMargin: 5.0,
                  arrowHeadColor: Colors.blueAccent[300],
                  columns: [
                    DataColumn(
                        label: Text(
                      'No',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Status',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Property Type',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Date In',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Date Out',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Customer Name',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Tel',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Case From',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Book N',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Bank Officer',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Tel',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Fee Charge',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'First Paid',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Paid Date',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Paid By',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Final Pay',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Paid Date',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Paid By',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Account Receivable(A/R)',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Inspector Name',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Appraiser',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Remark',
                      style: TextStyle(color: Colors.green),
                    )),
                  ],
                  dataRowHeight: 50,
                  rowsPerPage: on_row,
                  onRowsPerPageChanged: (value) {
                    setState(() {
                      on_row = value!;
                    });
                  },
                  source: new _DataSource(
                      list, list.length, context, widget.name, _status),
                ),
              )
      ],
    ));
  }
}

void Update_status(list, index, context) async {
  Map<String, dynamic> payload = await {
    'customergender': list[index]['customergender'].toString(),
    'customercode': list[index]['customercode'].toString(),
    'customer_code_num': list[index]['customer_code_num'].toString(),
    'customerengname': list[index]['customerengname'].toString(),
    'customerkhmname': list[index]['customerkhmname'].toString(),
    'customerbirthdate': '2012-1-1',
    'customermarital_id': null,
    'customermarital': '2012-1-1',
    'customernationally_id': null,
    'customeroccupation_id': null,
    'customerinformationsource_id': null,
    'customerinformationsources': null,
    'customercontactby_id': null,
    'customercontactbys': list[index]['customercontactbys'].toString(),
    'customervat': list[index]['customervat'].toString(),
    'customerbankname_id': null,
    'customerbankbranch_id': null,
    'customerbankaccount': null,
    'customerphone': null,
    'customerphones': list[index]['customerphones'].toString(),
    'customeremail': null,
    'customeremails': null,
    'customeraddress': null,
    'customerprovince_id': null,
    'customerdistrict_id': null,
    '	customercommune_id': null,

    ///11111111///////////////////////////////////////////////////////////////////////////////////////
    'customercontactname': list[index]['customercontactname'].toString(),
    'customerproperty': 1111,
    'customersize': list[index]['customersize'].toString(),
    'customersizeother': null,
    'customerpropertyaddress':
        list[index]['customerpropertyaddress'].toString(),
    'customerpropertyprovince':
        (list[index]['customerpropertyprovince'].toString() == 'null')
            ? null
            : int.parse(list[index]['customerpropertyprovince'].toString()),
    'customerpropertydistrict':
        (list[index]['customerpropertyprovince'].toString() == 'null')
            ? null
            : int.parse(list[index]['customerpropertyprovince'].toString()),
    'customerpropertycommune':
        (list[index]['customerpropertycommune'].toString() == 'null')
            ? null
            : int.parse(list[index]['customerpropertycommune'].toString()),
    'customerregistered':
        (list[index]['customerregistered'].toString() == 'null')
            ? null
            : int.parse(list[index]['customerregistered'].toString()),
    'customerdate': '2012-1-1',
    'customerservicecharge':
        (list[index]['customerservicecharge'].toString() == 'null')
            ? null
            : list[index]['customerservicecharge'].toString(),
    'date_dayment': '2012-1-1',
    'first_payment': null,
    'paid_by': (list[index]['paid_by'].toString() == 'null')
        ? null
        : list[index]['paid_by'].toString(),
    'customerservicechargePaid':
        (list[index]['customerservicechargePaid'].toString() == 'null')
            ? null
            : list[index]['customerservicechargePaid'].toString(),
    'second_date_payment': '2012-1-1',
    'second_payment':
        (list[index]['customerservicechargePaid'].toString() == '')
            ? '0'
            : list[index]['customerservicechargePaid'].toString(),
    'paid_bys': (list[index]['paid_bys'].toString() == '')
        ? '0'
        : list[index]['paid_bys'].toString(),
    ///////////22222222222///////////////////////////////////////////////////////////////////////////////
    'customerservicechargeunpaid':
        (list[index]['customerservicechargeunpaid'].toString() == '0')
            ? '0'
            : list[index]['customerservicechargeunpaid'].toString(),
    'customerchargeFrom': null,
    'customerappraisalfor': null,
    'customerappraisalfrom': null,
    'customerappraisalname':
        (list[index]['customerappraisalname'].toString() == 'null')
            ? null
            : list[index]['customerappraisalname'].toString(),
    /////////////33333333333333/////////////////////////////////////////////////////////////////////////////
    'customerappraisaltel': null,
    'customerappraisallandguardname': null,
    'customerappraisallandguardtel': null,
    'customerstartdate': '2012-1-1',
    'customerenddate': '2012-1-1',
    'customerdatetotal': (list[index]['customerdatetotal'].toString() == 'null')
        ? null
        : double.parse(list[index]['customerdatetotal'].toString()),
    'customersendto': null,
/////////////////////**********//////////////////////// */
    'customerpropertyowner': null,
    'customerpropertybankname':
        (list[index]['customerpropertybankname'].toString() == 'null')
            ? null
            : int.parse(list[index]['customerpropertybankname'].toString()),
    'customerpropertybankbranch':
        (list[index]['customerpropertybankbranch'].toString() == 'null')
            ? null
            : int.parse(list[index]['customerpropertybankbranch'].toString()),
    'customerinspector': (list[index]['customerinspector'].toString() == 'null')
        ? null
        : int.parse(list[index]['customerinspector'].toString()),
    'customerinspectors':
        (list[index]['customerinspectors'].toString() == 'null')
            ? null
            : int.parse(list[index]['customerinspectors'].toString()),
    'customerinspectingdate':
        (list[index]['customerinspectingdate'].toString() == 'null')
            ? null
            : list[index]['customerinspectingdate'].toString(),
    'customerassigned': (list[index]['customerassigned'].toString() == 'null')
        ? null
        : int.parse(list[index]['customerassigned'].toString()),
    'customerassigneddate': '2012-1-1',
    ///////////////////////4444444444444444///////////////////////////////////////////////////////////////////
    'customer_status':
        (status_id == 'null') ? 1 : int.parse(status_id.toString()),
    'customerreference': null,
    'customerreferencename': null,
    'customerreferencephone': null,
    'customerreferred': null,
    'customerremark': (list[index]['customerremark'].toString() == '')
        ? ''
        : list[index]['customerremark'].toString(),
    'customerorn': (list[index]['customerorn'].toString() == '')
        ? ''
        : list[index]['customerorn'].toString(),
    'customerorns': (list[index]['customerorns'].toString() == '')
        ? ''
        : list[index]['customerorns'].toString(),
    'customerBuildSize': (list[index]['customerBuildSize'].toString() == '')
        ? ''
        : list[index]['customerBuildSize'].toString(),
    'CustomerInvoice': (list[index]['CustomerInvoice'].toString() == '')
        ? ''
        : list[index]['CustomerInvoice'].toString(),
    'CustomerInvoices': (list[index]['CustomerInvoices'].toString() == '')
        ? ''
        : list[index]['CustomerInvoices'].toString(),
    'customerinstructorname':
        (list[index]['customerinstructorname'].toString() == '')
            ? ''
            : list[index]['customerinstructorname'].toString(),
    'customerinstructortel':
        (list[index]['customerinstructortel'].toString() == '')
            ? ''
            : list[index]['customerinstructortel'].toString(),
    'customercasefrom': (list[index]['customercasefrom'].toString() == 'null')
        ? null
        : int.parse(list[index]['customercasefrom'].toString()),
    'customervaluationbankmame': null,
    'customervaluationbranchname': null,
    ///////////////////////555555555555555555555///////////////////////////////////////////////////////////////////
    'customerreferredtel': null,
    'officer_name': (list[index]['officer_name'].toString() == 'null')
        ? null
        : list[index]['officer_name'].toString(),
    'office_tell': (list[index]['office_tell'].toString() == 'null')
        ? null
        : list[index]['office_tell'].toString(),
    'appraiser': null,
    'Unpaid': null,
    'PaidBy': null,
    'accompany': (list[index]['accompany'].toString() == 'null')
        ? null
        : int.parse(list[index]['accompany'].toString()),
    'customer_published': 0,
    'customer_created_by': null,
    'customer_modify_by': null,
    'customer_modify_date': null,
    'province_map': (list[index]['province_map'].toString() == '')
        ? 'null'
        : list[index]['province_map'].toString(),
    'district_map': (list[index]['district_map'].toString() == '')
        ? 'null'
        : list[index]['district_map'].toString(),
    'cummune_map': (list[index]['cummune_map'].toString() == '')
        ? 'null'
        : list[index]['cummune_map'].toString(),
    'lat': (list[index]['lat'].toString() == '0')
        ? '0'
        : double.parse(list[index]['lat'].toString()),
    'log': (list[index]['log'].toString() == '0')
        ? '0'
        : double.parse(list[index]['log'].toString()),
    'image_map': (list[index]['image_map'].toString() == 'null')
        ? null
        : 'https://maps.googleapis.com/maps/api/staticmap?center=${list[index]['lat'].toString()},${list[index]['log'].toString()}&zoom=20&size=720x720&maptype=hybrid&markers=color:red%7C%7C${list[index]['lat'].toString()},${list[index]['log'].toString()}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
  };

  final url = await Uri.parse(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/customer_Edit/${list[index]['customer_id'].toString()}');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode(payload),
  );

  if (response.statusCode == 200) {
    print('Success Edit Customer');
    AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.success,
        showCloseIcon: false,
        title: 'Save Successfully',
        autoHide: Duration(seconds: 3),
        onDismissCallback: (type) {
          Navigator.pop(context);
        }).show();
  } else {
    print('Error Edit Customer');
  }
}

int? status_id = 0;
void showConfirmationBottomSheet(
    BuildContext context, status, list, int index) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Status',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.025),
                    ),
                    InkWell(
                      onTap: () {
                        Update_status(list, index, context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 32, 167, 8)),
                        child: Text(
                          'Update',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    //value: genderValue,

                    isExpanded: true,
                    onChanged: (newValue) {
                      status_id = int.parse(newValue.toString());
                    },
                    items: status
                        .map<DropdownMenuItem<String>>(
                          (value) => DropdownMenuItem<String>(
                            value: value['status_id'].toString(),
                            child: Text(value['status_name'].toString()),
                            onTap: () {},
                          ),
                        )
                        .toList(),
                    // add extra sugar..
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: kImageColor,
                    ),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.015,
                          fontWeight: FontWeight.bold),
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      fillColor: kwhite,
                      filled: true,
                      labelText: '${list[index]['status_name'].toString()}',
                      prefixIcon: Icon(
                        Icons.discount_outlined,
                        color: kImageColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: kPrimaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void DeTail_screen(BuildContext context, list, int index) async {
  Navigator.push(context, MaterialPageRoute(
    builder: (context) {
      return Detail_Customer(
        index: index.toString(),
        list: list,
      );
    },
  ));
}

class _DataSource extends DataTableSource {
  final List data;
  final String? name;
  final int count_row;
  final BuildContext context;
  final List _status;
  _DataSource(this.data, this.count_row, this.context, this.name, this._status);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];

    return DataRow(
        selected: true,
        color: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return index % 2 == 0
                  ? Color.fromARGB(168, 73, 83, 224)
                  : Colors.white;
            }
            return index % 2 == 0
                ? Color.fromARGB(255, 255, 162, 162)
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
                  '$index',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    '${item['status_name'].toString()}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.height * 0.014),
                  ),
                ),
              ],
            ),
            onTap: () {
              showConfirmationBottomSheet(context, _status, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  (item['property_type_name'] == null)
                      ? ''
                      : item['property_type_name'].toString(),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  (item['customerstartdate'] == null)
                      ? ''
                      : item['customerstartdate'].toString(),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  (item['customerinspectingdate'] == null)
                      ? ''
                      : item['customerinspectingdate'].toString(),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(item['gendername'] == null) ? '' : item['gendername'].toString()}${(item['customerengname'] == null) ? '' : item['customerengname'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(item['customercontactbys'] == null) ? '' : item['customercontactbys'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
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
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(item['customercode'] == null) ? '' : " ${item['customercode'].toString()}  ${item['customer_code_num'].toString()}"}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(item['officer_name'] == null) ? '' : item['officer_name'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(item['office_tell'] == null) ? '' : item['office_tell'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(item['customerservicecharge'] == null) ? '' : item['customerservicecharge'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(item['customerservicechargePaid'] == null) ? '' : item['customerservicechargePaid'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(item['date_dayment'] == null) ? '' : item['date_dayment'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(item['paid_by'] == null) ? '' : item['paid_by'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(item['second_payment'] == null) ? '' : item['second_payment'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(item['second_date_payment'] == null) ? '' : item['second_date_payment'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(item['paid_bys'] == null) ? '' : item['paid_bys'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(item['customerservicechargeunpaid'] == null) ? '' : item['customerservicechargeunpaid'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(item['customerinspector'] == null) ? '' : item['customerinspector'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(item['customerappraisalname'] == null) ? '' : item['customerappraisalname'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(item['customerremark'] == null) ? '' : item['customerremark'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              DeTail_screen(context, data, index);
            },
          ),
        ]);
  }

  @override
  int get rowCount => count_row;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
//
