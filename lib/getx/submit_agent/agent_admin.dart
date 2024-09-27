// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../page/navigate_home/Approvel/submit.dart';

class ListAgent extends GetxController {
  var isAgent = false.obs;
  var isAgentID = false.obs;
  var perpage = 0.obs;
  var lastPage = 1.obs;
  var to = 0.obs;
  var total = 0.obs;
  var listAgentModel = [].obs;
  var listAgentID = [].obs;
  var id = 0.obs;
  @override
  void onInit() {
    super.onInit();
    //Change value to name2
    listAgent(10, 1, 3, "", "", "");
  }

  var url = "".obs;
  Future<void> listAgent(
      int perpages,
      int pages,
      int checkType,
      String startDateController,
      String endDateController,
      String search) async {
    print("OKOKOK : $checkType");
    try {
      if (checkType == 1) {
        url.value =
            'get/Pagination?perPage=$perpages&page=$pages${(startDateController != '') ? "&start=$startDateController&end=$endDateController" : ""}';
      } else if (checkType == 2) {
        url.value =
            'get/Pagination?check=1&approvel=100&perPage=$perpages&page=$pages&${(startDateController != '') ? "&start=$startDateController&end=$endDateController" : ""}';
      } else if (checkType == 4) {
        print("OKOKOK : $checkType");
        url.value =
            "search/listAuto?search=$search&page=$pages&perPage=$perpages";
      } else {
        url.value =
            'get/Pagination?check=2&approvel=100&perPage=$perpages&page=$pages&${(startDateController != '') ? "&start=$startDateController&end=$endDateController" : ""}';
      }
      isAgent.value = true;
      var headers = {'Content-Type': 'application/json'};
      var dio = Dio();
      var response = await dio.request(
        // 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/submit_agentListAll?perPage=$perpages&page=$pages',
        "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/${url.value}",
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        perpage.value = jsonDecode(json.encode(response.data))['perPage'];
        lastPage.value = jsonDecode(json.encode(response.data))['lastPage'];
        to.value = jsonDecode(json.encode(response.data))['to'] ?? 0;
        total.value = jsonDecode(json.encode(response.data))['total'];
        listAgentModel.value = jsonDecode(json.encode(response.data))['data'];
      }
    } catch (e) {
      // print('Error occurred: $e');
    } finally {
      isAgent.value = false;
    }
  }

  Future<void> checkID(BuildContext context, List listAgent, int index,
      int perpage, int page, List listUser) async {
    try {
      isAgentID.value = true;
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/submit_agentID/${listAgent[index]['protectID']}',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        listAgentID.value = jsonDecode(json.encode(response.data));
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return SubmitAgent(
              listUser: listUser,
              page: page,
              perpage: perpage,
              docID:
                  "${(listAgent[index]['type_value'] == "T") ? listAgent[index]['protectID'] : listAgent[index]['verbal_id']}",
              usernameAgent: listAgent[index]['username'].toString(),
              indexs: index,
              list: listAgent,
              backvalue: (value) {},
              device: 'd',
              idController: listAgent[index]['verbal_user'].toString(),
            );
          },
        );
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    } finally {
      isAgentID.value = false;
    }
  }

  Future<void> sendMessage(String text) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"text": text});
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/telegramAgent',
      options: Options(
        method: 'POST',
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
