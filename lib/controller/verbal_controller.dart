import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import '../models/verbal_model.dart';

class VerbalController extends GetxController {
  var verbalReport = <Verbal_model>[].obs;
  var userId = <Verbal_model>[].obs;
  var list = [].obs;
  var id = 0.obs;
  var isLoading = true.obs;
  var verbalModel = Verbal_model();
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchVerbalReportById(int id) async {
    try {
      isLoading.value = true;
      list.clear(); // Clear the list before making new request

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/reportverbal?verbal_user=$id',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        list.value = jsonDecode(json.encode(response.data))['data'];
        print("listlength: ${list.length}");
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print("Error fetching verbal report: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkPrice() async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var data = json.encode({"verbal_user": id.value});
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/checkPrice/Agent',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        verbalReport = jsonDecode(json.encode(response.data))['data'];
      } else {
        print("Error checking price: ${response.statusMessage}");
      }
    } catch (e) {
      print("Error checking price: $e");
    }
  }
}
