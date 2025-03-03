import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PercentageController extends GetxController {
  // @override
  // void onInit() {
  //   percentageMethod("Banteay Chakrei", '85', '0');
  //   super.onInit();
  // }
  Future<void> updateMethod(String comparableid, String comparableaddingPrice,
      String percentage) async {
    loardings.value = 0;
    for (int i = 0; i < 1; i++) {
      await updatePriceMethod(comparableid, comparableaddingPrice, percentage);
      // print('No.$i');
    }
  }

  var counts = 0.obs;
  var loardings = 0.0.obs;
  var listPercentageList = [].obs;

  var isPercent = false.obs;
  Future<void> updatePriceMethod(String comparableid,
      String comparableaddingPrice, String percentage) async {
    try {
      // isPercent.value = true;
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "comparable_id": comparableid,
        "comparable_adding_price": comparableaddingPrice,
        "percentage": percentage
      });
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/caculate/comparable',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        // listPercentageList.value = response.data;
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    } finally {
      // isPercent.value = false;
    }
  }

  var isPercents = false.obs;
  var perpage = 0.obs;
  var lastPage = 1.obs;
  var to = 0.obs;
  var total = 0.obs;
  var listPercentModel = [].obs;
  var listAgentID = [].obs;
  Future<void> listPercentage(
    // int perpages,
    int pages,
    // int checkType,
    String startDateController,
    String endDateController,
  ) async {
    try {
      isPercents.value = true;
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "page": pages,
        "perPage": 10,
        "start": startDateController,
        "end": endDateController
      });
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/list/percentage/com',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        perpage.value = int.parse(response.data['perPage'].toString());
        lastPage.value = int.parse(response.data['lastPage'].toString());
        to.value = int.parse(response.data['to'].toString());
        total.value = int.parse(response.data['total'].toString());
        listPercentModel.value = response.data['data'];
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    } finally {
      isPercents.value = false;
    }
  }

  Future<void> percentageMethod(
      String commune, String agencyID, String public) async {
    try {
      loardings.value = 0;
      percentageAdd.value = 0;
      counts.value = 0;
      isPercent.value = true;
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "commune": commune,
        "comparabl_user": agencyID,
        "condition_image_published": public
      });
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/listCwCM/commune',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        listPercentageList.value = response.data;

        counts.value = listPercentageList.length;
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    } finally {
      isPercent.value = false;
    }
  }

  var isCommune = false.obs;
  var listCommunes = [].obs;
  Future<void> communeByAgnet(String agency) async {
    try {
      isCommune.value = true;
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({"comparabl_user": agency});
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/fetchCwCM/commune',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        listCommunes.value = response.data;
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    } finally {
      isCommune.value = false;
    }
  }

  var percentageAdd = 0.0.obs;
  var listStory = [].obs;
  var isStroy = false.obs;
  Future<void> countPercentage(String agency, String percentage,
      String communeName, int count, List list) async {
    isPercent.value = true;
    loardings.value = 0;
    percentageAdd.value = 0;
    for (int i = 0; i < count; i++) {
      percentageAdd.value = 100 / counts.value;
      print("===> percentageAdd : $percentageAdd");
      // print(
      //     "===> No.2 comparabl_user : ${list[i]['comparabl_user'].toString()}");
      // print("===> No.3 percentage : $percentage");
      // print(
      //     "===> No.4 comparable_adding_price : ${list[i]['comparable_adding_price'].toString()}");
      // print("===> No.5 list : ${list.length.toString()}");

      // print("****************************************************************");

      await updatePriceMethod(list[i]['comparable_id'].toString(),
          list[i]['comparable_adding_price'].toString(), percentage);
      await addPercentage(agency, percentage, communeName);
      // print('No.$i ${listPercentageList.length}');
      // isPercent.value = false;   loardings.value += 1;
    }
    isPercent.value = false;
  }

  Future<void> addPercentage(
      String agency, String percentage, String communeName) async {
    try {
      // isStroy.value = true;
      // print('count : $count');
      isPercent.value = true;
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "agency_id": agency,
        "percentage": percentage,
        "commune_name": communeName
      });
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/more/percentage/com',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        // listStory.value= re
        // print(json.encode(response.data));
        loardings.value += percentageAdd.value;
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    } finally {
      isPercent.value = false;
      // isStroy.value = false;
    }
  }
}
