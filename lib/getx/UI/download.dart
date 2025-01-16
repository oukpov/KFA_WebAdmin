import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadImage extends GetxController {
  var listImage1 = [].obs;
  var listImage2 = [].obs;
  var listImage3 = [].obs;
  var listImage4 = [].obs;
  var listImage5 = [].obs;
  var listImage6 = [].obs;
  var isImage = false.obs;
  var progress = 0.0.obs;
  @override
  void onInit() {
    imageLogo();
    super.onInit();
  }

  List<String> listLocalImagehostData = [];
  var imageUrl =
      "https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/icons_application/downloadImage.png"
          .obs;
  var listImagelocalhost = <Map<String, dynamic>>[].obs;
  Future<void> imageLogo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Load locally saved images from SharedPreferences
    listLocalImagehostData = prefs.getStringList('localhost_Image') ?? [];
    listImagelocalhost.value = listLocalImagehostData
        .map((item) => json.decode(item) as Map<String, dynamic>)
        .toList();

    if (listImagelocalhost.isEmpty) {
      try {
        // isImage.value = true;
        var dio = Dio();
        var response = await dio.post(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/icon/fetch/images',
        );

        if (response.statusCode == 200) {
          // Populate lists with fetched data
          listImage1.value = response.data['1'];
          //Payment
          listImage2.value = response.data['2'];

          ///
          listImage3.value = response.data['3'];

          ///
          listImage4.value = response.data['4'];
          //Silde in Abouts
          listImage5.value = response.data['5'];

          ///
          listImage6.value = response.data['6'];

          // Combine all images into one list and save locally
          List<dynamic> combinedImages = [
            ...listImage1,
            ...listImage2,
            ...listImage3,
            ...listImage4,
            ...listImage5,
            ...listImage6,
          ];

          await prefs.setStringList(
            'localhost_Image',
            combinedImages.map((item) => json.encode(item)).toList(),
          );
        }
      } catch (e) {
        // print('Error fetching images: $e');
      } finally {
        isImage.value = false;
      }
    } else {
      // Load images from local storage and assign to lists
      listImage1.value =
          listImagelocalhost.where((item) => item['no'] == '1').toList();

      listImage2.value =
          listImagelocalhost.where((item) => item['no'] == '2').toList();
      listImage3.value =
          listImagelocalhost.where((item) => item['no'] == '3').toList();
      listImage4.value =
          listImagelocalhost.where((item) => item['no'] == '4').toList();
      listImage5.value =
          listImagelocalhost.where((item) => item['no'] == '5').toList();
      listImage6.value =
          listImagelocalhost.where((item) => item['no'] == '6').toList();
    }
    if (listImage6.isNotEmpty) {
      progress.value = 1.0;
    }
  }

  Future<void> removeImage() async {
    try {
      isImage.value = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> listLocalhostData =
          prefs.getStringList('localhost_Image') ?? [];
      List<Map<String, dynamic>> listlocalhost = listLocalhostData
          .map((item) => json.decode(item) as Map<String, dynamic>)
          .toList();
      listlocalhost.clear();
      List<String> updatedList =
          listlocalhost.map((item) => json.encode(item)).toList();
      await prefs.setStringList('localhost_Image', updatedList);
      listImage1.clear();
      listImage2.clear();
      listImage3.clear();
      listImage4.clear();
      listImage5.clear();
      listImage6.clear();
    } catch (e) {
      // print(e);
    } finally {
      isImage.value = false;
    }
  }

  String urlImage(List list, String value) {
    Map<String, dynamic> result =
        list.firstWhere((image) => image['id'] == value, orElse: () => null);
    String url = result['url'] ??
        "https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/icons_application/downloadImage.png";
    return url;
  }
}
