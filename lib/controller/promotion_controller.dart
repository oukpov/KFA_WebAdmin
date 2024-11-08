import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/promotion_model.dart';

class PromotionController extends GetxController {
  var listPromotionWeb = [].obs;
  var isPromotion = true.obs;
  List<String> localPromotionWebData = [];

  @override
  void onInit() {
    super.onInit();
    // fetchPromotionWeb();
  }

  Future<void> fetchPromotionWeb() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get/promotioin/2',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      listPromotionWeb.value = jsonDecode(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  Future<void> localhostPromotionWeb(List<String> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('localhost_proWeb', data);
  }

  Future<void> insertPromotionImage(
      String imagePath, PromotionModel promotion) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };

      var data = dio.FormData.fromMap({
        'files': [await dio.MultipartFile.fromFile(imagePath)],
        'type': '2',
        'title': promotion.title,
        'descrition': promotion.descrition,
        'url': promotion.url,
        'link': promotion.link,
        'createDate': promotion.createDate,
      });

      var dioClient = dio.Dio();
      var response = await dioClient.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Add/promotioin',
        options: dio.Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        // Refresh promotion list after successful upload
        await fetchPromotionWeb();
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> deletePromotionImage(String id) async {
    // Implement delete logic here
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var data = json.encode({"id": id});
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/deletepromotion',
      options: Options(
        method: 'DELETE',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }
}
