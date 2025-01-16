import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:web_admin/models/user_model.dart';

class UserController extends GetxController {
  final Dio _dio = Dio();
  var users = <UserModel>[].obs;
  var isLoading = true.obs;
  var isApproving = ''.obs;
  var isDisApproving = ''.obs;
  var isBlocking = ''.obs;
  var isUnblocking = ''.obs;
  var adminuser = [].obs;
  var id = ''.obs;
  var errorMessage = ''.obs;
  final isSearch = false.obs;
  var listsearch = [].obs;
  String url = 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api';
  @override
  void onInit() {
    super.onInit();
    _initializeDio();
    fetchUsers();
    fetchOneUser(id.value);
  }

  void _initializeDio() {
    _dio.options.baseUrl =
        'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api';
    _dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };

    // Add interceptor for debugging
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) async {
        print('Error Status Code: ${error.response?.statusCode}');
        print('Error Message: ${error.message}');
        print('Error Response: ${error.response?.data}');
        handler.next(error);
      },
      onRequest: (options, handler) async {
        print('Making request to: ${options.uri}');
        handler.next(options);
      },
      onResponse: (response, handler) async {
        print('Received response: ${response.statusCode}');
        handler.next(response);
      },
    ));
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _dio.get('/getalluser');

      if (response.statusCode == 200) {
        final userList = (response.data as List)
            .map((user) => UserModel.fromJson(user))
            .toList();
        users.value = userList;
      } else {
        errorMessage.value = 'Failed to load users: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      errorMessage.value = _handleDioError(e);
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOneUser(String userId) async {
    try {
      if (userId.isEmpty) return;

      final response = await _dio.get('/getoneuser/$userId');

      if (response.statusCode == 200) {
        adminuser.value = jsonDecode(json.encode(response.data));
      } else {
        errorMessage.value = 'Failed to load user details';
      }
    } on DioError catch (e) {
      errorMessage.value = _handleDioError(e);
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred: $e';
    }
  }

  Future<void> disApproveUser(int userId) async {
    try {
      isDisApproving.value = userId.toString();

      final response = await _dio.post(
        '/approve/$userId',
        data: {
          'approval_status': 'pending',
          'approved_by': '',
          'approved_at': DateTime.now().toIso8601String()
        },
      );

      if (response.statusCode == 200) {
        await fetchUsers();
      } else {
        errorMessage.value = 'Failed to disapprove user';
      }
    } on DioError catch (e) {
      errorMessage.value = _handleDioError(e);
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred: $e';
    } finally {
      isDisApproving.value = '';
    }
  }

  Future<void> approveUser(int userId, int approvedBy) async {
    try {
      isApproving.value = userId.toString();

      final response = await _dio.post(
        '/approve/$userId',
        data: {
          'approval_status': 'approved',
          'approved_by': approvedBy,
          'approved_at': DateTime.now().toIso8601String()
        },
      );

      if (response.statusCode == 200) {
        await fetchUsers();
      } else {
        errorMessage.value = 'Failed to approve user';
      }
    } on DioError catch (e) {
      errorMessage.value = _handleDioError(e);
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred: $e';
    } finally {
      isApproving.value = '';
    }
  }

  Future<void> blockUser(String controlUser) async {
    try {
      isBlocking.value = controlUser;

      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };

      final dio = Dio();
      final response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/blockusers/$controlUser',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        await fetchUsers();
      } else {
        errorMessage.value = 'Failed to block user: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      errorMessage.value = _handleDioError(e);
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred: $e';
    } finally {
      isBlocking.value = '';
    }
  }

  Future<void> unblockUser(String controlUser) async {
    try {
      isUnblocking.value = controlUser;

      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };

      final dio = Dio();
      final response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/unblockusers/$controlUser',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        await fetchUsers();
      } else {
        errorMessage.value =
            'Failed to unblock user: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      errorMessage.value = _handleDioError(e);
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred: $e';
    } finally {
      isUnblocking.value = '';
    }
  }

  String _handleDioError(DioError e) {
    switch (e.type) {
      case DioErrorType.connectTimeout:
        return 'Connection timed out';
      case DioErrorType.sendTimeout:
        return 'Send timeout occurred';
      case DioErrorType.receiveTimeout:
        return 'Receive timeout occurred';
      case DioErrorType.response:
        return 'Server responded with error ${e.response?.statusCode}';
      case DioErrorType.cancel:
        return 'Request was cancelled';
      case DioErrorType.other:
        if (e.error.toString().contains('XMLHttpRequest error')) {
          return 'CORS error occurred. Please check server configuration.';
        }
        return 'Connection error occurred. Please check your internet connection.';
      default:
        return 'An unexpected error occurred';
    }
  }

  Future<void> searchphone(String telNum) async {
    try {
      isSearch.value = true;
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };

      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/searchphone?search=$telNum',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(json.encode(response.data))['data'];
        if (jsonData is List) {
          listsearch.value =
              jsonData.map((item) => UserModel.fromJson(item)).toList();
        } else if (jsonData is Map<String, dynamic>) {
          listsearch.value = [UserModel.fromJson(jsonData)];
        } else {
          listsearch.value = [];
        }
      }
    } catch (e) {
      print('Error in searchphone: $e');
      listsearch.value = [];
    } finally {
      isSearch.value = false;
    }
  }

  Future<void> SearchUser(String telNum) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/searchuser?search=$telNum',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(json.encode(response.data))['data'];
        if (jsonData is List) {
          listsearch.value =
              jsonData.map((item) => UserModel.fromJson(item)).toList();
        } else if (jsonData is Map<String, dynamic>) {
          listsearch.value = [UserModel.fromJson(jsonData)];
        } else {
          listsearch.value = [];
        }
      }
    } catch (e) {
      print('Error in SearchUser: $e');
      listsearch.value = [];
    }
  }

  Future<void> updateUser(
    String user_identifier, {
    String new_email = '',
    String new_password = '',
    String new_password_confirmation = '',
    String first_name = '',
    String last_name = '',
    String tel_num = '',
  }) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };

      // Only include non-empty values in the request
      Map<String, String> requestData = {
        "user_identifier": user_identifier,
      };

      if (new_email.isNotEmpty) {
        requestData["new_email"] = new_email;
      }

      if (new_password.isNotEmpty) {
        requestData["new_password"] = new_password;
        requestData["new_password_confirmation"] = new_password_confirmation;
      }

      if (first_name.isNotEmpty) {
        requestData["first_name"] = first_name;
      }

      if (last_name.isNotEmpty) {
        requestData["last_name"] = last_name;
      }

      if (tel_num.isNotEmpty) {
        requestData["tel_num"] = tel_num;
      }

      var dio = Dio();
      var response = await dio.request(
        '$url/createpassword',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        // Get the navigation context
        var context = Get.context!;

        // Close the current dialog if it's open
        Navigator.of(context).pop();

        // Show success dialog
        AwesomeDialog(
          padding:
              const EdgeInsets.only(right: 30, left: 30, bottom: 10, top: 10),
          alignment: Alignment.center,
          width: 350,
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: "Success",
          desc: "User information updated successfully!",
          btnOkOnPress: () {
            // Clear the text controller

            // Refresh the user list
            fetchUsers();
          },
          btnOkText: "OK",
          btnOkColor: Colors.green,
        ).show();

        print('Update successful: ${json.encode(response.data)}');
      }
    } catch (e) {
      print('Error during update: $e');

      // Handle different types of errors
      String errorMessage =
          'An error occurred while updating user information.';

      if (e is DioError) {
        if (e.response != null) {
          // Get error message from response if available
          var responseData = e.response?.data;
          if (responseData != null && responseData['message'] != null) {
            errorMessage = responseData['message'];
          }

          // Handle validation errors
          if (responseData != null && responseData['errors'] != null) {
            var errors = responseData['errors'];
            if (errors is Map) {
              errorMessage = errors.values.first.first.toString();
            }
          }
        }

        // Show error dialog
        var context = Get.context!;
        AwesomeDialog(
          padding:
              const EdgeInsets.only(right: 30, left: 30, bottom: 10, top: 10),
          alignment: Alignment.center,
          width: 350,
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: "Error",
          desc: errorMessage,
          btnOkOnPress: () {},
          btnOkText: "OK",
          btnOkColor: Colors.red,
        ).show();
      }
    }
  }
}
