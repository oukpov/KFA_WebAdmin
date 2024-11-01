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

  @override
  void onInit() {
    super.onInit();
    // fetchVerbalReportById(332);
    fetchVerbalReports();
    // Remove initial fetch calls since they're causing duplicate requests
  }

  static const String apiUrl =
      'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/reportverbal';

  Future<List<Verbal_model>> fetchVerbalReports() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Verbal_model.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load verbal reports: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching verbal reports: $e');
    }
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
        list.value = jsonDecode(json.encode(response.data));
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
}
