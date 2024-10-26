import 'dart:convert';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../models/commercial_model.dart';

class CommercialController extends GetxController {
  var commercial = ComercialModel().obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCommercial();
  }

  Future<void> fetchCommercial() async {
    isLoading(true);
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/map/check_price/listC',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(json.encode(response.data));
        commercial.value = ComercialModel.fromJson(jsonData);
        print("Commercial ${commercial.value.c}");
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error while getting commercial data: $e');
    } finally {
      isLoading(false);
    }
  }
}
