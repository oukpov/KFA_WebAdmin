import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class OptionHome extends GetxController {
  @override
  void onInit() {
    allFunction();

    super.onInit();
  }

  var isVerbal = false.obs;
  var countVerbals = "".obs;
  var countAutoVs = "".obs;
  var countAllUsers = "".obs;
  var listAll = [].obs;
  RxMap<String, double> dataMap = <String, double>{}.obs;

  Future<void> allFunction() async {
    try {
      // Uncomment when you want to execute these functions
      // await countVerbal();
      // await countAutoVerbal();

      await countVerbal();
      await countAutoVerbal();
      await countUsers();
      await converMap();
    } catch (e) {
      // print(e);
    } finally {
      isVerbal.value = false;
    }
  }

  Future<void> converMap() async {
    listAll.value = [
      {
        'name': 'All Client (${countAllUsers.value})',
        'value': countAllUsers.value
      },
      {
        'name': 'All Verbals (${countVerbals.value})',
        'value': countVerbals.value
      },
      {
        'name': 'All Auto Verbals (${countAutoVs.value})',
        'value': countAutoVs.value
      },
      {'name': 'All Agents (N/A)', 'value': "0"},
      {'name': 'VPoint Used (N/A)', 'value': "0"},
      {'name': 'Client Top Up (N/A)', 'value': "0"},
      {'name': 'VPoint Client Used (N/A)', 'value': "0"},
      {'name': 'All Partner (N/A)', 'value': "0"},
    ];
    for (var element in listAll) {
      String name = element['name'].toString();
      double value = double.parse(element['value'].toString());
      dataMap[name] = value;
    }
  }

  Future<void> countAutoVerbal() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/count/AllAuto',
      options: Options(
        method: 'POST',
      ),
    );

    if (response.statusCode == 200) {
      countAutoVs.value = response.data.toString();
      // print(countV);
    }
  }

  Future<void> countVerbal() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/verbal/counts',
      options: Options(
        method: 'POST',
      ),
    );

    if (response.statusCode == 200) {
      countVerbals.value = response.data.toString();
      // print(countV);
    }
  }

  Future<void> countUsers() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Auth/counts',
      options: Options(
        method: 'POST',
      ),
    );

    if (response.statusCode == 200) {
      countAllUsers.value = response.data.toString();
      // print(countV);
    }
  }
}