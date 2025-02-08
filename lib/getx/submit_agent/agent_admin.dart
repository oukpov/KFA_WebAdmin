// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
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
    try {
      print("perpages : $perpages || pages : $pages || search : $search ||");
      if (checkType == 1) {
        print("No.1 : $checkType");
        url.value =
            'get/Pagination?perPage=$perpages&page=$pages${(startDateController != '') ? "&start=$startDateController&ends=$endDateController" : ""}';
      } else if (checkType == 2) {
        //Approvel
        print("No.2 : $checkType");
        url.value =
            'get/Pagination?check=2&VerifyAgent=100&perPage=$perpages&page=$pages${(startDateController != '') ? "&start=$startDateController&ends=$endDateController" : ""}';
      } else if (checkType == 3) {
        print("No.3: $checkType");
        url.value =
            "search/listAuto?search=$search&page=$pages&perPage=$perpages";
      } else {
        print("No.4 : $checkType");
        url.value =
            'get/Pagination?check=2&approvel=100&perPage=$perpages&page=$pages${(startDateController != '') ? "&start=$startDateController&ends=$endDateController" : ""}';
      }
      isAgent.value = true;
      var headers = {'Content-Type': 'application/json'};
      var dio = Dio();
      var response = await dio.request(
        "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/${url.value}",
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        perpage.value = int.parse(response.data['perPage'].toString());
        lastPage.value = int.parse(response.data['lastPage'].toString());
        to.value = int.parse(response.data['to'].toString());
        total.value = int.parse(response.data['total'].toString());
        listAgentModel.value = response.data['data'];
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
