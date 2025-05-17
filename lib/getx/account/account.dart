import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/getx/component/getx._snack.dart';

class EditController extends GetxController {
  var isAccount = false.obs;
  var listAccount = [].obs;
  Component component = Component();
  Future<void> editAccount(
    String controlleruserID,
    String firstName,
    String lastName,
    String telNum,
    String gender,
    String bankName,
    String password,
  ) async {
    try {
      isAccount.value = true;
      var headers = {
        'Content-Type': 'application/json',
        'Cookie':
            'XSRF-TOKEN=eyJpdiI6InhabDVpalhFRjAxQXVjUGwvU203aXc9PSIsInZhbHVlIjoiVTVEUHFZbkxvRjF2RE1qSi9yY0EzT01wTjBXQjVvZzJ6b05KUWIwSDVuRm85bTk3RDNjNHdEZ0REL1d5Z0FTbGNvazF4c21IUFhMWXdLK2xMY0hWZ0hRQkdLdW44SHpCVEtPbG1xdWhDZ1VIOUhmQ3BEMHVpSE5XTjl3SlFsSGgiLCJtYWMiOiI2MjNhOTdmYWJmNjRlOTFmYmE3MDJiMDlkYzQwNjgxYTBiOTkyNjc0YjdlMzVkZmJmNjVhOWU0OWVkOGQ2ZGIxIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IjdjZ3RLdmptN3ZxeThJZERxbkNlelE9PSIsInZhbHVlIjoicnI1RTZRZFhwK2JjdXNBeENlNDhobjd2VEZJemJwSExEMWFncVJHTVhMM2FQVm5BR3piSlhWMzNUb3VtWk14UFRudWRFc0xnd3hBR0JxeG5xVDd5cFRzMXM3bHJGS2NzTzdYUXZZQUx5WWl4UEYyTi9Nb2tUdTRGWUZHMlFBUTIiLCJtYWMiOiJmMzFhMmIxZWZiMjE5NjU2NTc1YjYzOTVjNTZiYzVjZTJhNDlkNTJlN2IxYzI3YjA5MjBmNTRhYjI2NDA2NGQ5IiwidGFnIjoiIn0%3D'
      };
      var data = json.encode({
        "control_user": controlleruserID,
        "first_name": firstName,
        "last_name": lastName,
        "tel_num": telNum,
        "gender": gender,
        "bank_name": bankName,
        "password": password
      });
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user/editPassword',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        // final prefs = await SharedPreferences.getInstance();
        // prefs.clear();
        // listlocalhost.value = response.data['data'];

        // listLocalhostData =
        //     listlocalhost.map((item) => json.encode(item)).toList();
        // localhostList(listLocalhostData);
        // component.handleTap("Changeed Password ", "", 1);
        // await registerController.checkOTPCount("", context, "", true);
      } else {
        component.handleTap("Please Check Old Password", "", 1);
      }
    } catch (e) {
      // print(e);
    } finally {
      isAccount.value = false;
    }
  }

  Future<void> editPassword(String controlUser, String password,
      String passwordComform, BuildContext context) async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6InhabDVpalhFRjAxQXVjUGwvU203aXc9PSIsInZhbHVlIjoiVTVEUHFZbkxvRjF2RE1qSi9yY0EzT01wTjBXQjVvZzJ6b05KUWIwSDVuRm85bTk3RDNjNHdEZ0REL1d5Z0FTbGNvazF4c21IUFhMWXdLK2xMY0hWZ0hRQkdLdW44SHpCVEtPbG1xdWhDZ1VIOUhmQ3BEMHVpSE5XTjl3SlFsSGgiLCJtYWMiOiI2MjNhOTdmYWJmNjRlOTFmYmE3MDJiMDlkYzQwNjgxYTBiOTkyNjc0YjdlMzVkZmJmNjVhOWU0OWVkOGQ2ZGIxIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IjdjZ3RLdmptN3ZxeThJZERxbkNlelE9PSIsInZhbHVlIjoicnI1RTZRZFhwK2JjdXNBeENlNDhobjd2VEZJemJwSExEMWFncVJHTVhMM2FQVm5BR3piSlhWMzNUb3VtWk14UFRudWRFc0xnd3hBR0JxeG5xVDd5cFRzMXM3bHJGS2NzTzdYUXZZQUx5WWl4UEYyTi9Nb2tUdTRGWUZHMlFBUTIiLCJtYWMiOiJmMzFhMmIxZWZiMjE5NjU2NTc1YjYzOTVjNTZiYzVjZTJhNDlkNTJlN2IxYzI3YjA5MjBmNTRhYjI2NDA2NGQ5IiwidGFnIjoiIn0%3D'
    };
    var data = json.encode({
      "control_user": controlUser,
      // "password_old": passwordOld,
      "password": password,
      "password_confirmation": passwordComform
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user/editPasswordAdmin',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      Get.back();
      component.handleTap("Changeed Password ", "", 1);

      // await registerController.checkOTPCount("", context, "", true);
    } else {
      component.handleTap("Please Check Old Password", "", 1);
    }
  }

  Future<void> updateAuth(
    String firstname,
    String lastname,
    String gender,
    String knowfrom,
    String controllerID,
    String telNum,
    BuildContext context,
    // String image,
  ) async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6InhabDVpalhFRjAxQXVjUGwvU203aXc9PSIsInZhbHVlIjoiVTVEUHFZbkxvRjF2RE1qSi9yY0EzT01wTjBXQjVvZzJ6b05KUWIwSDVuRm85bTk3RDNjNHdEZ0REL1d5Z0FTbGNvazF4c21IUFhMWXdLK2xMY0hWZ0hRQkdLdW44SHpCVEtPbG1xdWhDZ1VIOUhmQ3BEMHVpSE5XTjl3SlFsSGgiLCJtYWMiOiI2MjNhOTdmYWJmNjRlOTFmYmE3MDJiMDlkYzQwNjgxYTBiOTkyNjc0YjdlMzVkZmJmNjVhOWU0OWVkOGQ2ZGIxIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IjdjZ3RLdmptN3ZxeThJZERxbkNlelE9PSIsInZhbHVlIjoicnI1RTZRZFhwK2JjdXNBeENlNDhobjd2VEZJemJwSExEMWFncVJHTVhMM2FQVm5BR3piSlhWMzNUb3VtWk14UFRudWRFc0xnd3hBR0JxeG5xVDd5cFRzMXM3bHJGS2NzTzdYUXZZQUx5WWl4UEYyTi9Nb2tUdTRGWUZHMlFBUTIiLCJtYWMiOiJmMzFhMmIxZWZiMjE5NjU2NTc1YjYzOTVjNTZiYzVjZTJhNDlkNTJlN2IxYzI3YjA5MjBmNTRhYjI2NDA2NGQ5IiwidGFnIjoiIn0%3D'
    };
    var data = json.encode({
      "first_name": firstname,
      "last_name": lastname,
      "gender": gender,
      "tel_num": telNum,
      "known_from": knowfrom,
      // "profile_Image": image
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user/edit/$controllerID',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      Get.back();
      component.handleTap("Update Successfuly", "", 1);
    } else {
      component.handleTap("Please try again", "", 1);
    }
  }
}
