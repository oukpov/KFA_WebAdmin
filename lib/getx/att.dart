import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AttController extends GetxController {
  @override
  void onInit() {
    listAgencyMethod();
    super.onInit();
  }

  var listAgency = [].obs;
  var listAtt = [].obs;
  var perPage = 0.obs;
  var lastPage = 0.obs;
  var to = 0.obs;
  var total = 0.obs;
  var isAtt = false.obs;
  var isagent = false.obs;
  Future<void> attController(int agency, String start, String ends) async {
    try {
      isAtt.value = true;
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "agency": agency,
        "start": start,
        "end": ends,
        "perPage": 10,
        "page": 1
      });
      var dio = Dio();
      var response = await dio.request(
        'https://kfa-fertilizer.cam/ScanQR_Project/public/api/att_Staff/dateAdmin',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        listAtt.value = response.data['data'];
        perPage.value = response.data['perPage'];
        lastPage.value = response.data['lastPage'];
        to.value = response.data['to'];
        total.value = response.data['total'];
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    } finally {
      isAtt.value = false;
    }
  }

  Future<void> listAgencyMethod() async {
    try {
      isagent.value = true;
      var dio = Dio();
      var response = await dio.request(
        'https://kfa-fertilizer.cam/ScanQR_Project/public/api/listAgency',
        options: Options(
          method: 'POST',
        ),
      );

      if (response.statusCode == 200) {
        listAgency.value = response.data;
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    } finally {
      isagent.value = false;
    }
  }
}
