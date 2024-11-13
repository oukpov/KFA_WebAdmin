// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/verbalAgentMode.dart';
import '../component/getx._snack.dart';

class VerbalAgents extends GetxController {
  var idusers = ''.obs;
  VerbalAgents({required String iduser}) {
    idusers.value = iduser;
  }
  @override
  void onInit() {
    super.onInit();
    fetchVerbalList();
  }

  var verbalImage = "No".obs;
  var varListVerbal = [].obs;
  var varListLandBuilding = [].obs;
  var isVerbal = false.obs;
  var listVerbalAgent = [].obs;
  var isVerbalAgent = false.obs;
  var changeImage = false.obs;
  //Page
  var page = 0.obs;
  var lastPage = 0.obs;
  var perPage = 0.obs;
  var to = 0.obs;
  var total = 0.obs;
  var verbImage = "No".obs;
  var fetchVerbalAndLand = false.obs;
  var fetchVerbalBYCode = [].obs;
  var fetchVerbalLandBYCode = [].obs;
  Component component = Component();
  Future<void> addVerbalModel(VerbalAgentModel verbalAgentModel,
      BuildContext context, List listLandbuilding) async {
    try {
      isVerbal.value = true;
      changeImage.value = false;
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "title_deedN": verbalAgentModel.titleDeedN,
        "verbal_code": verbalAgentModel.verbalCode,
        "under_property_right": verbalAgentModel.underPropertyRight,
        "referrenceN": verbalAgentModel.referrenceN,
        "issued_date": verbalAgentModel.issuedDate,
        "verbal_property_id": verbalAgentModel.verbalPropertyId,
        "verbal_image": verbalAgentModel.verbalImage,
        "verbal_owner": verbalAgentModel.verbalOwner,
        "verbal_contact": verbalAgentModel.verbalContact,
        "verbal_address": verbalAgentModel.verbalAddress,
        "verbal_comment": verbalAgentModel.verbalComment,
        "land_size": verbalAgentModel.landSize,
        "building_size": verbalAgentModel.buildingSize,
        "latlong_log": verbalAgentModel.latlongLog,
        "latlong_la": verbalAgentModel.latlongLa,
        "verbal_user": verbalAgentModel.verbalUser,
        "listlandbuilding": listLandbuilding
      });
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/add/verbal/agents',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        varListVerbal.value = jsonDecode(json.encode(response.data))['data'];
        varListLandBuilding.value =
            jsonDecode(json.encode(response.data))['landbuilding'];

        component.handleTap("Post Successfuly!", "", 1);
      }
    } catch (e) {
      // print(e);
    } finally {
      isVerbal.value = false;
    }
  }

  Future<void> editVerbalModel(VerbalAgentModel verbalAgentModel,
      BuildContext context, List listLandbuilding) async {
    try {
      isVerbal.value = true;
      changeImage.value = false;
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "verbal_code": verbalAgentModel.verbalCode,
        "title_deedN": verbalAgentModel.titleDeedN,
        "under_property_right": verbalAgentModel.underPropertyRight,
        "referrenceN": verbalAgentModel.referrenceN,
        "issued_date": verbalAgentModel.issuedDate,
        "verbal_property_id": verbalAgentModel.verbalPropertyId,
        "verbal_image": verbalAgentModel.verbalImage,
        "verbal_owner": verbalAgentModel.verbalOwner,
        "verbal_contact": verbalAgentModel.verbalContact,
        "verbal_address": verbalAgentModel.verbalAddress,
        "verbal_comment": verbalAgentModel.verbalComment,
        "land_size": verbalAgentModel.landSize,
        "building_size": verbalAgentModel.buildingSize,
        "latlong_log": verbalAgentModel.latlongLog,
        "latlong_la": verbalAgentModel.latlongLa,
        "verbal_user": verbalAgentModel.verbalUser,
        "listlandbuilding": listLandbuilding
      });
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Edit/verbal/agents',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        // varListVerbal.value = jsonDecode(json.encode(response.data))['data'];
        // varListLandBuilding.value =
        //     jsonDecode(json.encode(response.data))['landbuilding'];

        component.handleTap("Update Successfuly!", "", 1);
      }
    } catch (e) {
      // print(e);
    } finally {
      isVerbal.value = false;
    }
  }

  Future<void> fetchVerbalList() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      // var data = json.encode({"verbal_user": idusers.value});
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/fetch/verbal/list/agent?verbal_user=${idusers.value}',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        // data: data,
      );

      if (response.statusCode == 200) {
        listVerbalAgent.value = jsonDecode(json.encode(response.data))['data'];
        print(listVerbalAgent.length.toString());
        perPage.value = int.parse(
            jsonDecode(json.encode(response.data))['perPage'].toString());
        lastPage.value = int.parse(
            jsonDecode(json.encode(response.data))['lastPage'].toString());
        to.value =
            int.parse(jsonDecode(json.encode(response.data))['to'].toString());
        total.value = int.parse(
            jsonDecode(json.encode(response.data))['total'].toString());
      }
    } catch (e) {
      // print(e);
    } finally {
      isVerbalAgent.value = false;
    }
  }

  Future<void> fetchVerbalAll(String verbalCode) async {
    try {
      fetchVerbalAndLand.value = true;
      await fetchVerbalByCode(verbalCode);
      await fetchVerbalLandByCode(verbalCode);
    } catch (e) {
      // print(e);
    } finally {
      fetchVerbalAndLand.value = false;
    }
  }

  Future<void> fetchVerbalByCode(String verbalCode) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({"verbal_code": verbalCode});
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/fetch/verbal_Code',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        fetchVerbalBYCode.value = response.data;
      }
    } catch (e) {
      // print(e);
    }
  }

  Future<void> fetchVerbalLandByCode(String verbalCode) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({"verbal_landid": verbalCode});
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/fetch/verbal_Code/landbuilding',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        fetchVerbalLandBYCode.value = response.data;
      }
    } catch (e) {
      // print(e);
    }
  }

  Future<void> searchVerbal(
      String query, String start, String end, String verbalUser) async {
    try {
      isVerbalAgent.value = true;
      var data = json.encode({"verbal_user": verbalUser});
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/fetch/searchVerbalAgent?search=$query${(start == "" && end == "") ? "" : "&start=$start&end=$end"}',
        options: Options(
          method: 'POST',
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        listVerbalAgent.value = jsonDecode(json.encode(response.data))['data'];

        perPage.value = int.parse(
            jsonDecode(json.encode(response.data))['perPage'].toString());
        lastPage.value = int.parse(
            jsonDecode(json.encode(response.data))['lastPage'].toString());
        to.value =
            int.parse(jsonDecode(json.encode(response.data))['to'].toString());
        total.value = int.parse(
            jsonDecode(json.encode(response.data))['total'].toString());
      }
    } catch (e) {
      // print(e);
    } finally {
      isVerbalAgent.value = false;
    }
  }

  Future<void> deleteVerbal(String verbalCode) async {
    try {
      // isVerbalAgent.value = true;
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/verbalAgent/deleted/$verbalCode',
        options: Options(
          method: 'DELETE',
        ),
      );

      if (response.statusCode == 200) {
        component.handleTap("Deleted Successfuly!", "", 1);
      }
    } catch (e) {
      // print(e);
    } finally {
      // isVerbalAgent.value = false;
    }
  }

  Future<void> fetchImageLandbuilding(String verbalCode) async {
    await fetchVerbalImage(verbalCode);
    await fetchVerbalLandByCode(verbalCode);
  }

  Future<void> fetchVerbalImage(String verbalCode) async {
    try {
      // isVerbal.value = true;
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({"verbal_code": verbalCode});
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/fetch/verbalImage',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        List list = jsonDecode(json.encode(response.data));
        verbalImage.value = list[0]['verbal_image'] ?? "No";
      }
    } catch (e) {
      // print(e);
    } finally {
      // isVerbal.value = false;
    }
  }

  Future<void> deleteLandbuilding(String verbalLandId) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"verbal_land_id": verbalLandId});
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/delete/verbal/agents',
      options: Options(
        method: 'DELETE',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      component.handleTap("Deleted Successfuly!", "", 1);
    }
  }
}
