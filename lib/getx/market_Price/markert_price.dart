import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../component/getx._snack.dart';

class MarkertPrice extends GetxController {
  @override
  void onInit() {
    super.onInit();
    listPiganation(10, 1);
  }

  var listMarkertR = [].obs;
  var listMarkertC = [].obs;
  var minValueR = "".obs;
  var maxValueR = "".obs;
  var minValueC = "".obs;
  var maxValueC = "".obs;
  var minOldValueR = "".obs;
  var maxOldValueR = "".obs;
  var minOldValueC = "".obs;
  var maxOldValueC = "".obs;
  var khanID = "".obs;
  var sangkatID = "".obs;
  var roadName = "".obs;
  Component component = Component();
  var isMarkert = false.obs;
  var isData = false.obs;
  var perPage = 0.obs;
  var lastPage = 0.obs;
  var to = 0.obs;
  var total = 0.obs;
  var listData = [].obs;
  Future<void> listPiganation(
    int perPages,
    int pages,
  ) async {
    try {
      isData.value = true;
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({"perPage": perPages, "page": pages});
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/list/histroys/Market',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        listData.value = response.data['data'];
        perPage.value = response.data['perPage'];
        lastPage.value = response.data['lastPage'];
        to.value = response.data['to'];
        total.value = response.data['total'];
      }
    } catch (e) {
      // print(e);
    } finally {
      isData.value = false;
    }
  }

  Future<void> markertList(
    String khanName,
    String sangKatName,
    String nameRoad,
  ) async {
    try {
      minValueR.value = "";
      maxValueR.value = "";
      minValueC.value = "";
      maxValueC.value = "";
      ///////
      minOldValueR.value = "";
      maxOldValueR.value = "";
      minOldValueC.value = "";
      maxOldValueC.value = "";
      khanID.value = "";
      khanID.value = "";
      roadName.value = "N/A";
      listMarkertR.value = [].obs;
      listMarkertC.value = [].obs;
      isMarkert.value = true;
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "Khan_Name": khanName,
        "Sangkat_Name": sangKatName,
        "name_road": nameRoad,
      });
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/check/market/price',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        listMarkertR.value = response.data['R'];
        listMarkertC.value = response.data['C'];
        minValueR.value = "${listMarkertR[0]['Min_Value'] ?? 0}";
        maxValueR.value = "${listMarkertR[0]['Max_Value'] ?? 0}";
        minValueC.value = "${listMarkertC[0]['Min_Value'] ?? 0}";
        maxValueC.value = "${listMarkertC[0]['Max_Value'] ?? 0}";

        ///
        minOldValueR.value = "${listMarkertR[0]['Min_Value'] ?? 0}";
        maxOldValueR.value = "${listMarkertR[0]['Max_Value'] ?? 0}";
        minOldValueC.value = "${listMarkertC[0]['Min_Value'] ?? 0}";
        maxOldValueC.value = "${listMarkertC[0]['Max_Value'] ?? 0}";
        khanID.value = "${listMarkertR[0]['Khan_ID'] ?? 0}";
        sangkatID.value = "${listMarkertR[0]['Sangkat_ID'] ?? 0}";
        roadName.value = "${response.data['road'][0]['name_road'] ?? ""}";
        // print("roadName : $roadName");
        // print("khanName : $khanName");
        // print("sangKatName : $sangKatName");
        // print("khanID : $khanID");
        // print("sangkatID : $sangkatID");
      }
    } catch (e) {
      // print(e);
    } finally {
      isMarkert.value = false;
    }
  }

  Future<void> deletetedMainRoad(
    String mainRoad,
    String minvalueR,
    String maxvalueR,
    String minvalueC,
    String maxvalueC,
    String minoldvalueR,
    String maxoldvalueR,
    String minoldvalueC,
    String maxoldvalueC,
    String mainroad,
    String mainroadold,
    String latlonglat,
    String latlonglog,
    String updateby,
  ) async {
    try {
      isMarkert.value = true;
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "name_road": mainRoad,
        "min_valueR": minvalueR,
        "max_valueR": maxvalueR,
        "min_valueC": minvalueC,
        "max_valueC": maxvalueC,
        "min_old_valueR": minoldvalueR,
        "max_old_valueR": maxoldvalueR,
        "min_old_valueC": minoldvalueC,
        "max_old_valueC": maxoldvalueC,
        "main_road": mainroad,
        "main_road_old": mainroadold,
        "latlong_lat": latlonglat,
        "latlong_log": latlonglog,
        "update_by": updateby,
      });
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/deleted/main/road',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        minValueR.value = "";
        maxValueR.value = "";
        minValueC.value = "";
        maxValueC.value = "";
        khanID.value = "";
        sangkatID.value = "";
        listMarkertR.value = [].obs;
        listMarkertC.value = [].obs;
        component.handleTap("Done!", json.encode(response.data), 1);
      } else {
        component.handleTap("Done!", "Can not Deleted!", 1);
      }
    } catch (e) {
      // print(e);
    } finally {
      isMarkert.value = false;
    }
  }

  Future<void> deleteMarkert(String sangkatsID, String khansID) async {
    try {
      isMarkert.value = true;
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({"Sangkat_ID": sangkatsID, "Khan_ID": khansID});
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/deleted/market/price',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        minValueR.value = "";
        maxValueR.value = "";
        minValueC.value = "";
        maxValueC.value = "";
        khanID.value = "";
        sangkatID.value = "";
        listMarkertR.value = [].obs;
        listMarkertC.value = [].obs;
        component.handleTap("Done!", json.encode(response.data), 1);
      } else {
        component.handleTap("Done!", "Can not Deleted!", 1);
      }
    } catch (e) {
      // print(e);
    } finally {
      isMarkert.value = false;
    }
  }

  Future<void> markertPrice(
    String khanName,
    String sangkatName,
    String province,
    String minValuesR,
    String maxValuesR,
    String minValuesC,
    String maxValuesC,
    String minOldValuesR,
    String maxOldValuesR,
    String minOldValuesC,
    String maxOldValuesC,
    String mainRoad,
    String oldRoadName,
    String latlonglat,
    String latlonglog,
    String updateby,
    String khansID,
    String sangKatsID,
  ) async {
    try {
      minValueR.value = "";
      maxValueR.value = "";
      minValueC.value = "";
      maxValueC.value = "";
      ///////////
      minOldValueR.value = "";
      maxOldValueR.value = "";
      minOldValueC.value = "";
      maxOldValueC.value = "";
      khanID.value = "";
      sangkatID.value = "";
      isMarkert.value = true;
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "Khan_Name": khanName,
        "Sangkat_Name": sangkatName,
        "province": province,
        "name_road": mainRoad,
        ////////
        "khan_ID": khansID,
        "sangkat_ID": sangKatsID,
        "min_valueR": minValuesR,
        "max_valueR": maxValuesR,
        "min_valueC": minValuesC,
        "max_valueC": maxValuesC,
        "min_old_valueR": minOldValuesR,
        "max_old_valueR": maxOldValuesR,
        "min_old_valueC": minOldValuesC,
        "max_old_valueC": maxOldValuesC,
        "main_road": mainRoad,
        "man_road_old": oldRoadName,
        "latlong_lat": latlonglat,
        "latlong_log": latlonglog,
        "update_by": updateby,
      });
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/insert/market/price',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        component.handleTap("Done!", json.encode(response.data), 1);
      }
    } catch (e) {
      // print(e);
    } finally {
      isMarkert.value = false;
    }
  }
}
