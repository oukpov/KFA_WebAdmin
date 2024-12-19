import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controller/v_point_controller.dart';
import 'package:intl/intl.dart';
import 'package:web_admin/models/commercial_model.dart';

class HistoryVPointPage extends StatefulWidget {
  @override
  State<HistoryVPointPage> createState() => _HistoryVPointPageState();
}

class _HistoryVPointPageState extends State<HistoryVPointPage> {
  final VpointUpdateController controller = Get.put(VpointUpdateController());
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
        title: const Text(
          'VPoint Transaction History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[800],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => controller.fetchHistory(),
          ),
          const SizedBox(width: 10),
        ],
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
                      width: 500,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
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
                                  controller.searchphone(value);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                              if (searchController.text.isNotEmpty) {
                                controller.searchphone(searchController.text);
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
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Summary Cards
              Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildSummaryCard(
                      'Total Transactions',
                      '${controller.historyList.length}',
                      Icons.receipt_long,
                      Colors.blue[800]!,
                    ),
                    _buildSummaryCard(
                      'Total VPoints',
                      _calculateTotalVPoints(),
                      Icons.stars,
                      Colors.orange[800]!,
                    ),
                    _buildSummaryCard(
                      'Last Updated',
                      _getLastUpdateTime(),
                      Icons.update,
                      Colors.green[800]!,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Main Content
              Expanded(
                child: Obx(() {
                  // Show loading indicator
                  if (controller.isLoadingHistory.value ||
                      controller.isSearchHistory.value) {
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
                          controller.listsearch.isEmpty)) {
                    return _buildEmptyState();
                  }

                  // Show search results or main history
                  final displayList = searchController.text.isEmpty
                      ? controller.historyList
                      : controller.listsearch;

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
            onPressed: () => controller.fetchHistory(),
            icon: Icon(Icons.refresh),
            label: Text('Refresh'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
    return DateFormat('MMM d, y HH:mm:ss').format(date);
  }

  String _getTransactionType(Map<String, dynamic> history) {
    return 'VPoint Purchase'; // You can customize this based on your transaction types
  }
}
