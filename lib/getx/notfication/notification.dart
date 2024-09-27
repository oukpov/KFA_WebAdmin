import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class NotificatonAPI extends GetxController {
  var id = "".obs;
  NotificatonAPI({required String ids}) {
    id.value = ids;
  }
  var listNotificatoin = [].obs;
  var notificationCount = 0.obs;
  var isnotification = false.obs;
  var isnotiCount = false.obs;
  var perpage = 0.obs;
  var lastPage = 1.obs;
  var to = 0.obs;
  var total = 0.obs;
  @override
  void onInit() {
    super.onInit();
    notification(1, 10, id.value);
  }

  Future<void> notification(int pages, int perpages, id) async {
    try {
      isnotification.value = true;
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "check": 100,
        "id_user": id,
        "page": pages,
        "perPage": perpages,
      });
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/notifications',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        notificationCount.value =
            jsonDecode(json.encode(response.data))['!done'];
        perpage.value = jsonDecode(json.encode(response.data))['perPage'];
        lastPage.value = jsonDecode(json.encode(response.data))['lastPage'];
        to.value = jsonDecode(json.encode(response.data))['to'] ?? 0;
        total.value = jsonDecode(json.encode(response.data))['total'];
        listNotificatoin.value = jsonDecode(json.encode(response.data))['data'];
      }
    } catch (e) {
      // print(e);
    } finally {
      isnotification.value = false;
    }
  }

  Future<void> notificationPush(
      String idUser, String title, String subtitle, String protectID) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "id_user": idUser,
      "protectID": protectID,
      "subtitle": subtitle,
      "title": title,
      "check": 100
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/notification_add',
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

  Future<void> checkDone(String protectID) async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/checkDone/$protectID',
      options: Options(
        method: 'POST',
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  // Future<void> countNotification(int id) async {
  //   try {
  //     isnotiCount.value = true;
  //     var headers = {'Content-Type': 'application/json'};
  //     var data = json.encode({"check": 100, "id_user": id});
  //     var dio = Dio();
  //     var response = await dio.request(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/checkDone/Count',
  //       options: Options(
  //         method: 'POST',
  //         headers: headers,
  //       ),
  //       data: data,
  //     );

  //     if (response.statusCode == 200) {
  //       notificationCount.value = int.parse(json.encode(response.data));
  //     } else {
  //       // print(response.statusMessage);
  //     }
  //   } catch (e) {
  //     // print(e);
  //   } finally {
  //     isnotiCount.value = false;
  //   }
  // }
}
