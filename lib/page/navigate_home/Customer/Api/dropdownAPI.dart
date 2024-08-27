import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DropdownAPI extends GetxController {
  var valutionList = [].obs;
  var appraiserList = [].obs;
  var accompanyList = [].obs;
  var inspectorList = [].obs;
  var inspectorsList = [].obs;
  var assiignedList = [].obs;
  var bankList = [].obs;
  var branchList = [].obs;
  var hometypeList = [].obs;
  var genderList = [].obs;
  Future<void> valutionTypeModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_valutiontype'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        valutionList.value = jsonBody;
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  Future<void> appraiserModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/appraiser/name'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['data'];
        appraiserList.value = jsonBody;
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  Future<void> accompanyModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Accompany_by/name'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['data'];
        accompanyList.value = jsonBody;
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  Future<void> inspectorModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Inspector/name'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['data'];
        inspectorList.value = jsonBody;
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  Future<void> inspectorsModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Inspectors/name'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['data'];
        inspectorsList.value = jsonBody;
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  Future<void> assiignedModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Registered_By/name'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['data'];
        assiignedList.value = jsonBody;
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  Future<void> bankModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/banks'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        bankList.value = jsonBody;
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  Future<void> branchModel(value) async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/bankbranch?bank_branch_details_id=$value'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody =
            jsonDecode(response.body)['bank_branches'];
        branchList.value = jsonBody;
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  Future<void> homeModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/properties_dropdown'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        hometypeList.value = jsonBody;
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  Future<void> genderModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Gender_model'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['data'];
        genderList.value = jsonBody;
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }
}
