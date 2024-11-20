import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:convert';
import '../models/about_us_image_model.dart';

class AboutUsImageController extends GetxController {
  var isLoading = false.obs;
  var aboutUsImageData = AboutUsImageModel().obs;
  List<AboutUsImageModel> aboutUsImageList = [];

  @override
  void onInit() {
    fetchAboutUsImageData();
    super.onInit();
  }

  String url =
      'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/aboutusImage';
  Future<void> fetchAboutUsImageData() async {
    try {
      isLoading(true);
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };

      var dioClient = dio.Dio();
      var response = await dioClient.request(
        '$url/get',
        options: dio.Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        if (response.data is List) {
          aboutUsImageList = (response.data as List)
              .map((item) => AboutUsImageModel.fromJson(item))
              .toList();
          if (aboutUsImageList.isNotEmpty) {
            aboutUsImageData.value = aboutUsImageList[0];
          }
        } else {
          aboutUsImageData.value = AboutUsImageModel.fromJson(response.data);
        }
        print(json.encode(response.data));
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error while getting data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future fetchAboutUsImageById(List imageIdList, int id) async {
    try {
      isLoading(true);
      var dioClient = dio.Dio();
      var response = await dioClient.request(
        '$url/getone/$id',
        options: dio.Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        imageIdList = json.decode(response.data);
      } else {
        print(response.statusMessage);
        return AboutUsImageModel(); // Return empty model on error
      }
    } catch (e) {
      print('Error while getting data by ID: $e');
      return AboutUsImageModel(); // Return empty model on error
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteAboutUsImage(int id) async {
    try {
      isLoading(true);
      var dioClient = dio.Dio();
      var response = await dioClient.request(
        '$url/delete/$id',
        options: dio.Options(
          method: 'DELETE',
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        // Refresh the image list after successful deletion
        await fetchAboutUsImageData();
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error while deleting image: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> uploadAboutUsImage(int id) async {
    try {
      isLoading(true);
      var dioClient = dio.Dio();
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var data = dio.FormData.fromMap({
        'files': [
          await dio.MultipartFile.fromFile(
              'postman-cloud:///1ef8dc0b-3e4a-4c80-bf2f-49036b0f65f5',
              filename: '1ef8dc0b-3e4a-4c80-bf2f-49036b0f65f5')
        ],
      });

      var response = await dioClient.request(
        '$url/updateimage/$id',
        options: dio.Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        // Refresh the image list after successful upload
        await fetchAboutUsImageData();
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error while uploading image: $e');
    } finally {
      isLoading(false);
    }
  }
}
