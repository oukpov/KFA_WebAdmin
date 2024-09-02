import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../models/LandBuilding/landbuilding_Model.dart';
// import '../../models/verbalModel/verbal_model.dart';

class VerbalData extends GetxController {
  var list = [].obs;
  var listImage = [].obs;
  var listlandbuilding = <LandbuildingModels>[].obs;
  // var listData = <Data>[].obs;
  var perPage = 0.obs;
  var lastPage = 0.obs;
  var to = 0.obs;
  var total = 0.obs;

  @override
  void onInit() {
    super.onInit();
    listviewVerbal(0, 10, 1, "", "", false, "");
  }

  var isverbal = true.obs;
  var isverbalfirst = true.obs;
  var islandbuilding = true.obs;
  var isVerbalImage = true.obs;
  String url = '';
  Future<void> listviewVerbal(
      int userID,
      int perPages,
      int pages,
      String startDateController,
      String endDateController,
      bool checkType,
      String search) async {
    isverbal.value = true;
    try {
      if (!checkType) {
        url =
            'search=$search&perPage=$perPages&page=$pages${(startDateController != '') ? "&start=$startDateController&end=$endDateController" : ""}';
      } else {
        url =
            'search=$search&perPage=$perPages&page=$pages&agenttype_id=$userID${(startDateController != '') ? "&start=$startDateController&end=$endDateController" : ""}';
      }

      var headers = {'Content-Type': 'application/json'};
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get/list/Pagination?$url',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data['data'];
        list.value = data;

        // if (data is List) {
        //   listData.value = data.map((json) => Data.fromJson(json)).toList();
        // }

        perPage.value = response.data['perPage'];
        lastPage.value = response.data['lastPage'];
        to.value = response.data['to'];
        total.value = response.data['total'];
      }
    } catch (e) {
      // Handle the error
      // print('Error occurred: $e');
    } finally {
      isverbal.value = false;
      isverbalfirst.value = false;
    }
  }

  Future<void> landbuidlingAuto(int verballandid) async {
    print("verballandid :  $verballandid");
    try {
      islandbuilding.value = true;
      var response = await Dio().get(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/listland?verbal_landid=$verballandid');

      if (response.statusCode == 200) {
        var data = response.data;

        if (data is List) {
          listlandbuilding.value =
              data.map((json) => LandbuildingModels.fromJson(json)).toList();
        }
      }
    } catch (e) {
      // print('Error occurred: $e');
    } finally {
      islandbuilding.value = false;
    }
  }

  Future<void> imagebase64(int verbalID) async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/imageBase64/auto/$verbalID',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        listImage.value = response.data;
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    } finally {
      isVerbalImage.value = false;
    }
  }
}
