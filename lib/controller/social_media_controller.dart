import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../models/social_media_model.dart';
import 'package:dio/dio.dart' as dioPackage;

class SocialMediaController extends GetxController {
  var socialMediaData = SocialMediaModel().obs;
  var isLoading = false.obs;
  var url =
      'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/social_media';
  @override
  void onInit() {
    getSocialMedia();
    super.onInit();
  }

  Future<void> getSocialMedia() async {
    try {
      isLoading(true);
      var headers = {
        'Content-Type': 'application/json',
        'Content-Type': 'application/json'
      };
      var dio = Dio();
      var response = await dio.request(
        '$url/get',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        socialMediaData.value = SocialMediaModel.fromJson(response.data);
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> addSocialMedia({
    required String filePath,
    required String fileName,
  }) async {
    try {
      isLoading(true);
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };

      var dio = Dio();
      var data = dioPackage.FormData.fromMap({
        'files': [
          await dioPackage.MultipartFile.fromFile(filePath, filename: fileName)
        ],
      });

      var response = await dio.request(
        '$url/add',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        // Refresh social media data after successful add
        await getSocialMedia();
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteSocialMedia({required String id}) async {
    try {
      isLoading(true);
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };

      var dio = Dio();
      var response = await dio.request(
        '$url/delete/$id',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        // Refresh social media data after successful delete
        await getSocialMedia();
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateSocialMedia({
    required String id,
    required String platform,
    required String url,
  }) async {
    try {
      isLoading(true);

      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };

      var data = json.encode({
        "platform": platform,
        "url": url,
      });

      var dio = Dio();
      var baseUrl = this.url; // Store base URL to avoid conflict

      var response = await dio.request(
        '$baseUrl/update/$id',
        options: Options(
          method: 'POST',
          headers: headers,
          validateStatus: (status) {
            return status! < 500; // Accept all status codes below 500
          },
        ),
        data: data,
      );

      // Accept both 200 and 201 status codes as success
      if (response.statusCode == 200 || response.statusCode == 201) {
        await getSocialMedia();
      } else {
        throw DioError(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to update social media: ${response.statusMessage}',
        );
      }
    } on DioError catch (e) {
      if (e.response != null) {}
      throw e;
    } catch (e) {
      throw e;
    } finally {
      isLoading(false);
    }
  }
}
