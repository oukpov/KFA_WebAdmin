import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controller/v_point_controller.dart';
import 'package:intl/intl.dart';

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
    controller.fetchHistory().then((_) {
      print("History fetched");
      print("History list length: ${controller.historyList.length}");
      print("History list content: ${controller.historyList}");
    }).catchError((error) {
      print("Error fetching history: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VPoint Transaction History',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue[800],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Add filter functionality
              _showFilterDialog(context);
            },
          ),
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
              // Enhanced Search bar with animation
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: 500,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by username, ID or phone number',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.blue[800]),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        searchController.clear();
                        // Reset search results
                      },
                    ),
                  ),
                  onChanged: (value) {
                    // Implement search with debounce
                    _onSearchChanged(value);
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Transaction Summary Cards
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

              // Enhanced History list with animations
              Expanded(
                child: Obx(() {
                  if (controller.isLoadingHistory.value) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.blue[800]!),
                          ),
                          SizedBox(height: 16),
                          Text('Loading history...',
                              style: TextStyle(color: Colors.blue[800])),
                        ],
                      ),
                    );
                  }

                  if (controller.historyList.isEmpty) {
                    return _buildEmptyState();
                  }

                  return ListView.builder(
                    itemCount: controller.historyList.length,
                    itemBuilder: (context, index) {
                      final history = controller.historyList[index];
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
            Text(title,
                style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            Text(value,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
              primary: Colors.blue[800],
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
                        'ID: ${history['user_id'] ?? 'N/A'}',
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

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'N/A';
    final date = DateTime.parse(dateStr);
    return DateFormat('MMM d, y').format(date);
  }

  String _formatDateTime(String? dateStr) {
    if (dateStr == null) return 'N/A';
    final date = DateTime.parse(dateStr);
    return DateFormat('MMM d, y HH:mm:ss').format(date);
  }

  String _getTransactionType(Map<String, dynamic> history) {
    // Implement your logic to determine transaction type
    return 'VPoint Purchase';
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter Transactions'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Add your filter options here
            ListTile(
              title: Text('Date Range'),
              trailing: Icon(Icons.calendar_today),
              onTap: () {
                // Implement date range picker
              },
            ),
            ListTile(
              title: Text('Transaction Type'),
              trailing: Icon(Icons.filter_list),
              onTap: () {
                // Implement transaction type filter
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Apply filters
              Navigator.pop(context);
            },
            child: Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _onSearchChanged(String value) {
    // Implement debounced search
    // You might want to add a timer to avoid too frequent API calls
    if (value.isEmpty) {
      controller.fetchHistory();
    } else {
      // Implement search logic
    }
  }
}
