import 'dart:convert';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../models/residencail_model.dart';

class ResidentialController extends GetxController {
  var residential = ResidincialModel().obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchResidential();
  }

  Future<void> fetchResidential() async {
    isLoading(true);
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/map/check_price/listR',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(json.encode(response.data));
        residential.value = ResidincialModel.fromJson(jsonData);
        print("Residential ${residential.value.r}");
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error while getting residential data: $e');
    } finally {
      isLoading(false);
    }
  }
}
