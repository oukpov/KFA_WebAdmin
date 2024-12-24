// vpoint_update_controller.dart

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:web_admin/models/v_point_model.dart';

class VpointUpdateController extends GetxController {
  final vpoint = VpointModel().obs;
  final vpointList = <VpointModel>[].obs;
  final isLoading = false.obs;
  final dateSearchResults = [].obs;
  final searchResults = <VpointModel>[].obs;
  final isSearch = false.obs;
  var page = 0.obs;
  var listsearch = [].obs;
  final url = 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api';
  @override
  void onInit() {
    super.onInit();
    fetchVpoint();
  }

  Future<void> fetchVpoint() async {
    isLoading(true);
    try {
      final response = await http.get(Uri.parse('$url/getvpoint'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          vpointList.value =
              jsonData.map((item) => VpointModel.fromJson(item)).toList();
          if (vpointList.isNotEmpty) {
            vpoint(vpointList.first);
          }
        } else if (jsonData is Map<String, dynamic>) {
          vpoint(VpointModel.fromJson(jsonData));
          vpointList.value = [vpoint.value];
        } else {
          Get.snackbar('Error', 'Invalid data format');
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      print(e);
    } finally {
      isLoading(false);
    }
  }

  Future<void> handleUpdate(VpointModel updatedVpoint) async {
    try {
      isLoading(true);
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var data = json.encode({
        "ID_control": updatedVpoint.iDControl,
        "id_user_control": updatedVpoint.idUserControl,
        "id_user": updatedVpoint.iDControl,
        "count_autoverbal": updatedVpoint.countAutoverbal,
        "create": updatedVpoint.create,
        "expiry": updatedVpoint.expiry,
        "their_plans": updatedVpoint.theirPlans,
        "balance": updatedVpoint.balance,
        "created_verbals": updatedVpoint.createdVerbals
      });

      final response = await http.post(
        Uri.parse('$url/updatevpoint'),
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200) {
        // print(response.body);
        Get.snackbar('Success', 'VPoint updated successfully');
        await fetchVpoint(); // Refresh data after update
      } else {
        // print(response.body);
        Get.snackbar(
            'Error', 'Failed to update VPoint: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      print(e);
    } finally {
      isLoading(false);
    }
  }

  // Future<void> searchphone(String telNum) async {
  //   try {
  //     isSearch.value = true;
  //     var headers = {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json'
  //     };

  //     var dio = Dio();
  //     var response = await dio.request(
  //       'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/searchphone?search=$telNum',
  //       options: Options(
  //         method: 'GET',
  //         headers: headers,
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       listsearch.value = jsonDecode(json.encode(response.data))['data'];
  //     }
  //   } catch (e) {
  //     // print(e);
  //   } finally {
  //     isSearch.value = false;
  //   }
  // }
  var isSearchHistory = false.obs;
  Future<void> searchname(String name) async {
    try {
      isSearchHistory.value = true;
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      var data = '''''';
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/searchphone?search=$name',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        listsearch.value = jsonDecode(json.encode(response.data))['data'];
      } else {
        // print("Test:${json.encode(response.data)}");
      }
    } catch (e) {
      // print(e);
    } finally {
      isSearchHistory.value = false;
    }
  }

  Future<void> handleUpdatetest() async {
    isLoading(true);
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('$url/updatevpoint'));
      request.body = json.encode({
        "ID_control": 269,
        "id_user_control": "202492576717",
        "count_autoverbal": 1000,
        "create": "2024-10-08 00:00:00",
        "expiry": "2024-10-30 00:00:00",
        "their_plans": "30",
        "balance": 0,
        "created_verbals": 5
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        // print(responseBody);
        Get.snackbar('Success', 'Test update successful');
        await fetchVpoint(); // Refresh the data after update
      } else {
        // print(response.reasonPhrase);
        Get.snackbar('Error', 'Test update failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  var historyList = [].obs;
  var isLoadingHistory = false.obs;

  Future<void> fetchHistory() async {
    isLoadingHistory(true);
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/v-point-historyall',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        // Check if response.data is a Map and contains a data field
        if (response.data is Map && response.data['data'] != null) {
          // Extract the list from the data field
          historyList.value = response.data['data'] as List;
        } else {
          // print('Invalid response format: expected Map with data field');
          historyList.value = [];
        }
      } else {
        // print('Error fetching history: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error in fetchHistory: $e');
      historyList.value = [];
    } finally {
      isLoadingHistory(false);
    }
  }

  Future<void> fetchVpointdate(String startDate, String endDate) async {
    isLoading(true);
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      var data = '''''';
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search-vpointhistory?start_date=$startDate&end_date=$endDate',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        // print(json.encode(response.data));
        dateSearchResults.value =
            jsonDecode(json.encode(response.data))['data'];
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      // print(e);
    } finally {
      isLoading(false);
    }
  }
}
