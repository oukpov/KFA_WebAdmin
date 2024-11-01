import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/verbal_controller.dart';
import '../../../../controller/user_controller.dart';

class ReportVerbalAllUserForAdminPage extends StatelessWidget {
  ReportVerbalAllUserForAdminPage(
      {Key? key, required this.index, required this.approved_name})
      : super(key: key);
  final List<dynamic> index;
  final String approved_name;

  final VerbalController verbalController = Get.put(VerbalController());
  final UserController userController = Get.put(UserController());
  final RxList<Map<String, dynamic>> listBool = <Map<String, dynamic>>[].obs;
  final RxInt totalReports = 0.obs;
  final RxList<Map<String, dynamic>> allReports = <Map<String, dynamic>>[].obs;
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();

  // Modified to use async/await and wait for all reports to be fetched
  Future<void> calculateTotalReports() async {
    int total = 0;
    allReports.clear();

    // Wait for all reports to be fetched before updating UI
    for (var user in index) {
      await verbalController.fetchVerbalReportById(user['userId']);
      total += verbalController.list.length;
      for (var report in verbalController.list) {
        allReports.add({
          ...report as Map<String, dynamic>,
          'tel_num': user['tel_num'],
          'agency': approved_name
        });
      }
    }

    totalReports.value = total;
  }

  @override
  Widget build(BuildContext context) {
    // Call calculateTotalReports only once when widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calculateTotalReports();
    });

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
      body: Obx(() {
        if (verbalController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (allReports.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.description_outlined, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text('No verbal reports found',
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
              ],
            ),
          );
        } else {
          return Container(
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
                  padding: const EdgeInsets.all(16),
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
                            const Icon(Icons.description, color: Colors.white),
                            const SizedBox(width: 8),
                            Text(
                              'Total Reports: ${totalReports.value}',
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
                    margin: const EdgeInsets.all(16),
                    child: Scrollbar(
                      controller: _verticalController,
                      thumbVisibility: true,
                      child: Scrollbar(
                        controller: _horizontalController,
                        thumbVisibility: true,
                        notificationPredicate: (notification) =>
                            notification.depth == 1,
                        child: SingleChildScrollView(
                          controller: _verticalController,
                          child: SingleChildScrollView(
                            controller: _horizontalController,
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              headingRowColor:
                                  MaterialStateProperty.all(Colors.blue[50]),
                              dataRowHeight: 65,
                              columns: const [
                                DataColumn(
                                  label: Text(
                                    'No',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Agency',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Min Value',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Max Value',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Owner',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Contact',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Bank Name',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Bank Branch',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Created Date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Location',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                              rows: List.generate(
                                allReports.length,
                                (index) => DataRow(
                                  color:
                                      MaterialStateProperty.resolveWith<Color?>(
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
                                    DataCell(Text(
                                        allReports[index]['agency'] ?? 'N/A')),
                                    DataCell(Text(allReports[index]
                                                ['verbal_land_minvalue']
                                            ?.toInt()
                                            ?.toString() ??
                                        'N/A')),
                                    DataCell(Text(allReports[index]
                                                ['verbal_land_maxvalue']
                                            ?.toInt()
                                            ?.toString() ??
                                        'N/A')),
                                    DataCell(Text(allReports[index]
                                                ['first_name'] +
                                            ' ' +
                                            allReports[index]['last_name'] ??
                                        'N/A')),
                                    DataCell(Text(
                                        allReports[index]['tel_num'] ?? 'N/A')),
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
          );
        }
      }),
    );
  }
}
