import 'dart:html';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/about_us_slide_model.dart';

class AboutUsSlideController extends GetxController {
  var isLoading = false.obs;
  var aboutUsSlideData = AboutUsSlideModel().obs;
  List<AboutUsSlideModel> aboutUsSlideList = [];

  @override
  void onInit() {
    fetchAboutUsSlideData();
    super.onInit();
  }

  String url =
      'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/aboutusSliser';
  Future<void> fetchAboutUsSlideData() async {
    try {
      isLoading(true);
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };

      var dio = Dio();
      var response = await dio.request(
        '$url/get',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        if (response.data is List) {
          aboutUsSlideList = (response.data as List)
              .map((item) => AboutUsSlideModel.fromJson(item))
              .toList();
          if (aboutUsSlideList.isNotEmpty) {
            aboutUsSlideData.value = aboutUsSlideList[0];
          }
        } else {
          aboutUsSlideData.value = AboutUsSlideModel.fromJson(response.data);
        }
        print(json.encode(response.data));
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error while getting data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> uploadImageSlides(String filePath, String fileName) async {
    if (filePath.isEmpty) {
      Get.snackbar('Error', 'Please select an image first');
      return;
    }

    isLoading(true);

    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };

      var dioClient = dio.Dio();
      var response = await dioClient.request(
        'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/aboutusSliser/add',
        options: dio.Options(
          method: 'POST',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Image uploaded successfully',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            icon: const Icon(Icons.check_circle, color: Colors.white));
        await fetchAboutUsSlideData();
      } else {
        Get.snackbar(
            'Error', 'Failed to upload image: ${response.statusMessage}',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            icon: const Icon(Icons.error, color: Colors.white));
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while uploading: $e',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: const Icon(Icons.error, color: Colors.white));
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteAboutUsSlide(String id) async {
    isLoading(true);

    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };

      var dioClient = dio.Dio();
      var response = await dioClient.request(
        '$url/delete/$id',
        options: dio.Options(
          method: 'DELETE',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Image deleted successfully',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            icon: const Icon(Icons.check_circle, color: Colors.white));
        await fetchAboutUsSlideData();
      } else {
        Get.snackbar(
            'Error', 'Failed to delete image: ${response.statusMessage}',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            icon: const Icon(Icons.error, color: Colors.white));
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while deleting: $e',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: const Icon(Icons.error, color: Colors.white));
    } finally {
      isLoading(false);
    }
  }
}
