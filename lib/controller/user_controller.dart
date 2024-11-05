import 'dart:convert';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:web_admin/models/user_model.dart';

class UserController extends GetxController {
  final Dio _dio = Dio();
  var users = <UserModel>[].obs;
  var isLoading = true.obs;
  var isApproving = ''.obs;
  var isDisApproving = ''.obs;
  var adminuser = [].obs;
  var id = ''.obs;
  var errorMessage = ''.obs;

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
      onError: (error, handler) {
        print('Error Status Code: ${error.response?.statusCode}');
        print('Error Message: ${error.message}');
        print('Error Response: ${error.response?.data}');
        return handler.next(error);
      },
      onRequest: (options, handler) {
        print('Making request to: ${options.uri}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('Received response: ${response.statusCode}');
        return handler.next(response);
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
        print('User List: ${users.value.length}');
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
}
