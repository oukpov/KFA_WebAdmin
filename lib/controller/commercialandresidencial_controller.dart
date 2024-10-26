import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/commercialandresidencial_model.dart';

class CommercialAndResidentialController extends GetxController {
  var isLoading = true.obs;
  var commercialAndResidentialList = <ComercialAndResidencialModel>[].obs;

  @override
  void onInit() {
    fetchCommercialAndResidentialData();
    super.onInit();
  }

  void fetchCommercialAndResidentialData() async {
    try {
      isLoading(true);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/getkhansangkatprice',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.encode(response.data);
        var decodedResponse = json.decode(jsonResponse);
        commercialAndResidentialList.value = (decodedResponse as List)
            .map((item) => ComercialAndResidencialModel(
                  khanID: item['Khan_ID'],
                  sangkatID: item['Sangkat_ID'],
                  province: item['province'],
                  khanName: item['Khan_Name'],
                  sangkatName: item['Sangkat_Name'],
                  residentialMinValue: item['residential_min_value'],
                  residentialMaxValue: item['residential_max_value'],
                  commercialMinValue: item['commercial_min_value'],
                  commercialMaxValue: item['commercial_max_value'],
                ))
            .toList();
        print('Data fetched successfully');
      } else {
        print('Error: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateCommercialAndResidentialData({
    required int khanID,
    required int sangkatID,
    required String residentialMinValue,
    required String residentialMaxValue,
    required String commercialMinValue,
    required String commercialMaxValue,
  }) async {
    try {
      isLoading(true);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      var data = json.encode({
        "Khan_ID": khanID,
        "Sangkat_ID": sangkatID,
        "residential_min_value": residentialMinValue,
        "residential_max_value": residentialMaxValue,
        "commercial_min_value": commercialMinValue,
        "commercial_max_value": commercialMaxValue
      });
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/updatekhansangkatprice',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        // Update the local list with the new data
        var updatedItem = ComercialAndResidencialModel(
          khanID: khanID,
          sangkatName: sangkatID
              .toString(), // Assuming Sangkat_ID corresponds to sangkatName
          residentialMinValue: residentialMinValue,
          residentialMaxValue: residentialMaxValue,
          commercialMinValue: commercialMinValue,
          commercialMaxValue: commercialMaxValue,
        );
        int index = commercialAndResidentialList
            .indexWhere((item) => item.khanID == khanID);
        if (index != -1) {
          commercialAndResidentialList[index] = updatedItem;
        } else {
          commercialAndResidentialList.add(updatedItem);
        }
        commercialAndResidentialList.refresh();
      } else {
        print('Error: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error updating data: $e');
    } finally {
      isLoading(false);
    }
  }
}
