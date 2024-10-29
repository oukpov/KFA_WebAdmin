import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../component/getx._snack.dart';

class AddZone extends GetxController {
  var listZone = [].obs;
  var isZone = false.obs;
  var isZoneLatlog = false.obs;
  Future<void> addZone(List list) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"listZone": list});
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/add/Specail/Zone',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      // print(listZone.toString());
      component.handleTap("Done!", "Add Successfuly!");
    } else {
      print(response.statusMessage);
    }
  }

  Future<void> fetchZoneLatlog(double lat, double log, double distance) async {
    try {
      isZone.value = true;
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({"distance": distance, "lat": lat, "log": log});
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/zone/checkset',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        listZone.value = jsonDecode(json.encode(response.data));
        // print(listZone.toString());
      }
    } catch (e) {
      // print(e);
    } finally {
      isZoneLatlog.value = false;
    }
  }

  Component component = Component();
  // Future<void> fetchZone(nameRoad) async {
  //   try {
  //     isZone.value = true;
  //     var dio = Dio();
  //     var response = await dio.request(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get/Specail/Zone/$nameRoad',
  //       options: Options(
  //         method: 'GET',
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       listZone.value = jsonDecode(json.encode(response.data));
  //     }
  //   } catch (e) {
  //     // print(e);
  //   } finally {
  //     isZone.value = false;
  //   }
  // }

  Future<void> deleteZone(int zoneID, String nameRoad) async {
    print("zoneID : $zoneID || nameRoad : $nameRoad");
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/delete/Specail/Zone/$zoneID/$nameRoad',
      options: Options(
        method: 'DELETE',
      ),
    );

    if (response.statusCode == 200) {
      component.handleTap("Done!", "Deleted Successfuly!");
    } else {
      print(response.statusMessage);
    }
  }
}
