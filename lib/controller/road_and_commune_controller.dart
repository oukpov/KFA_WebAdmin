import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:web_admin/models/raod_and_commune_model.dart';
import 'package:http/http.dart' as http;

class RoadAndCommnuneController extends GetxController {
  final roadAndCommnune = RoadAndCommnuneModel().obs;
  final roadAndCommnuneList = <RoadAndCommnuneModel>[].obs;
  final isLoading = false.obs;
  final url =
      'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api';
  @override
  void onInit() {
    super.onInit();
    getRoadAndCommnune();
  }

  Future<void> getRoadAndCommnune() async {
    isLoading(true);
    try {
      final response = await http.get(Uri.parse('$url/rc_list'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          roadAndCommnuneList.value = jsonData
              .map((item) => RoadAndCommnuneModel.fromJson(item))
              .toList();
          if (roadAndCommnuneList.isNotEmpty) {
            roadAndCommnune(roadAndCommnuneList.first);
          }
        } else if (jsonData is Map<String, dynamic>) {
          roadAndCommnune(RoadAndCommnuneModel.fromJson(jsonData));
          roadAndCommnuneList.value = [roadAndCommnune.value];
        } else {
          Get.snackbar('Error', 'Invalid data format');
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateRoadAndCommune(RoadAndCommnuneModel updatedModel) async {
    isLoading(true);
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('$url/update'));
      request.body = json.encode({
        "cid": updatedModel.cid,
        "option": updatedModel.option,
        "road_name": updatedModel.roadName,
        "commune_name": updatedModel.communeName,
        "district": updatedModel.district,
        "province": updatedModel.province,
        "max_value": updatedModel.maxValue,
        "min_value": updatedModel.minValue,
        "longitude": updatedModel.longitude,
        "latitude": updatedModel.latitude
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        print(responseBody);
        Get.snackbar('Success', 'Road and Commune updated successfully');
        await getRoadAndCommnune(); // Refresh the data after update
      } else {
        print(response.reasonPhrase);
        Get.snackbar('Error', 'Failed to update Road and Commune');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
