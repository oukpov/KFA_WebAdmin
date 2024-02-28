// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Option extends GetxController {
  var listOption = [].obs;

  Future<void> moreOPTion(query) async {
    try {
      final response = await http.get(Uri.parse(
          // 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_all_Sale_b/$property_type_id_province'));
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_all_Sale_all_2'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        listOption.value = jsonBody;
        print(listOption.toString());
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }
}
