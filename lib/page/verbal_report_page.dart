import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/verbal_controller.dart';
import '../models/verbal_model.dart';

class ReportController extends GetxController {
  final VerbalController _verbalController = VerbalController();
  final RxList<verbal_model> reports = <verbal_model>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchReports();
  }

  Future<void> fetchReports() async {
    try {
      isLoading.value = true;
      final fetchedReports = await _verbalController.fetchVerbalReports();
      reports.assignAll(fetchedReports);
    } catch (error) {
      Get.snackbar('Error', 'Failed to fetch reports: $error');
    } finally {
      isLoading.value = false;
    }
  }
}

class VerbalReportPage extends StatelessWidget {
  final ReportController controller = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verbal Reports'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.fetchReports,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.reports.isEmpty) {
          return const Center(child: Text('No reports found'));
        } else {
          return ListView.builder(
            itemCount: controller.reports.length,
            itemBuilder: (context, index) {
              final report = controller.reports[index];
              return ListTile(
                title: Text('Verbal ID: ${report.verbalId ?? 'N/A'}'),
                subtitle: Text('Owner: ${report.verbalUser ?? 'N/A'}'),
                onTap: () => _showReportDetails(context, report),
              );
            },
          );
        }
      }),
    );
  }

  void _showReportDetails(BuildContext context, verbal_model report) {
    Get.dialog(
      AlertDialog(
        title: const Text('Report Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Verbal ID: ${report.verbalId ?? 'N/A'}'),
              Text('Owner: ${report.verbalUser ?? 'N/A'}'),
              Text('Address: ${report.verbalAddress ?? 'N/A'}'),
              Text('Contact: ${report.verbalContact ?? 'N/A'}'),
              Text('Date: ${report.verbalDate ?? 'N/A'}'),
              Text('Bank: ${report.bankName ?? 'N/A'}'),
              Text('Bank Officer: ${report.verbalBankOfficer ?? 'N/A'}'),
              Text('Status ID: ${report.verbalStatusId ?? 'N/A'}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Close'),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }
}
