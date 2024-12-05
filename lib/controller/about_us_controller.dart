import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/about_us_model.dart';

class AboutUsController extends GetxController {
  var isLoading = false.obs;
  var aboutUsData = AboutUsModel().obs;
  List<AboutUsModel> aboutUsList = [];
  String url =
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/aboutus';
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
        '$url/get',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        // Handle case where response is a List
        if (response.data is List) {
          if (response.data.isNotEmpty) {
            // Take first item if list is not empty
            aboutUsData.value = AboutUsModel.fromJson(response.data[0]);
          }
        } else {
          // Handle case where response is a Map
          aboutUsData.value = AboutUsModel.fromJson(response.data);
        }
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      // print('Error while getting data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateAboutUsData({
    required String dearValueCustomer,
    required String companyOverview,
    required String visionMission,
    required String ourPeople,
    required String companyProfile,
    required String aboutCaption,
  }) async {
    try {
      isLoading(true);
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };

      var data = json.encode({
        "dear_value_customer": dearValueCustomer,
        "company_overview": companyOverview,
        "vision_mission": visionMission,
        "our_people": ourPeople,
        "company_profile": companyProfile,
        "about_caption": aboutCaption,
        "created_at": "NOW()",
        "updated_at": "NOW()"
      });

      var dio = Dio();
      var response = await dio.request(
        '$url/update/5',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        //print(json.encode(response.data));
        // Refresh data after update
        await fetchAboutUsData();
      } else {
        //  print(response.statusMessage);
      }
    } catch (e) {
      // print('Error while updating data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteAboutUsData(int id) async {
    try {
      isLoading(true);
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var data = '';

      var dio = Dio();
      var response = await dio.request(
        '$url/delete/$id',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        // print(json.encode(response.data));
        // Refresh data after deletion
        await fetchAboutUsData();
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      //  print('Error while deleting data: $e');
    } finally {
      isLoading(false);
    }
  }
}
