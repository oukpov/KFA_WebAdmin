import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/getx/component/getx._snack.dart';

class AllowAgent extends GetxController {
  @override
  void onInit() {
    listAgentFunction(1, false, "");
    super.onInit();
  }

  var perPage = 0.obs;
  var lastPage = 0.obs;
  var to = 0.obs;
  var total = 0.obs;
  var listAgent = [].obs;
  var isAgent = false.obs;
  Future<void> listAgentFunction(
      int page, bool search, String searchText) async {
    try {
      isAgent.value = true;
      var dio = Dio();
      var data = (search == false)
          ? json.encode({"page": page, "perPage": 10})
          : json.encode({"username": searchText});

      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/fetch/listAgent',
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        perPage.value = response.data['perPage'];
        lastPage.value = response.data['lastPage'];
        to.value = response.data['to'];
        total.value = response.data['total'];
        listAgent.value = response.data['data'];
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    } finally {
      isAgent.value = false;
    }
  }

  Component component = Component();
  Future<void> allowAgent(
      List listUsers, int option, String type, int index) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "agency": listUsers[index]['agency'],
      "type": type,
      "option": option,
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/allow/agent/option',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      Get.snackbar(
        "Done!",
        "Name : ${listUsers[index]['username']}, Option : $type",
        colorText: Colors.black,
        padding:
            const EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
        borderColor: const Color.fromARGB(255, 48, 47, 47),
        borderWidth: 1.0,
        borderRadius: 5,
        duration: const Duration(seconds: 1),
        backgroundColor: const Color.fromARGB(255, 235, 242, 246),
        icon: const Icon(Icons.add_alert),
      );
    } else {
      // print(response.statusMessage);
    }
  }
}
