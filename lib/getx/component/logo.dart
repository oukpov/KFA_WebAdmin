import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogoImageKFA extends GetxController {
  @override
  void onInit() {
    super.onInit();
    imageLogo();
    imagePDF();
  }

  List<String> imageLogoKFAData = [];
  List<String> imagePDFKFAData = [];
  var imageLogoKFA = "".obs;
  var imagePDFKFA = "".obs;
  var listImageLogoKFA = [].obs;
  var listImagePDFKFA = [].obs;
  var isImageLogoKFA = false.obs;
  var isImagePDFKFA = false.obs;
  Future<void> imageLogo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    imageLogoKFAData = prefs.getStringList('localhost_Imagelogo') ?? [];
    listImageLogoKFA.value = imageLogoKFAData
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();
    if (listImageLogoKFA.isEmpty) {
      try {
        var dio = Dio();
        var response = await dio.request(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get/pdf/20',
          options: Options(
            method: 'GET',
          ),
        );

        if (response.statusCode == 200) {
          List<dynamic> responseData = listImageLogoKFA.value = response.data;
          imageLogoKFA.value = listImageLogoKFA[0]['image'].toString();
          imageLogoKFAData =
              responseData.map((item) => json.encode(item)).toList();
          localhostListLogo(imageLogoKFAData);
        }
      } catch (e) {
        // print(e);
      } finally {
        isImageLogoKFA.value = false;
      }
    } else {
      isImageLogoKFA.value = false;
      imageLogoKFA.value = listImageLogoKFA[0]['image'].toString();
    }
  }

  Future<void> imagePDF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    imagePDFKFAData = prefs.getStringList('localhost_ImageKFA') ?? [];
    listImagePDFKFA.value = imagePDFKFAData
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();
    if (listImagePDFKFA.isEmpty) {
      try {
        var dio = Dio();
        var response = await dio.request(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get/pdf/21',
          options: Options(
            method: 'GET',
          ),
        );

        if (response.statusCode == 200) {
          List<dynamic> responseData = listImagePDFKFA.value = response.data;
          imagePDFKFA.value = responseData[0]['image'].toString();
          imageLogoKFAData =
              responseData.map((item) => json.encode(item)).toList();
          localhostListKFA(imageLogoKFAData);
        }
      } catch (e) {
        // print(e);
      } finally {
        isImagePDFKFA.value = false;
      }
    } else {
      isImagePDFKFA.value = false;
      imagePDFKFA.value = listImagePDFKFA[0]['image'].toString();
    }
  }

  localhostListLogo(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('localhost_Imagelogo', list);
    listImageLogoKFA.value = list
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();
  }

  localhostListKFA(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('localhost_ImageKFA', list);
    listImagePDFKFA.value = list
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();
  }
}
