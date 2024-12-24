import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controller/v_point_controller.dart';
import 'package:intl/intl.dart';
import 'package:web_admin/models/commercial_model.dart';

import '../../../../Widgets/date_range.dart';

class HistoryVPointPage extends StatefulWidget {
  const HistoryVPointPage({super.key});

  @override
  State<HistoryVPointPage> createState() => _HistoryVPointPageState();
}

class _HistoryVPointPageState extends State<HistoryVPointPage> {
  final VpointUpdateController controller = Get.put(VpointUpdateController());
  DateTime? startDate;
  DateTime? endDate;
  final DateFormat dateFormat = DateFormat('dd MMM yyyy');

  void _onDateRangeSelected(DateTime? start, DateTime? end) {
    setState(() {
      startDate = start;
      endDate = end;
    });

    // Now you can use these dates however you need
    if (start != null && end != null) {
      // print(
      //     'Selected date range: ${dateFormat.format(start)} to ${dateFormat.format(end)}');

      // Calculate date difference
      final difference = end.difference(start).inDays;
      // print('Number of days selected: $difference');

      // You can also pass these dates to your API calls or other functions
      // _fetchDataForDateRange(start, end);
    }
  }

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.fetchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'VPoint Transaction History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[50]!, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: const InputDecoration(
                                hintText: 'Enter Username',
                                border: InputBorder.none,
                              ),
                              onSubmitted: (value) {
                                if (value.isNotEmpty) {
                                  controller.searchname(value);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                              controller.fetchVpointdate;
                              if (searchController.text.isNotEmpty) {
                                controller.searchname(searchController.text);
                              } else {
                                controller.fetchHistory();
                              }
                            },
                            icon: const Icon(Icons.search),
                            label: const Text('Search Username'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            width: 400,
                            height: 150,
                            child: SimpleDateRangePicker(
                              onDateRangeSelected: _onDateRangeSelected,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              controller.fetchVpointdate(
                                startDate.toString(),
                                endDate.toString(),
                              );
                            },
                            icon: const Icon(Icons.search),
                            label: const Text('Search Date'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // const SizedBox(height: 20),

              // Summary Cards
              // Container(
              //   height: 100,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: [
              //       _buildSummaryCard(
              //         'Total Transactions',
              //         '${controller.historyList.length}',
              //         Icons.receipt_long,
              //         Colors.blue[800]!,
              //       ),
              //       _buildSummaryCard(
              //         'Total VPoints',
              //         _calculateTotalVPoints(),
              //         Icons.stars,
              //         Colors.orange[800]!,
              //       ),
              //       _buildSummaryCard(
              //         'Last Updated',
              //         _getLastUpdateTime(),
              //         Icons.update,
              //         Colors.green[800]!,
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 20),

              // Main Content
              Expanded(
                child: Obx(() {
                  // Show loading indicator
                  if (controller.isLoadingHistory.value ||
                      controller.isSearchHistory.value ||
                      controller.isLoading.value) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.blue[800]!),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Loading history...',
                            style: TextStyle(color: Colors.blue[800]),
                          ),
                        ],
                      ),
                    );
                  }

                  // Show empty state
                  if ((searchController.text.isEmpty &&
                          controller.historyList.isEmpty) ||
                      (searchController.text.isNotEmpty &&
                          controller.listsearch.isEmpty &&
                          controller.dateSearchResults.isEmpty)) {
                    return _buildEmptyState();
                  }

                  // Show search results or main history
                  List<dynamic> getDisplayList() {
                    // Case 1: Date search is active (both dates are selected)
                    if (startDate != null && endDate != null) {
                      return controller.dateSearchResults;
                    }

                    // Case 2: Text search is active
                    if (searchController.text.isNotEmpty) {
                      return controller.listsearch.isNotEmpty
                          ? controller.listsearch
                          : []; // Return empty list if no search results
                    }

                    // Case 3: Default - show full history
                    return controller.historyList;
                  }

                  final displayList = getDisplayList();
                  return ListView.builder(
                    itemCount: displayList.length,
                    itemBuilder: (context, index) {
                      final history = displayList[index];
                      return _buildHistoryCard(history, index);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> history, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Card(
        elevation: 5,
        shadowColor: Colors.blue.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue[100],
                    child: Icon(Icons.person_outline, color: Colors.blue[800]),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID: ${history['id_user_control'] ?? 'N/A'}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Username: ${history['username'] ?? 'N/A'}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),
              _buildDetailRow(
                Icons.stars_outlined,
                'VPoint Amount',
                '${history['count_autoverbal'] ?? '0'} points',
              ),
              _buildDetailRow(
                Icons.access_time,
                'Transaction Time',
                _formatDateTime(history['updated_at']),
              ),
              _buildDetailRow(
                Icons.note,
                'Transaction Type',
                _getTransactionType(history),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 200,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 100, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No transaction history found',
            style: TextStyle(
              fontSize: 24,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'All your VPoint transactions will appear here',
            style: TextStyle(color: Colors.grey[500]),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              controller.fetchVpointdate;
              if (searchController.text.isNotEmpty) {
                controller.searchname(searchController.text);
              } else {
                controller.fetchHistory();
              }
            },
            icon: const Icon(Icons.search),
            label: const Text('Search'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[600], size: 20),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  String _calculateTotalVPoints() {
    int total = 0;
    for (var history in controller.historyList) {
      total += int.parse(history['count_autoverbal']?.toString() ?? '0');
    }
    return '$total points';
  }

  String _getLastUpdateTime() {
    if (controller.historyList.isEmpty) return 'N/A';
    final lastUpdate = controller.historyList
        .map((h) => DateTime.parse(h['updated_at'] ?? ''))
        .reduce((a, b) => a.isAfter(b) ? a : b);
    return DateFormat('MMM d, y').format(lastUpdate);
  }

  String _formatDateTime(String? dateStr) {
    if (dateStr == null) return 'N/A';
    final date = DateTime.parse(dateStr);
    return DateFormat('MMM d, y').format(date);
  }

  String _getTransactionType(Map<String, dynamic> history) {
    return 'VPoint Purchase'; // You can customize this based on your transaction types
  }
}
