import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ActiveController extends GetxController {
  @override
  void onInit() {
    listActiveMetod(0, "");
    dropdownBank();
    super.onInit();
  }

  var isdrop = false.obs;
  var listBank = [].obs;
  var isActive = false.obs;
  var listActive = [].obs;
  var listUnActive = [].obs;
  Future<void> listActiveMetod(int index, String bankName) async {
    try {
      isActive.value = true;
      var data = json.encode({
        if (index != -1) "index": index,
        if (bankName != "") "bank_name": bankName,
      });
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/active/users/client',
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        listActive.value = response.data['active'];
        listUnActive.value = response.data['nactive'];
        // print(json.encode(response.data));
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    } finally {
      isActive.value = false;
    }
  }

  List<Map<dynamic, dynamic>> listBankDrop = <Map<dynamic, dynamic>>[].obs;

  // API Call to fetch bank dropdown
  Future<void> dropdownBank() async {
    try {
      isdrop.value = true;

      var dio = Dio();
      var response = await dio.post(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/dropdown/bank/checks',
      );

      if (response.statusCode == 200) {
        listBank.value = response.data;

        // Clear previous entries before adding
        listBankDrop.clear();

        for (var item in listBank) {
          listBankDrop.add(Map<dynamic, dynamic>.from(item));
        }
        // print(listBankDrop.toString());
      } else {
        // print("Failed: ${response.statusMessage}");
      }
    } catch (e) {
      // print("Error fetching bank dropdown: $e");
    } finally {
      isdrop.value = false;
    }
  }
}
