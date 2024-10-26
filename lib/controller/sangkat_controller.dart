import 'dart:convert';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../models/sangkat_model.dart';

class SangkatController extends GetxController {
  var sangkat = <SangkatModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSangkat();
  }

  Future<void> fetchSangkat() async {
    isLoading(true);
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/sangkat/list',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(json.encode(response.data));
        sangkat.value = (jsonData as List)
            .map((item) => SangkatModel.fromJson(item))
            .toList();
        print("Sangkat ${sangkat}");
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error while getting sangkat data: $e');
    } finally {
      isLoading(false);
    }
  }
}
