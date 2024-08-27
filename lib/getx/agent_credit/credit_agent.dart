import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class CreditAgent extends GetxController {
  var isagent = true.obs;
  var iscredit = true.obs;
  List listCreditlocalhost = [].obs;
  List listCredit = [].obs;
  var credit = 0.obs;
  Future<void> creditAgent(id) async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get/agent/$id',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        listCreditlocalhost = jsonDecode(json.encode(response.data));

        // print('No => ${listCreditlocalhost[0]['credit_verbal']}');
      }
    } catch (e) {
      // print('Error occurred: $e');
    } finally {
      isagent.value = false;
      credit.value = listCreditlocalhost[0]['credit_verbal'];
    }
  }

  Future<void> creditAgentMore(int creditAgent, int userID) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({"credit_verbal": creditAgent});
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/credit/verbalAgent/$userID',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        listCredit = jsonDecode(json.encode(response.data));
      }
    } catch (e) {
      // print('Error occurred: $e');
    } finally {
      iscredit.value = false;
      credit.value = listCredit[0]['credit_verbal'];
      print("credit.value : ${credit.value} || userID : $userID");
      // print('=====> ${credit.value}');
    }
  }
}
