import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:web_admin/models/user_model.dart';

class UserController extends GetxController {
  var users = <UserModel>[].obs;
  var isLoading = true.obs;
  var isApproving = ''.obs;
  var isDisApproving = ''.obs;
  var adminuser = [].obs;
  var id = ''.obs;
  @override
  void onInit() {
    fetchUsers();
    fetchOneUser(id.value);
    super.onInit();
  }

  void fetchUsers() async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var dio = Dio();
    try {
      var response = await dio.request(
        'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/getalluser',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var userList = (response.data as List)
            .map((user) => UserModel.fromJson(user))
            .toList();
        users.value = userList;
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future fetchOneUser(String userId) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/getoneuser/$userId',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      // print(json.encode(response.data));
      adminuser.value = jsonDecode(json.encode(response.data));
    } else {
      // print(response.statusMessage);
    }
  }

  Future<void> disApproveUser(int userId) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var dio = Dio();
    try {
      var response = await dio.request(
        'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/approve/$userId',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: {
          'approval_status': 'pending',
          'approved_by': '',
          'approved_at': (DateTime.now()).toIso8601String()
        },
      );

      if (response.statusCode == 200) {
        // print(response.data);
        // Refresh user list after approval
        fetchUsers();
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    }
  }

  Future<void> approveUser(int userId) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var dio = Dio();
    try {
      var response = await dio.request(
        'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/approve/$userId',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: {
          'approval_status': 'approved',
          'approved_by': int.parse(isApproving.value).toString(),
          'approved_at': (DateTime.now()).toIso8601String()
        },
      );

      if (response.statusCode == 200) {
        // print(response.data);
        // Refresh user list after approval
        fetchUsers();
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    }
  }
}
