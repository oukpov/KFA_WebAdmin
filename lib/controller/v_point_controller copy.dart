// // vpoint_update_controller.dart

// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:web_admin/models/v_point_model.dart';

// class VpointUpdateController extends GetxController {
//   final vpoint = VpointModel().obs;
//   final isLoading = false.obs;
//   final url =
//       'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api';
//   @override
//   void onInit() {
//     super.onInit();
//     fetchVpoint();
//   }

//   Future<void> fetchVpoint() async {
//     isLoading(true);
//     try {
//       final response = await http.get(Uri.parse('$url/getvpoint'));
//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         if (jsonData is List) {
//           final vpointList =
//               jsonData.map((item) => VpointModel.fromJson(item)).toList();
//           if (vpointList.isNotEmpty) {
//             vpoint(vpointList.first);
//           }
//         } else if (jsonData is Map<String, dynamic>) {
//           vpoint(VpointModel.fromJson(jsonData));
//         } else {
//           Get.snackbar('Error', 'Invalid data format');
//         }
//       } else {
//         Get.snackbar('Error', 'Failed to fetch data');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An error occurred: $e');
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<void> handleUpdate(VpointModel updatedVpoint) async {
//     print('${updatedVpoint.iDControl} dkdkdkdk');
//     var headers = {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json'
//     };
//     var request = http.Request('POST', Uri.parse('$url/updatevpoint'));
//     request.body = json.encode({
//       "ID_control": updatedVpoint.iDControl,
//       "id_user_control": updatedVpoint.idUserControl,
//       "count_autoverbal": updatedVpoint.countAutoverbal,
//       "create": updatedVpoint.create,
//       "expiry": updatedVpoint.expiry,
//       "their_plans": updatedVpoint.theirPlans,
//       "balance": updatedVpoint.balance,
//       "created_verbals": updatedVpoint.createdVerbals
//     });
//     request.headers.addAll(headers);

//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//     } else {
//       print(response.reasonPhrase);
//     }
//   }

//   Future<void> handleUpdatetest() async {
//     var headers = {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json'
//     };
//     var request = http.Request('POST', Uri.parse('$url/updatevpoint'));
//     request.body = json.encode({
//       "ID_control": 269,
//       "id_user_control": "202492576717",
//       "count_autoverbal": 1000,
//       "create": "2024-10-08 00:00:00",
//       "expiry": "2024-10-30 00:00:00",
//       "their_plans": "30",
//       "balance": 0,
//       "created_verbals": 5
//     });
//     request.headers.addAll(headers);

//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
// }
