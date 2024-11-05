import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/verbal_controller.dart';
import '../../../../controller/user_controller.dart';

class ReportVerbalAllUserForAdminPage extends StatefulWidget {
  ReportVerbalAllUserForAdminPage({Key? key, required this.id})
      : super(key: key);
  final int id;

  @override
  State<ReportVerbalAllUserForAdminPage> createState() =>
      _ReportVerbalAllUserForAdminPageState();
}

class _ReportVerbalAllUserForAdminPageState
    extends State<ReportVerbalAllUserForAdminPage> {
  final VerbalController verbalController = Get.put(VerbalController());
  final UserController userController = Get.put(UserController());
  final RxList<Map<String, dynamic>> listBool = <Map<String, dynamic>>[].obs;
  List<Map<String, dynamic>> allReports = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      reportVerbal();
    });
  }

  Future reportVerbal() async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var data = json.encode({"verbal_landid": widget.id});
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/reportverbal',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        setState(() {
          // Convert the dynamic list to List<Map<String, dynamic>>
          allReports = List<Map<String, dynamic>>.from(
              (jsonDecode(json.encode(response.data)) as List)
                  .map((item) => Map<String, dynamic>.from(item)));
          isLoading = false;
        });
      } else {
        print(response.statusMessage);
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verbal Reports ${allReports.length}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue[900],
        elevation: 0,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : allReports.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.description_outlined,
                          size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('No verbal reports found',
                          style: TextStyle(fontSize: 18, color: Colors.grey)),
                    ],
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue[900]!, Colors.white],
                      stops: const [0.0, 0.3],
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.blue[900],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.description,
                                      color: Colors.white),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Total Reports: ${allReports.length}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Scrollbar(
                            thumbVisibility: true,
                            child: Scrollbar(
                              thumbVisibility: true,
                              notificationPredicate: (notification) =>
                                  notification.depth == 1,
                              child: SingleChildScrollView(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    headingRowColor: MaterialStateProperty.all(
                                        Colors.blue[50]),
                                    dataRowHeight: 65,
                                    columns: const [
                                      DataColumn(
                                        label: Text(
                                          'No',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Agency',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Min Value',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Max Value',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Owner',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Contact',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Bank Name',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Bank Branch',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Created Date',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Location',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                    rows: List.generate(
                                      allReports.length,
                                      (index) => DataRow(
                                        color: MaterialStateProperty
                                            .resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                            if (index % 2 == 0)
                                              return Colors.grey[50];
                                            return Colors.white;
                                          },
                                        ),
                                        cells: [
                                          DataCell(
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.blue[900],
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                '${index + 1}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataCell(Text(allReports[index]
                                                  ['agency'] ??
                                              'N/A')),
                                          DataCell(Text(allReports[index]
                                                      ['verbal_land_minvalue']
                                                  ?.toString() ??
                                              'N/A')),
                                          DataCell(Text(allReports[index]
                                                      ['verbal_land_maxvalue']
                                                  ?.toString() ??
                                              'N/A')),
                                          DataCell(Text(
                                              '${allReports[index]['first_name'] ?? ''} ${allReports[index]['last_name'] ?? ''}'
                                                  .trim())),
                                          DataCell(Text(allReports[index]
                                                  ['tel_num'] ??
                                              'N/A')),
                                          DataCell(Text(allReports[index]
                                                  ['bank_name'] ??
                                              'N/A')),
                                          DataCell(Text(allReports[index]
                                                  ['bank_branch_name'] ??
                                              'N/A')),
                                          DataCell(Text(allReports[index]
                                                  ['verbal_created_date'] ??
                                              'N/A')),
                                          DataCell(Text(allReports[index]
                                                  ['verbal_address'] ??
                                              'N/A')),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
