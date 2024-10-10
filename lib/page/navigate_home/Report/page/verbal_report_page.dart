import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/agency_controller.dart';
import '../../../../models/agnecy_model.dart';
import 'package:dio/dio.dart';
import 'inputdateshow.dart';
import 'package:graphic/graphic.dart';

class VerbalReportPage extends StatefulWidget {
  const VerbalReportPage({Key? key, required this.device}) : super(key: key);
  final String device;

  @override
  _VerbalReportPageState createState() => _VerbalReportPageState();
}

class _VerbalReportPageState extends State<VerbalReportPage> {
  final AgencyController _agencyController = Get.put(AgencyController());
  final fromDatey1 = ValueNotifier<String?>(null);
  final toDatey1 = ValueNotifier<String?>(null);
  final fromDatey2 = ValueNotifier<String?>(null);
  final toDatey2 = ValueNotifier<String?>(null);
  final fromDatey3 = ValueNotifier<String?>(null);
  final toDatey3 = ValueNotifier<String?>(null);
  var sizebox10w = const SizedBox(width: 100);
  var fonsize15 = const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  AgencyModel? selectedAgency;
  List<Map<String, dynamic>> _searchreport = [];
  bool isLoading = false;
  var sizebox10h = const SizedBox(height: 10);

  @override
  void initState() {
    super.initState();
    _agencyController.fetchAgencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Verbal by Year'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: (widget.device == 'm')
              ? _buildMobileLayout()
              : _buildDesktopLayout(),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildAgencyDropdown(),
        sizebox10h,
        if (selectedAgency != null) _buildAgencyDetails(),
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
        _buildSearchButton(),
        sizebox10h,
        _buildReportSection(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Verbal Report Year", style: fonsize15),
        const SizedBox(height: 16),
        Row(
          children: [
            Text("Agency", style: fonsize15),
            const SizedBox(width: 130),
            _buildAgencyDropdown(),
          ],
        ),
        const SizedBox(height: 16),
        if (selectedAgency != null) _buildAgencyDetails(),
        const SizedBox(height: 16),
        _buildDateInputs('From Year 1', 'To Year 1', fromDatey1, toDatey1),
        const SizedBox(height: 16),
        _buildDateInputs('From Year 2', 'To Year 2', fromDatey2, toDatey2),
        const SizedBox(height: 16),
        _buildDateInputs('From Year 3', 'To Year 3', fromDatey3, toDatey3),
        const SizedBox(height: 24),
        _buildSearchButton(),
        const SizedBox(height: 24),
        _buildReportSection(),
      ],
    );
  }

  Widget _buildAgencyDropdown() {
    return Obx(() {
      if (_agencyController.isLoading.value) {
        return const CircularProgressIndicator();
      } else {
        return SizedBox(
          height: 35,
          width: widget.device == 'm'
              ? MediaQuery.of(context).size.width * 0.5
              : 220,
          child: DropdownButtonFormField<AgencyModel>(
            value: selectedAgency,
            items: _agencyController.agencies
                .map<DropdownMenuItem<AgencyModel>>(
                  (agency) => DropdownMenuItem<AgencyModel>(
                    value: agency,
                    child: Text(
                      agency.agenttypeName ?? 'NoneSelected',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: MediaQuery.textScaleFactorOf(context) * 13,
                          height: 1),
                    ),
                  ),
                )
                .toList(),
            onChanged: (newValue) {
              setState(() {
                selectedAgency = newValue;
                if (selectedAgency != null) {
                  _searchdate(); // Trigger search when agency is selected
                }
              });
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              fillColor: Colors.white,
              filled: true,
              labelText: 'Select Agency',
              hintText: 'Select Agency',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.textScaleFactorOf(context) * 12),
              helperStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.textScaleFactorOf(context) * 12),
              prefixIcon: const SizedBox(width: 7),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.blue),
                borderRadius: BorderRadius.circular(5.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.red),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.red),
              ),
            ),
            isExpanded: true,
          ),
        );
      }
    });
  }

  Widget _buildAgencyDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Selected Agency Details:', style: fonsize15),
        Text('ID: ${selectedAgency!.agenttypeId}'),
        Text('Name: ${selectedAgency!.agenttypeName}'),
        Text('Phone: ${selectedAgency!.agentTypePhone}'),
        Text('Email: ${selectedAgency!.agentTypeEmail}'),
      ],
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

  Widget _buildSearchButton() {
    return ElevatedButton(
      child: const Text("Search"),
      onPressed: () {
        if (selectedAgency == null) {
          Get.snackbar('Error', 'Please select an agency and date');
          return;
        }
        _searchdate();
      },
    );
  }

  Widget _buildReportSection() {
    if (isLoading) {
      return const CircularProgressIndicator();
    } else if (_searchreport.isNotEmpty) {
      return _buildReportWidget();
    } else {
      return const Text("No data available");
    }
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
                      Text('Verbal Report for Year $year', style: fonsize15),
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
                                    child: Text(selectedAgency!.agenttypeName!,
                                        style: fonsize15),
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
                      Text('Verbal Report for Year $year', style: fonsize15),
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
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/reportverbal',
            queryParameters: {
              'start': dateRange['start']!.value,
              'end': dateRange['end']!.value,
              'searchname': selectedAgency!.agenttypeName,
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
