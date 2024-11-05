import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/page/navigate_home/Report/page/reportverbal_all_user_for_admin_page.dart';
import '../../../../controller/user_controller.dart';
import '../../../../controller/verbal_controller.dart';

class ReportVerbalUserForAdmin extends StatefulWidget {
  ReportVerbalUserForAdmin(
      {Key? key, required this.id, required this.tel_num, required this.agency})
      : super(key: key);
  final String id;
  final String tel_num;
  final String agency;

  @override
  State<ReportVerbalUserForAdmin> createState() =>
      _ReportVerbalUserForAdminState();
}

@override
class _ReportVerbalUserForAdminState extends State<ReportVerbalUserForAdmin> {
  final VerbalController verbalController = Get.put(VerbalController());
  List<Map<String, dynamic>> verbalReport = [];
  final UserController userController = Get.put(UserController());
  bool isLoading = true;

  final RxList<Map<String, dynamic>> listBool = <Map<String, dynamic>>[].obs;

  @override
  void initState() {
    super.initState();
    checkPrice();
  }

  Future<void> checkPrice() async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var data = json.encode({"verbal_user": int.parse(widget.id)});
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/checkPrice/Agent',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        setState(() {
          verbalReport = List<Map<String, dynamic>>.from(
              jsonDecode(json.encode(response.data))['data']);
          isLoading = false;
        });
        print("verbalReport: $verbalReport");
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
        title: const Text(
          'Verbal Reports',
          style: TextStyle(
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
          : verbalReport.isEmpty
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
                                    'Total Reports: ${verbalReport.length}',
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
                                          'Verbal ID',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Property Type',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Road',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Date',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Address',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Longitude',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Latitude',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                    rows: List.generate(
                                      verbalReport.length,
                                      (index) => DataRow(
                                        onSelectChanged: (_) {
                                          print(
                                              "verbalReport ${verbalReport[index]['verbal_id']}");
                                          Get.to(() =>
                                              ReportVerbalAllUserForAdminPage(
                                                id: int.parse(
                                                    verbalReport[index]
                                                            ['verbal_id']
                                                        .toString()),
                                              ));
                                        },
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
                                          DataCell(Text(verbalReport[index]
                                                  ['verbal_id'] ??
                                              'N/A')),
                                          DataCell(Text(verbalReport[index]
                                                  ['type_value'] ??
                                              'N/A')),
                                          DataCell(Text(verbalReport[index]
                                                  ['road'] ??
                                              'N/A')),
                                          DataCell(Text(verbalReport[index]
                                                  ['verbal_date'] ??
                                              'N/A')),
                                          DataCell(Text(verbalReport[index]
                                                  ['verbal_address'] ??
                                              'N/A')),
                                          DataCell(Text(verbalReport[index]
                                                  ['latlong_log'] ??
                                              'N/A')),
                                          DataCell(Text(verbalReport[index]
                                                  ['latlong_la'] ??
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
