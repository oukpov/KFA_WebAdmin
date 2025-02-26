// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/Auth/auth.dart';
import '../../page/homescreen/responsive_layout.dart';

class Authentication extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  var isLocalhost = true.obs;
  var isblock = true.obs;
  var listblock = [].obs;
  List<String> listLocalhostData = [];
  List listlocalhost = [].obs;
  var listAdminUser = [].obs;
  var isAdmin = true.obs;
  int countCredit = 0;
  ////////////////
  var autoOptions = [].obs;
  var listTitles = [].obs;
  var optionIconLists = [].obs;
  var listTitlesettings = [].obs;
  var optionIconListsettings = [].obs;

  //////
  Future<void> login(AuthenModel authenModel, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listLocalhostData = prefs.getStringList('localhost') ?? [];
    listlocalhost = listLocalhostData
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();

    if (listlocalhost.isEmpty) {
      try {
        var headers = {'Content-Type': 'application/json'};
        var data = json.encode({
          "username": authenModel.user![0].username,
          "password": authenModel.user![0].password
        });
        var dio = Dio();
        var response = await dio.request(
          // 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/login/KFA',
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/login/Test/KFA',
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data,
        );
        if (response.statusCode == 200) {
          listlocalhost = response.data['user'];
          List<dynamic> responseData = response.data['user'];
          // print("====> $listlocalhost");
          listLocalhostData =
              responseData.map((item) => json.encode(item)).toList();
          localhostList(listLocalhostData);
          Get.snackbar(
            "Done!",
            "Login Successfuly",
            colorText: Colors.black,
            padding:
                const EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
            borderColor: const Color.fromARGB(255, 48, 47, 47),
            borderWidth: 1.0,
            borderRadius: 5,
            backgroundColor: const Color.fromARGB(255, 235, 242, 246),
            icon: const Icon(Icons.add_alert),
          );

          Get.to(
            ResponsiveHomePage(
              listUser: listlocalhost,
              url: "",
              id: "",
            ),
          );
        }
      } catch (e) {
        // print('Error occurred: $e');
      } finally {
        isLocalhost.value = false;
        if (listlocalhost.isEmpty) {
          Get.snackbar(
            "Can not Loging",
            "Please Check Email and Password",
            colorText: Colors.black,
            padding:
                const EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
            borderColor: const Color.fromARGB(255, 48, 47, 47),
            borderWidth: 1.0,
            borderRadius: 5,
            backgroundColor: const Color.fromARGB(255, 235, 242, 246),
            icon: const Icon(Icons.add_alert),
          );
        }
      }
    } else {
      isLocalhost.value = false;
      if (listlocalhost.isNotEmpty) {
        Get.to(
          ResponsiveHomePage(
            listUser: listlocalhost,
            url: "",
            id: "",
          ),
        );
      }
    }
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listLocalhostData = prefs.getStringList('localhost') ?? [];
    listlocalhost = listLocalhostData
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();
    if (listlocalhost.isNotEmpty) {
      getAgentByID(listlocalhost[0]['agency'].toString());
    }
  }

  Future<void> getAgentByID(String agency) async {
    await refrech(agency);
    try {
      isLocalhost.value = true;
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/allow/agentID/$agency',
        options: Options(
          method: 'POST',
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data;
        listLocalhostData =
            responseData.map((item) => json.encode(item)).toList();
        await localhostList(listLocalhostData);

        // Get.offAll(() => const LoginPage());
        // Get.to(
        //   const ResponsiveHomePage(
        //     // listUser: responseData,
        //     url: "",
        //     id: "",
        //   ),
        // );
      }
    } catch (e) {
      // print(e);
    } finally {
      isLocalhost.value = false;
    }
  }

  Future<void> refrech(String agency) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> listLocalhostData = prefs.getStringList('localhost') ?? [];
    List<Map<String, dynamic>> listlocalhost = listLocalhostData
        .map((item) => json.decode(item) as Map<String, dynamic>)
        .toList();
    int userIndex =
        listlocalhost.indexWhere((item) => item['agency'] == agency);

    if (userIndex != -1) {
      // Remove the entire user data
      listlocalhost.removeAt(userIndex);
    }

    // Update the SharedPreferences with the modified list
    List<String> updatedList =
        listlocalhost.map((item) => json.encode(item)).toList();
    await prefs.setStringList('localhost', updatedList);
  }

  Future<void> fetchData(int agency) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/allow/agentID/$agency',
      options: Options(
        method: 'POST',
      ),
    );
    if (response.statusCode == 200) {
      listlocalhost = response.data;
      int userIndex = listlocalhost
          .indexWhere((item) => int.parse(item['agency'].toString()) == agency);

      if (userIndex != -1) {
        // Remove the entire user data
        listlocalhost.removeAt(userIndex);
      }
      List<String> updatedList =
          listlocalhost.map((item) => json.encode(item)).toList();
      await prefs.setStringList('localhost', updatedList);
      // List<dynamic> responseData = response.data;
      // listLocalhostData =
      //     responseData.map((item) => json.encode(item)).toList();
      // localhostList(listLocalhostData);
    } else {
      // print(response.statusMessage);
    }
  }

  localhostList(List<String> list) async {
    // listTitles.clear();
    // optionIconLists.clear();
    // listTitlesettings.clear();
    // optionIconListsettings.clear();
    // // ///////////
    // listTitles.value = listTitle;
    // optionIconLists.value = optionIconList;
    // listTitlesettings.value = listTitlesetting;
    // optionIconListsettings.value = optionIconListsetting;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('localhost', list);
    listlocalhost = list
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();
    // if (listlocalhost[0]['add_zone'].toString() == "1") {
    //   autoOptions.add(
    //     {"title": "Add Zone Specail", "click": 3},
    //   );
    // }
    // if (listlocalhost[0]['comparable'].toString() == "1") {
    //   listTitles.add(
    //     {"title": "Comparable", "click": 3},
    //   );
    //   optionIconLists.add(
    //     {"icon": "assets/icons/Comparable.png"},
    //   );
    // }
    // if (listlocalhost[0]['property'].toString() == "1") {
    //   listTitles.add(
    //     {"title": "property", "click": 4},
    //   );
    //   optionIconLists.add(
    //     {"icon": "assets/icons/Property.png"},
    //   );
    // }
    // if (listlocalhost[0]['market_price_road'].toString() == "1") {
    //   autoOptions.add(
    //     {"title": "Main Road & Market Price", "click": 4},
    //   );
    // }
    // // print("autoOption : $autoOption");
    // if (listlocalhost[0]['approver'].toString() == "1") {
    //   listTitles.add(
    //     {"title": "Approval AutoVerbal", "click": 7},
    //   );
    //   optionIconLists.add(
    //     {"icon": "assets/icons/Inspector.png"},
    //   );
    // }
    // if (listlocalhost[0]['agency'].toString() == "28") {
    //   listTitles.add(
    //     {"title": "Users", "click": 8},
    //   );
    //   optionIconLists.add(
    //     {"icon": "assets/icons/User.png"},
    //   );
    // }
    // if (listlocalhost[0]['agency'].toString() == "28") {
    //   listTitles.add(
    //     {"title": "Report"},
    //   );
    //   optionIconLists.add(
    //     {"icon": "assets/icons/Report.png", "click": 9},
    //   );
    // }
    // if (listlocalhost[0]['agency'].toString() == "28") {
    //   listTitles.add(
    //     {"title": "Admin", "click": 10},
    //   );
    //   optionIconLists.add(
    //     {"icon": "assets/icons/Admin.png"},
    //   );
    // }
    // if (listlocalhost[0]['agency'].toString() == "28") {
    //   listTitles.add(
    //     {"title": "UI App"},
    //   );
    //   optionIconLists.add(
    //     {"icon": "assets/icons/ui_app.png", "click": 11},
    //   );
    // }
    // if (listlocalhost[0]['add_vpoint'].toString() == '1') {
    //   listTitlesettings.add({"title": "Add Point", "click": 22});
    //   optionIconListsettings.add({"icon": "assets/icons/v.jpg"});
    // }
  }

  Future<void> blockAgent() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/agentblock?user_id=83',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        listblock.value = response.data;

        // print(listblock.toString());
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    } finally {
      isblock.value = false;
    }
  }

  Future<void> checkAdminUser(int agency) async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/checkUser/Admin/$agency',
        options: Options(
          method: 'POST',
        ),
      );

      if (response.statusCode == 200) {
        listAdminUser.value = jsonDecode(json.encode(response.data));
        // print(listAdminUser.toString());
      }
    } catch (e) {
      // print(e);
    } finally {
      isAdmin.value = false;
    }
  }
  // Component component = Component();
  // Future<void> checkUpdate() async {
  //   var dio = Dio();
  //   var response = await dio.request(
  //     'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/updateNews/All',
  //     options: Options(
  //       method: 'POST',
  //     ),
  //   );

  //   if (response.statusCode == 200) {
  //     component.handleTap("Done!", "Notification to Client Update New");
  //   } else {
  //     print(response.statusMessage);
  //   }
  // }
}
