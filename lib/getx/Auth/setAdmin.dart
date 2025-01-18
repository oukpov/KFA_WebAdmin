import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../component/getx._snack.dart';

class SetAdmin extends GetxController {
  @override
  void onInit() {
    fetchListAdmin(10, 1);
    super.onInit();
  }

  var messageText = "".obs;
  var isSet = false.obs;
  var listAdmin = [].obs;
  var perPage = 0.obs;
  var lastPage = 0.obs;
  var to = 0.obs;
  var total = 0.obs;

  Component component = Component();
  Future<void> fetchListAdmin(int perPages, int pages) async {
    try {
      isSet.value = true;
      var dio = Dio();
      var data = json.encode({"perPage": perPages, "page": pages});
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/fetch/list/admin',
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        listAdmin.value = response.data['data'];
        perPage.value = int.parse(response.data['perPage'].toString());
        lastPage.value = int.parse(response.data['lastPage'].toString());
        to.value = int.parse(response.data['to'].toString());
        total.value = int.parse(response.data['total'].toString());
      } else {
        component.handleTap("Error Please try again",
            "if still like this please contact us", 1);
      }
    } catch (e) {
      // print(e);
    } finally {
      isSet.value = false;
    }
  }

  Future<void> setAdmin(String id) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var data = json.encode({"control_user": id});
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/set/client/admin',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        await fetchListAdmin(10, 1);
        messageText.value = json.encode(response.data);
      } else {
        messageText.value = json.encode(response.data);
      }
      component.handleTap(messageText.value, "", 1);
    } catch (e) {
      // print(e);
    }
  }
}
