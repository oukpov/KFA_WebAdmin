import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../component/getx._snack.dart';

class SetAdmin extends GetxController {
  var messageText = "".obs;
  var isSet = false.obs;
  Component component = Component();
  Future<void> setAdmin(String id) async {
    try {
      isSet.value = true;
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
        messageText.value = json.encode(response.data);
      } else {
        messageText.value = json.encode(response.data);
      }
      component.handleTap(messageText.value, "", 1);
    } catch (e) {
      // print(e);
    } finally {
      isSet.value = false;
    }
  }
}
