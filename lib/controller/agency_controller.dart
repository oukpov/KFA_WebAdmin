import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/agnecy_model.dart';

class AgencyController extends GetxController {
  var agencies = <AgencyModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchAgencies();
    super.onInit();
  }

  void fetchAgencies() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_agency'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        agencies.value = (jsonData as List)
            .map((item) => AgencyModel.fromJson(item))
            .toList();
      } else {
        print('Failed to fetch agencies. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while fetching agencies: $e');
    } finally {
      isLoading(false);
    }
  }
}
