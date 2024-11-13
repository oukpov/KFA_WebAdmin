import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/about_us_model.dart';

class AboutUsController extends GetxController {
  var isLoading = false.obs;
  var aboutUsData = AboutUsModel().obs;
  List<AboutUsModel> aboutUsList = [];

  @override
  void onInit() {
    fetchAboutUsData();
    super.onInit();
  }

  Future<void> fetchAboutUsData() async {
    try {
      isLoading(true);
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };

      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/social_media/get',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        aboutUsData.value = AboutUsModel.fromJson(response.data);
        aboutUsList = jsonDecode(json.encode(response.data));
        print("aboutUsList: $aboutUsList");
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error while getting data: $e');
    } finally {
      isLoading(false);
    }
  }
}
