import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../models/contact_us_model.dart';

class ContactUsController extends GetxController {
  var isLoading = false.obs;
  var contactUsData = ContactUsModel().obs;
  String url = 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api';

  @override
  void onInit() {
    getContactUs();
    super.onInit();
  }

  Future<void> getContactUs() async {
    try {
      isLoading(true);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };

      var dio = Dio();
      var response = await dio.get(
        '$url/contact_us/getcontactus',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        contactUsData.value = ContactUsModel.fromJson(response.data);
      } else {
        print('Error: ${response.statusMessage}');
      }
    } catch (e) {
      if (e is DioError) {
        print('DioError details: ${e.message}');
        if (e.response != null) {
          print('Response status: ${e.response?.statusCode}');
          print('Response data: ${e.response?.data}');
        }
      }
      print('Error fetching contact us data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateContactUs({
    required String addressLine1,
    String? addressLine2,
    required String city,
    required String state,
    required String postalCode,
    required String country,
    required String latitude,
    required String longitude,
    String? mapUrl,
    required String hotlinePrimary,
    required String hotlineSecondary,
    required String hotlineThird,
    required String email,
  }) async {
    try {
      isLoading(true);
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };

      var data = {
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "city": city,
        "state": state,
        "postal_code": postalCode,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "map_url": mapUrl,
        "hotline_primary": hotlinePrimary,
        "hotline_secondary": hotlineSecondary,
        "hotline_third": hotlineThird,
        "email": email,
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      };

      var dio = Dio();
      var response = await dio.request(
        '$url/contact_us/update/3',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print('Contact info updated successfully');
        print(response.data);
        await getContactUs();
      } else {
        print('Error: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error updating contact info: $e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
