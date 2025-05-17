import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class VerbalControllerAdmin extends GetxController {
  @override
  void onInit() {
    // methodVerbalList(0, "");
    // dropdownBank();
    super.onInit();
  }

  var isdrop = false.obs;
  var listBank = [].obs;
  var isActive = false.obs;
  var listVerbals = [].obs;
  var listUnActive = [].obs;
  Future<void> methodVerbalList(
      String startDate, String endDate, String bankName, String search) async {
    try {
      isActive.value = true;
      // print(
      //     'startDate : $startDate\nendDate : $endDate\nbankName : $bankName\nselectIndex : $selectIndex\nusername : $search');
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "start": startDate,
        "end": endDate,
        "bank_name": bankName,
        // "active": selectIndex,
        "search": search,
      });
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/list/count/verbals',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        listVerbals.value = response.data;
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

  // Future<void> listActiveMetod(int index, String bankName) async {
  //   try {
  //     isActive.value = true;
  //     var data = json.encode({
  //       if (index != -1) "index": index,
  //       if (bankName != "") "bank_name": bankName,
  //     });
  //     var dio = Dio();
  //     var response = await dio.request(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/active/users/client',
  //       options: Options(
  //         method: 'POST',
  //       ),
  //       data: data,
  //     );

  //     if (response.statusCode == 200) {
  //       listActive.value = response.data['active'];
  //       listUnActive.value = response.data['nactive'];
  //       // print(json.encode(response.data));
  //     } else {
  //       // print(response.statusMessage);
  //     }
  //   } catch (e) {
  //     // print(e);
  //   } finally {
  //     isActive.value = false;
  //   }
  // }

  // List<Map<dynamic, dynamic>> listBankDrop = <Map<dynamic, dynamic>>[].obs;

  // API Call to fetch bank dropdown
  // Future<void> dropdownBank() async {
  //   try {
  //     isdrop.value = true;

  //     var dio = Dio();
  //     var response = await dio.post(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/dropdown/bank/checks',
  //     );

  //     if (response.statusCode == 200) {
  //       listBank.value = response.data;

  //       // Clear previous entries before adding
  //       listBankDrop.clear();

  //       for (var item in listBank) {
  //         listBankDrop.add(Map<dynamic, dynamic>.from(item));
  //       }
  //       // print(listBankDrop.toString());
  //     } else {
  //       // print("Failed: ${response.statusMessage}");
  //     }
  //   } catch (e) {
  //     // print("Error fetching bank dropdown: $e");
  //   } finally {
  //     isdrop.value = false;
  //   }
  // }
}
