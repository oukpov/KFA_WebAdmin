import 'dart:convert';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../models/khan_model.dart';

class KhanController extends GetxController {
  var khan = <KhanModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchKhan();
  }

  Future<void> fetchKhan() async {
    isLoading(true);
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/khan/list',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(json.encode(response.data));
        khan.value =
            (jsonData as List).map((item) => KhanModel.fromJson(item)).toList();
        print("Khan ${khan}");
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error while getting khan data: $e');
    } finally {
      isLoading(false);
    }
  }
}
