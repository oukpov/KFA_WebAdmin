// ignore_for_file: unused_import, unnecessary_import, implementation_imports, non_constant_identifier_names, unused_field, must_call_super, prefer_const_constructors, unnecessary_string_interpolations, unused_element, unused_local_variable, dead_code, must_be_immutable

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import '../../../../../components/contants.dart';
import '../../../../screen/Property/Map/ToFromDate_ForSale.dart';
import '../Edit/Edit_Ex.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Executive_List extends StatefulWidget {
  Executive_List({super.key});

  @override
  State<Executive_List> createState() => _ComparableListState();
}

class _ComparableListState extends State<Executive_List> {
  // A function that converts a response body into a List<Photo>.
  List list = [];
  int on_row = 20;
  String? id_ds;

  Future<void> _search_text() async {
    _wait_search = true;
    await Future.wait([
      Comparable_Text(),
    ]);
    setState(() {
      _wait_search = false;
    });
  }

  String? status_id;
  String? customerregistered = '';
  String? customerregistereds;
  String? start = '';
  String? end = '';
  String? executive_user;
  String? executivestatusid = '';
  String? executivestatusids;
  List _status = [];

  Future<void> Comparable_search() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search_all${(all_search == 'agency') ? '$first_search$executivestatusid$start$end' : ''}${(all_search == 'status') ? '$first_search$customerregistered$start$end' : ''}'));
      // 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search_all$first_search$&start=$start&end=$end&executive_user=$executive_user&executivestatusid=$executivestatusid'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        list = jsonBody;

        setState(() {
          list;
        });
      } else {
        print('Error Comparable Search');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  Future<void> Comparable_Text() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search/Text?search=${_search}'));
      // 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search_all$first_search$&start=$start&end=$end&executive_user=$executive_user&executivestatusid=$executivestatusid'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        list = jsonBody;

        setState(() {
          list;
        });
      } else {
        print('Error Comparable Search');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

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

  List agency_list = [];
  Future<void> agency() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_agency'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        agency_list = jsonBody;

        setState(() {
          agency_list;
        });
      } else {
        print('Error Comparable Search');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  Future<void> Customer_List() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/exccutive/list'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        list = jsonBody;

        setState(() {
          list;
        });
      } else {
        print('Error Comparbale List');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  bool _wait_search_ = false;
  bool _wait_search = false;
  Future<void> _comparable_search_date() async {
    _wait_search = true;
    await Future.wait([
      ComparableList_search_data(),
    ]);
    setState(() {
      _wait_search = false;
    });
  }

  Future<void> _comparable_search_all() async {
    _wait_search = true;
    await Future.wait([Comparable_search()]);
    setState(() {
      _wait_search = false;
    });
  }

  String? all_search = '';
  String? first_search = '';
  Widget dropdown_() {
    var pading_r_l_t = EdgeInsets.only(right: 30, left: 30, top: 10);
    return Padding(
      padding: pading_r_l_t,
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.015,
                  color: Colors.black),
              isExpanded: true,
              //value: genderValue,
              onChanged: (newValue) {
                setState(() {
                  if (all_search == '') {
                    all_search = 'agency';
                    first_search = '?customerregistered=$newValue';
                    text_drop = 'no_text';
                  } else if (all_search == 'agency') {
                    first_search = '?customerregistered=$newValue';
                    text_drop = 'no_text';
                  } else {
                    customerregistered = '&customerregistered=$newValue';
                    text_drop = 'no_text';
                  }
                });
              },
              value: customerregistereds,
              items: agency_list
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                      value: value["agenttype_id"].toString(),
                      child: Text(
                        value["agenttype_name"].toString(),
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
                labelText: 'Agency',
                hintText: 'Agency',
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
            width: 20,
          ),
          Expanded(
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              //value: genderValue,
              onChanged: (newValue) {
                setState(() {
                  if (all_search == '') {
                    all_search = 'status';
                    first_search = '?executivestatusid=$newValue';
                    text_drop = 'no_text';
                  } else if (all_search == 'status') {
                    first_search = '?executivestatusid=$newValue';
                    text_drop = 'no_text';
                  } else {
                    executivestatusid = '&executivestatusid=$newValue';
                    text_drop = 'no_text';
                  }
                });
              },
              value: executivestatusids,
              items: _status
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                      value: value["status_id"].toString(),
                      child: Text(
                        value["status_name"].toString(),
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
    );
  }

  Future<void> ComparableList_search_data() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search/date?start=$start&end=$end'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        list = jsonBody;
        setState(() {
          list;
        });
      } else {
        print('Error Comparable Date');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  @override
  void initState() {
    Customer_List();
    status();
    agency();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        // title: Text('$date'),
        title: Text('list Executive'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30),
        child: comparable_list(context),
      ),
    );
  }

  String? executive_app;
  String? text_drop = '';
  String? date;
  String? _search;
  Widget comparable_list(BuildContext context) {
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
                          text_drop = 'text';
                          // _search_text();
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
                    if (start != '' &&
                        end != '' &&
                        executivestatusid == '' &&
                        first_search == '' &&
                        text_drop != 'text') {
                      _comparable_search_date();
                      print('all by date');
                    } else if (text_drop == 'text') {
                      print('text');
                      _search_text();
                    } else {
                      _comparable_search_all();
                      print('all Value');
                    }
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
        SizedBox(height: 10),
        dropdown_(),
        Padding(
          padding:
              const EdgeInsets.only(right: 30, left: 30, top: 10, bottom: 10),
          child: ToFromDate_p(
            fromDate: (value) {
              setState(() {
                start = '&start=$value';
                text_drop = 'no_text';
              });
            },
            toDate: (value) {
              setState(() {
                end = '&end=$value';
                text_drop = 'no_text';
              });
            },
          ),
        ),
        _wait_search
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                width: MediaQuery.of(context).size.width * 1,
                padding: EdgeInsets.all(5),
                child: PaginatedDataTable(
                  horizontalMargin: 5.0,
                  arrowHeadColor: Colors.blueAccent[300],
                  columns: const [
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
                      'Approve',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Code',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Customer Name',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Phone',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Property Name',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Property Type',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Valuation Date',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Issue Date',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Land Size',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Land Price',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Agency Name',
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
                  source: _DataSource(
                    list,
                    list.length,
                    context,
                    _status,
                  ),
                ),
              )
      ],
    ));
  }
}

String? executive_app;
Future<void> Update_status(list, index, context, int status_id) async {
  var cusomter_id;
  // print(status_id.toString());
  int status_ids = 0;

  if (status_id == 0) {
    status_ids = int.parse(list[index]['executivestatusid'].toString());
    print('11111111111');
  } else {
    status_ids = status_id;
    print('222222222222');

    // print(status_ids.toString());
  }
  if (list[index]['executive_customer_id'].toString() == 'null' ||
      list[index]['executive_customer_id'].toString() == '') {
    cusomter_id = null;
    print('null');
  } else {
    cusomter_id = list[index]['executive_customer_id'].toString();
    print('no null');
  }
  final url =
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/update/status_id/${list[index]['executive_id'].toString()}'; // Replace with your actual API endpoint URL

  // Create your JSON data based on the structure you provided
  final Map<String, dynamic> jsonData = {
    "executive_id": int.parse(list[index]['executive_id'].toString()),
    "executiveStatus": (list[index]['executiveStatus'].toString() == 'null')
        ? null
        : int.parse(list[index]['executiveStatus'].toString()),
    "executive_address": list[index]['executive_address'].toString(),
    "executive_app": (list[index]['executive_app'].toString() == 'null' ||
            list[index]['executive_app'].toString() == '')
        ? null
        : int.parse(executive_app.toString()),
    // : ,
    "executive_approvel":
        (list[index]['executive_approvel'].toString() == 'null' ||
                list[index]['executive_approvel'].toString() == '')
            ? null
            : int.parse(list[index]['executive_approvel'].toString()),
    "executive_building":
        (list[index]['executive_building'].toString() == 'null' ||
                list[index]['executive_building'].toString() == '')
            ? null
            : list[index]['executive_building'].toString(),
    "executive_by": (list[index]['executive_by'].toString() == 'null' ||
            list[index]['executive_by'].toString() == '')
        ? null
        : int.parse(list[index]['executive_by'].toString()),
    "executive_com": (list[index]['executive_com'].toString() == 'null' ||
            list[index]['executive_com'].toString() == '')
        ? null
        : int.parse(list[index]['executive_com'].toString()),
    "executive_comment": list[index]['executive_comment'].toString(),
    "executive_commune_id":
        (list[index]['executive_comment'].toString() == 'null' ||
                list[index]['executive_comment'].toString() == '')
            ? null
            : list[index]['executive_comment'].toString(),
    "executive_create_by":
        (list[index]['executive_create_by'].toString() == 'null' ||
                list[index]['executive_create_by'].toString() == '')
            ? null
            : int.parse(list[index]['executive_create_by'].toString()),
    "executive_customer_id": cusomter_id,
    "executive_district_id":
        (list[index]['executive_district_id'].toString() == 'null' ||
                list[index]['executive_district_id'].toString() == '')
            ? null
            : int.parse(list[index]['executive_district_id'].toString()),
    "executive_fair": (list[index]['executive_fair'].toString() == 'null' ||
            list[index]['executive_fair'].toString() == '')
        ? null
        : list[index]['executive_fair'].toString(),
    "executive_fire": (list[index]['executive_fire'].toString() == 'null' ||
            list[index]['executive_fire'].toString() == '')
        ? null
        : list[index]['executive_fire'].toString(),
    "executive_forced": (list[index]['executive_forced'].toString() == 'null' ||
            list[index]['executive_forced'].toString() == '')
        ? null
        : list[index]['executive_forced'].toString(),
    "executive_land_lengh":
        (list[index]['executive_land_lengh'].toString() == 'null' ||
                list[index]['executive_land_lengh'].toString() == '')
            ? null
            : list[index]['executive_land_lengh'].toString(),
    "executive_land_price":
        (list[index]['executive_land_price'].toString() == 'null' ||
                list[index]['executive_land_price'].toString() == '')
            ? null
            : list[index]['executive_land_price'].toString(),
    "executive_land_price_per":
        (list[index]['executive_land_price_per'].toString() == 'null' ||
                list[index]['executive_land_price_per'].toString() == '')
            ? null
            : list[index]['executive_land_price_per'].toString(),
    "executive_land_total":
        (list[index]['executive_land_total'].toString() == 'null' ||
                list[index]['executive_land_total'].toString() == '')
            ? null
            : list[index]['executive_land_total'].toString(),
    "executive_land_width":
        (list[index]['executive_land_width'].toString() == '' ||
                list[index]['executive_land_width'].toString() == 'null')
            ? ''
            : list[index]['executive_land_width'].toString(),
    "executive_lng": (list[index]['executive_lng'].toString() == 'null' ||
            list[index]['executive_lng'].toString() == '')
        ? null
        : list[index]['executive_lng'].toString(),
    "executive_lon": (list[index]['executive_lon'].toString() == 'null' ||
            list[index]['executive_lon'].toString() == '')
        ? null
        : list[index]['executive_lon'].toString(),
    "executive_market_max":
        (list[index]['executive_market_max'].toString() == 'null' ||
                list[index]['executive_market_max'].toString() == '')
            ? null
            : list[index]['executive_market_max'].toString(),
    "executive_market_min":
        (list[index]['executive_market_min'].toString() == 'null' ||
                list[index]['executive_market_min'].toString() == '')
            ? null
            : list[index]['executive_market_min'].toString(),
    "executive_modify_by": 0,
    // "executive_modify_date": "2021-1-2",
    "executive_modify_date": "2021-1-2",
    "executive_name": 0,
    "executive_obligation":
        (list[index]['executive_obligation'].toString() == 'null' ||
                list[index]['executive_obligation'].toString() == '')
            ? null
            : list[index]['executive_obligation'].toString(),
    "executive_property_name":
        (list[index]['executive_property_name'].toString() == 'null' ||
                list[index]['executive_property_name'].toString() == '')
            ? ""
            : list[index]['executive_property_name'].toString(),
    "executive_property_type_id":
        (list[index]['executive_property_type_id'].toString() == 'null' ||
                list[index]['executive_property_type_id'].toString() == '')
            ? null
            : int.parse(list[index]['executive_property_type_id'].toString()),
    "executive_province_id":
        (list[index]['executive_province_id'].toString() == 'null' ||
                list[index]['executive_property_type_id'].toString() == '')
            ? null
            : int.parse(list[index]['executive_province_id'].toString()),
    "executive_published": 1,
    "executive_purpose": (list[index]['executive_purpose'].toString() == '' ||
            list[index]['executive_purpose'].toString() == 'null')
        ? ''
        : list[index]['executive_purpose'].toString(),
    "executive_remark": (list[index]['executive_remark'].toString() == 'null' ||
            list[index]['executive_remark'].toString() == '')
        ? null
        : list[index]['executive_remark'].toString(),
    "executive_remarks":
        (list[index]['executive_remarks'].toString() == 'null' ||
                list[index]['executive_remarks'].toString() == '')
            ? null
            : list[index]['executive_remarks'].toString(),
    "executive_road_type_id":
        (list[index]['executive_road_type_id'].toString() == 'null' ||
                list[index]['executive_road_type_id'].toString() == '')
            ? null
            : int.parse(list[index]['executive_road_type_id'].toString()),
    "executive_user": (list[index]['executive_user'].toString() == 'null' ||
            list[index]['executive_user'].toString() == '')
        ? null
        : list[index]['executive_user'].toString(),
    "executive_valuate_id":
        (list[index]['executive_valuate_id'].toString() == 'null' ||
                list[index]['executive_valuate_id'].toString() == '')
            ? null
            : int.parse(list[index]['executive_valuate_id'].toString()),
    "executive_valuation_date":
        (list[index]['executive_valuation_date'].toString() == 'null' ||
                list[index]['executive_valuation_date'].toString() == '')
            ? null
            : list[index]['executive_valuation_date'].toString(),
    "executive_valuation_issue_date":
        (list[index]['executive_valuation_issue_date'].toString() == 'null' ||
                list[index]['executive_valuation_issue_date'].toString() == '')
            ? null
            : list[index]['executive_valuation_issue_date'].toString(),
    "executive_zone_id":
        (list[index]['executive_zone_id'].toString() == 'null' ||
                list[index]['executive_zone_id'].toString() == '')
            ? null
            : int.parse(list[index]['executive_zone_id'].toString()),
    "executiveapprove1status":
        (list[index]['executiveapprove1status'].toString() == 'null' ||
                list[index]['executiveapprove1status'].toString() == '')
            ? null
            : int.parse(list[index]['executiveapprove1status'].toString()),
    "executivestatusid": (status_ids == 0)
        ? int.parse(list[index]['executivestatusid'].toString())
        : status_ids,
    "remember_token": "2",
  };
  //////////////////////////////////////////////////////////////////

  final String jsonString = jsonEncode(jsonData);

  try {
    // Send the HTTP POST request
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonString,
    );

    // Check the response status
    if (response.statusCode == 200) {
      // Request was successful, handle the response here
      AwesomeDialog(
          context: context,
          animType: AnimType.leftSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.success,
          showCloseIcon: false,
          title: 'Successfully',
          autoHide: Duration(seconds: 3),
          onDismissCallback: (type) {
            Navigator.pop(context);
          }).show();
      print('API Response: ${response.body}');
    } else {
      // Request failed with an error, handle the error here
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    // Exception occurred while sending the request, handle the error here
    print('Error: $e');
  }
}

void showConfirmationBottomSheet(
  BuildContext context,
  status,
  list,
  int index,
) {
  int status_id = 0;
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
                      onTap: () async {
                        if (status_id != 0) {
                          executive_app = status_id.toString();
                        } else {
                          executive_app =
                              list[index]['executive_app'].toString();
                        }

                        // Update_status(list, index, context);
                        await Update_status(list, index, context, status_id);
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
                      // status_id = int.parse(newValue.toString());
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
                // Text(list_building.toString()),
                // // Text(list[index][''].toString()),
                // Text(list_appraiser.toString()),
                // Text(list_map.toString()),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void EditScreens(BuildContext context, list, int index) async {
  Navigator.push(context, MaterialPageRoute(
    builder: (context) {
      return Detail_Executive(list: list, index: index.toString());
    },
  ));
}

class _DataSource extends DataTableSource {
  final List data;
  final List _status;
  final int count_row;
  final BuildContext context;

  _DataSource(
    this.data,
    this.count_row,
    this.context,
    this._status,
  );

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
              EditScreens(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['status_name'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () async {
              print(item['executive_id'].toString());

              showConfirmationBottomSheet(
                context,
                _status,
                data,
                index,
              );
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(item['appstatus_name'].toString() == 'null') ? '' : item['appstatus_name'].toString()}',
                  // '',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              EditScreens(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['customercode'].toString()}-${item['customer_code_num'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              EditScreens(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['gendername'].toString()}${item['customerengname'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              EditScreens(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['customerinformationsources'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              EditScreens(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(item['executive_property_name'].toString() == 'null' ? '' : item['executive_property_name'].toString())}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              EditScreens(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(item['property_type_name'].toString() == 'null' ? '' : item['property_type_name'].toString())}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              EditScreens(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['executive_valuation_date'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              EditScreens(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['executive_valuation_issue_date'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              EditScreens(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['executive_land_total'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              EditScreens(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${item['executive_land_price_per'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              EditScreens(context, data, index);
            },
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  // '${item['executive_land_price_per'].toString()}',
                  '',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              EditScreens(context, data, index);
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
