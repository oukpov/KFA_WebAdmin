import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/verbalAgentMode.dart';

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

  var varListVerbal = [].obs;
  var isVerbal = false.obs;
  var listVerbalAgent = [].obs;
  var isVerbalAgent = false.obs;
  //Page
  var page = 0.obs;
  var lastPage = 0.obs;
  var perPage = 0.obs;
  var to = 0.obs;
  var total = 0.obs;
  Future<void> addVerbalModel(VerbalAgentModel verbalAgentModel,
      BuildContext context, List listLandbuilding) async {
    try {
      isVerbal.value = true;
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
        "total_min": verbalAgentModel.totalMin,
        "total_max": verbalAgentModel.totalMax,
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
        print("Post Successfuly");
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
}
