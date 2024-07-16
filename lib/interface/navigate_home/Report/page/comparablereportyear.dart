import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:graphic/graphic.dart';
import 'dart:convert';
import '../../../../Profile/contants.dart';
import 'inputdateshow.dart';

class ComparableReportYear extends StatefulWidget {
  const ComparableReportYear({super.key, required this.device});
  final String device;
  @override
  // ignore: library_private_types_in_public_api
  _ComparableReportYearState createState() => _ComparableReportYearState();
}

class _ComparableReportYearState extends State<ComparableReportYear> {
  final fromDatey1 = ValueNotifier<String?>(null);
  final toDatey1 = ValueNotifier<String?>(null);
  final fromDatey2 = ValueNotifier<String?>(null);
  final toDatey2 = ValueNotifier<String?>(null);
  final fromDatey3 = ValueNotifier<String?>(null);
  final toDatey3 = ValueNotifier<String?>(null);
  var sizebox10w = const SizedBox(width: 100);
  List agency = [];
  var fonsize15 = const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  String agencyname = '';
  List<Map<String, dynamic>> _searchreport = [];
  bool isLoading = false;
  var sizebox10h = const SizedBox(
    height: 10,
  );
  @override
  void initState() {
    super.initState();
    _getagency();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Comparable by Year'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: (widget.device == 'm')
              ? Form(
                  key: _formKey,
                  child: SizedBox(
                    child: Column(
                      children: [
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                'Comparable Report by Year',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        sizebox10h,
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                'Agency',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 35,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: DropdownButtonFormField(
                                    items: agency
                                        .map<DropdownMenuItem<String>>(
                                          (value) => DropdownMenuItem<String>(
                                            value: ((value["agenttype_name"]
                                                        .toString()) ==
                                                    '')
                                                ? 'NoneSelected'
                                                : value["agenttype_name"]
                                                    .toString(),
                                            child: Text(
                                              ((value["agenttype_name"]) == '')
                                                  ? const Text(
                                                      'NoneSelected',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ).toString()
                                                  : value["agenttype_name"]
                                                      .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: MediaQuery
                                                          .textScaleFactorOf(
                                                              context) *
                                                      13,
                                                  height: 1),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (newValue) {
                                      setState(() async {
                                        agencyname = newValue as String;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      // labelStyle: ,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 0),
                                      fillColor: kwhite,
                                      filled: true,
                                      labelText: agencyname.toString(),
                                      hintText: agencyname.toString(),
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              MediaQuery.textScaleFactorOf(
                                                      context) *
                                                  12),
                                      helperStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              MediaQuery.textScaleFactorOf(
                                                      context) *
                                                  12),
                                      prefixIcon: const SizedBox(width: 7),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: kPrimaryColor, width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: kPrimaryColor,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(255, 249, 0, 0),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      focusedErrorBorder:
                                          const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(255, 249, 0, 0),
                                        ),
                                        //  borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        sizebox10h,
                        _buildDateInputsphonedevice(
                          'From Year 1',
                          'To Year 1',
                          fromDatey1,
                          toDatey1,
                        ),
                        _buildDateInputsphonedevice(
                          'From Year 2',
                          'To Year 2',
                          fromDatey2,
                          toDatey2,
                        ),
                        _buildDateInputsphonedevice(
                          'From Year 3',
                          'To Year 3',
                          fromDatey3,
                          toDatey3,
                        ),
                        sizebox10h,
                        const SizedBox(height: 24),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                child: const Text("Search"),
                                onPressed: () {
                                  if (agencyname.isEmpty) {
                                    BotToast.showText(
                                        text: "Please select agency and date");
                                    return;
                                  }
                                  _searchdate();
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        if (isLoading)
                          const CircularProgressIndicator()
                        else if (_searchreport.isNotEmpty)
                          _buildReportWidget()
                        else
                          const Text("No data available"),
                      ],
                    ),
                  ))
              : Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Comparable Report Year", style: fonsize15),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Text("Agency", style: fonsize15),
                            const SizedBox(width: 130),
                            SizedBox(
                              height: 35,
                              width: 220,
                              child: DropdownButtonFormField(
                                  items: agency
                                      .map<DropdownMenuItem<String>>(
                                        (value) => DropdownMenuItem<String>(
                                          value: ((value["agenttype_name"]
                                                      .toString()) ==
                                                  '')
                                              ? 'NoneSelected'
                                              : value["agenttype_name"]
                                                  .toString(),
                                          child: Text(
                                            ((value["agenttype_name"]) == '')
                                                ? const Text(
                                                    'NoneSelected',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ).toString()
                                                : value["agenttype_name"]
                                                    .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: MediaQuery
                                                        .textScaleFactorOf(
                                                            context) *
                                                    13,
                                                height: 1),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (newValue) {
                                    setState(() async {
                                      agencyname = newValue as String;
                                      print(
                                          "ssssssssssssssssssssss $agencyname");
                                    });
                                  },
                                  decoration: InputDecoration(
                                    // labelStyle: ,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 0),
                                    fillColor: kwhite,
                                    filled: true,
                                    labelText: agencyname.toString(),
                                    hintText: agencyname.toString(),
                                    labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQuery.textScaleFactorOf(
                                                context) *
                                            12),
                                    helperStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQuery.textScaleFactorOf(
                                                context) *
                                            12),
                                    prefixIcon: const SizedBox(width: 7),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor, width: 1.0),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: kPrimaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Color.fromARGB(255, 249, 0, 0),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedErrorBorder:
                                        const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Color.fromARGB(255, 249, 0, 0),
                                      ),
                                      //  borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildDateInputs(
                            'From Year 1', 'To Year 1', fromDatey1, toDatey1),
                        const SizedBox(height: 16),
                        _buildDateInputs(
                            'From Year 2', 'To Year 2', fromDatey2, toDatey2),
                        const SizedBox(height: 16),
                        _buildDateInputs(
                            'From Year 3', 'To Year 3', fromDatey3, toDatey3),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          child: const Text("Search"),
                          onPressed: () {
                            if (agencyname.isEmpty) {
                              BotToast.showText(
                                  text: "Please select an agency and date");
                              return;
                            }
                            _searchdate();
                          },
                        ),
                        const SizedBox(height: 24),
                        if (isLoading)
                          const CircularProgressIndicator()
                        else if (_searchreport.isNotEmpty)
                          _buildReportWidget()
                        else
                          const Text("No data available"),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildDateInputs(String fromLabel, String toLabel,
      ValueNotifier<String?> fromNotifier, ValueNotifier<String?> toNotifier) {
    return SizedBox(
      child: Row(
        children: [
          Text(fromLabel, style: fonsize15),
          sizebox10w,
          InputDatetshow(
            flex: 2,
            dateNotifier: fromNotifier,
            fieldName: '',
          ),
          sizebox10w,
          Text(toLabel, style: fonsize15),
          sizebox10w,
          InputDatetshow(
            flex: 2,
            dateNotifier: toNotifier,
            fieldName: '',
          ),
        ],
      ),
    );
  }

  Widget _buildDateInputsphonedevice(String fromLabel, String toLabel,
      ValueNotifier<String?> fromNotifier, ValueNotifier<String?> toNotifier) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: Column(
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(fromLabel, style: fonsize15),
              ],
            ),
          ),
          sizebox10h,
          InputDatetshow(
            flex: 2,
            dateNotifier: fromNotifier,
            fieldName: '',
          ),
          sizebox10h,
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(toLabel, style: fonsize15),
              ],
            ),
          ),
          sizebox10h,
          InputDatetshow(
            flex: 2,
            dateNotifier: toNotifier,
            fieldName: '',
          )
        ],
      ),
    );
  }

  Widget _buildReportWidget() {
    return SizedBox(
      child: Column(
        children: _searchreport.map((reportData) {
          String year = reportData['year'];
          String startDate = reportData['start_date'];
          String endDate = reportData['end_date'];
          List report = reportData['data'];

          return Container(
            width: double.infinity,
            height: 420,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/New_KFA_Logo.png'),
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Comparable Report for Year $year',
                          style: fonsize15),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Year $year", style: fonsize15),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "(From $startDate To $endDate)",
                                      style: fonsize15,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Row(children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(width: 1, color: Colors.black),
                                  left:
                                      BorderSide(width: 1, color: Colors.black),
                                  right:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(agencyname, style: fonsize15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(width: 1, color: Colors.black),
                                  right:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text("${report.length.toString()} Cases",
                                    style: fonsize15),
                              ),
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        child: Row(children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(width: 1, color: Colors.black),
                                  left:
                                      BorderSide(width: 1, color: Colors.black),
                                  right:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text('Total', style: fonsize15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(width: 1, color: Colors.black),
                                  right:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text("${report.length.toString()} Cases",
                                    style: fonsize15),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Comparable Report for Year $year',
                          style: fonsize15),
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 183,
                        width: (widget.device == 'm') ? 400 : 740,
                        child: Chart(
                          data: [
                            {'genre': 'Year $year', 'value': report.length},
                          ],
                          variables: {
                            'genre': Variable(
                              accessor: (Map map) => map['genre'] as String,
                            ),
                            'value': Variable(
                              accessor: (Map map) => map['value'] as num,
                            ),
                          },
                          marks: [
                            IntervalMark(
                              label: LabelEncode(
                                encoder: (tuple) => Label(
                                  tuple['value'].toString(),
                                ),
                              ),
                            ),
                          ],
                          axes: [
                            Defaults.horizontalAxis,
                            Defaults.verticalAxis,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _getagency() async {
    try {
      var dio = Dio();
      var response = await dio.get(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_agency');

      if (response.statusCode == 200) {
        setState(() {
          agency = response.data;
        });
      } else {
        print('Failed to load agencies: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error loading agencies: $e');
    }
  }

  Future<void> _searchdate() async {
    setState(() {
      isLoading = true;
      _searchreport.clear();
    });

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var dio = Dio();

    List<Map<String, ValueNotifier<String?>>> dateRanges = [
      {'start': fromDatey1, 'end': toDatey1},
      {'start': fromDatey2, 'end': toDatey2},
      {'start': fromDatey3, 'end': toDatey3},
    ];

    for (int i = 0; i < dateRanges.length; i++) {
      var dateRange = dateRanges[i];
      if (dateRange['start']!.value != null &&
          dateRange['end']!.value != null) {
        try {
          var response = await dio.get(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/reportcomparable',
            queryParameters: {
              'start': dateRange['start']!.value,
              'end': dateRange['end']!.value,
              'searchname': agencyname,
            },
            options: Options(headers: headers),
          );

          if (response.statusCode == 200) {
            var data = response.data;
            String year =
                DateTime.parse(dateRange['start']!.value!).year.toString();
            setState(() {
              _searchreport.add({
                'year': year,
                'data': data,
                'start_date': dateRange['start']!.value,
                'end_date': dateRange['end']!.value,
              });
            });
            print('Data for Year $year: ${json.encode(data)}');
          } else {
            print('Error for Year ${i + 1}: ${response.statusMessage}');
          }
        } catch (e) {
          print('Error for Year ${i + 1}: $e');
        }
      }
    }

    setState(() {
      isLoading = false;
    });
  }
}
