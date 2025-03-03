// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LocolhostData extends GetxController {
//   var listagent = [].obs;
//   List<String> listLocalAgentData = [];
//   List<Map<dynamic, dynamic>> listvalueModel = [];
//   Future<void> agentList() async {
//     var dio = Dio();
//     var response = await dio.request(
//       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/agent/list',
//       options: Options(
//         method: 'GET',
//       ),
//     );

//     if (response.statusCode == 200) {
//       List<dynamic> responseData = response.data;
//       listLocalAgentData =
//           responseData.map((item) => json.encode(item)).toList();
//       agentListlocal(listLocalAgentData);
//     }
//   }

//   agentListlocal(List<String> list) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setStringList('agentlist', list);
//     listLocalAgentData = list;
//     listagent.value = list
//         .map((item) => json.decode(item))
//         .cast<Map<String, dynamic>>()
//         .toList();
//     for (int i = 0; i < listagent.length; i++) {
//       listvalueModel.add(listagent[i]);
//     }
//   }
// }
