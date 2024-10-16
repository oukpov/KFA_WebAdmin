// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/Auth/auth.dart';
import '../../page/homescreen/responsive_layout.dart';
import '../../page/navigate_home/Comparable/comparable_new/add_comparable_new_page.dart';
import '../component/getx._snack.dart';

class Authentication extends GetxController {
  var isLocalhost = true.obs;
  var isblock = true.obs;
  var listblock = [].obs;
  List<String> listLocalhostData = [];
  List listlocalhost = [].obs;
  int countCredit = 0;
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
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/login/KFA',
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data,
        );
        if (response.statusCode == 200) {
          listlocalhost = jsonDecode(json.encode(response.data))['user'];
          List<dynamic> responseData = response.data['user'];
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

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    //For research
                    // AddComparable(
                    //       type: (value) {},
                    //       addNew: (value) {},
                    //       listlocalhosts: listlocalhost,
                    //     )
                    //Config Admin
                    ResponsiveHomePage(
                  listUser: listlocalhost,
                  url: "",
                  id: "",
                ),
              ));
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
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  //Dmin
                  // AddComparable(
                  //       type: (value) {},
                  //       addNew: (value) {},
                  //       listlocalhosts: listlocalhost,
                  //     )
                  //Config Admin
                  ResponsiveHomePage(
                listUser: listlocalhost,
                url: "",
                id: "",
              ),
            ));
      }
    }
  }

  localhostList(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('localhost', list);
    listlocalhost = list
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();
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
        listblock.value = jsonDecode(json.encode(response.data));

        // print(listblock.toString());
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    } finally {
      isblock.value = false;
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
