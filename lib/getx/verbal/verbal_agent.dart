import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/verbalAgentMode.dart';

class VerbalAgents extends GetxController {
  var varListVerbal = [].obs;
  var isVerbal = false.obs;
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
}
