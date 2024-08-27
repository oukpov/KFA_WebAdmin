import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ControllerAPI extends GetxController {
  var isProperty = true.obs;
  var isProvince = true.obs;
  List<Map<dynamic, dynamic>> listvalueProperty = [];
  List<Map<dynamic, dynamic>> listvalueProvince = [];
  List listProperty = [].obs;
  List listProvince = [].obs;
  Future<void> propertyAPI() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/properties_dropdown',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        listProperty = jsonDecode(json.encode(response.data));
        for (int i = 0; i < listProperty.length; i++) {
          listvalueProperty.add(listProperty[i]);
        }
      }
    } catch (e) {
      // print('Error occurred: $e');
    } finally {
      isProperty.value = false;
    }
  }

  Future<void> provinceAPI() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/provinceModel',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        listProvince = jsonDecode(json.encode(response.data));
        for (int i = 0; i < listProvince.length; i++) {
          listvalueProvince.add(listProvince[i]);
        }
      }
    } catch (e) {
      // print('Error occurred: $e');
    } finally {
      isProvince.value = false;
    }
  }
}
