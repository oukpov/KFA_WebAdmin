import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../component/getx._snack.dart';

class ControllerUpdate extends GetxController {
  @override
  void onInit() {
    systemMethod();
    // checkUpdate(81.toString());
    super.onInit();
  }

  var listupdates = [].obs;
  var checkUpdateNew = 0.obs;
  var checkS = false.obs;
  Future<void> checkUpdateDone(String id) async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/updateNewS/Admin/$id',
      options: Options(
        method: 'POST',
      ),
    );

    if (response.statusCode == 200) {
      listupdates.value = response.data;
      checkUpdateNew.value = int.parse("${listupdates[0]['update_new'] ?? 0}");

      // print(list.toString());
    } else {
      // print(response.statusMessage);
    }
  }

  Future<void> checkUpdate(String id) async {
    print('=======> id : $id');
    try {
      checkS.value = true;
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/updateNew/Admin/$id',
        options: Options(
          method: 'POST',
        ),
      );

      if (response.statusCode == 200) {
        listupdates.value = response.data;
        checkUpdateNew.value =
            int.parse("${listupdates[0]['update_new'] ?? 0}");
      }
    } catch (e) {
      // print(e);
    } finally {
      checkS.value = false;
    }
  }

  Component component = Component();
  Future<void> checkUpdateAll(BuildContext context) async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/updateNewsAdmin/All',
      options: Options(
        method: 'POST',
      ),
    );

    if (response.statusCode == 200) {
      component.handleTap("Done!", "Notification to Agent Update New", 3);
      Get.back();
    } else {
      // print(response.statusMessage);
    }
  }

  Future<void> checkUpdateClientAll(BuildContext context) async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/updateNews/All',
      options: Options(
        method: 'POST',
      ),
    );

    if (response.statusCode == 200) {
      component.handleTap("Done!", "Notification to Client Update New", 3);
      Get.back();
    } else {
      // print(response.statusMessage);
    }
  }

  Future<void> checkOFFSystemAll(
      int id, int check, BuildContext context) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"id": id, "checks": check});
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/checkAllow/off',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      component.handleTap("Done!", "Update Successfuly", 3);
      Get.back();
    } else {
      // print(response.statusMessage);
    }
  }

  var listSystem = [].obs;
  var isSystem = false.obs;
  Future<void> systemMethod() async {
    try {
      isSystem.value = true;
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/list/systemKFA',
        options: Options(
          method: 'POST',
        ),
      );

      if (response.statusCode == 200) {
        listSystem.value = response.data;
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    } finally {
      isSystem.value = false;
    }
  }
}
