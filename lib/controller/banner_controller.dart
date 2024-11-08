import 'dart:html';
import 'dart:typed_data';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import '../models/banner_model.dart';
import 'dart:io';
import 'package:universal_html/html.dart' as html;

class BannerController extends GetxController {
  var isLoading = true.obs;
  var banners = <BannerModel>[].obs;
  Uint8List? _selectedFile;
  Uint8List? byesData;
  String imageUrl = '';
  bool cropORopen = false;
  String base64string = '';
  List? onedata;
  String url = 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api';
  @override
  void onInit() {
    getonedata(onedata![0]['id']);
    fetchBanners();
    openImgae();
    super.onInit();
  }

  Future<void> fetchBanners() async {
    var dioInstance = dio.Dio();
    try {
      isLoading(true);
      var response = await dioInstance.request(
        '$url/banners',
        options: dio.Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(json.encode(response.data));
        banners.value = (jsonData as List)
            .map((item) => BannerModel.fromJson(item))
            .toList();
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getonedata(String id) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var dio = Dio();
    var response = await dio.request(
      '$url/getonedata/$id',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      onedata = jsonDecode(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  void openImgae() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files!.elementAt(0);
      final reader = html.FileReader();
      // Check size of the file
      // int fileSizeInBytes = file.size;
      // print('File size: $fileSizeInBytes bytes');
      reader.onLoadEnd.listen((event) {
        // setState(() {
        byesData = const Base64Decoder()
            .convert(reader.result.toString().split(',').last);
        _selectedFile = byesData;
        imageUrl = html.Url.createObjectUrlFromBlob(file.slice());
        comporessList(byesData!);
        cropORopen = false;
        // });
      });
      reader.readAsDataUrl(file);
    });
  }

  Future<Uint8List> comporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 135,
    );
    // setState(() {
    base64string = base64.encode(result);
    // });

    return result;
  }

  Future<void> insertBanner(BannerModel bannerModel) async {
    if (byesData != null) {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data'
      };

      var dioInstance = dio.Dio();
      var data = dio.FormData.fromMap({
        'bannerimage': await dio.MultipartFile.fromFile(base64Encode(byesData!),
            filename: 'image.png'),
        'url': bannerModel.url,
      });

      var response = await dioInstance.request(
        '$url/insertbanners',
        options: dio.Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        // Add the new banner to the list
        var newBanner = BannerModel.fromJson(response.data);
        banners.add(newBanner);
        fetchBanners();
      } else {
        print(response.statusMessage);
      }
    }
  }

  Future<void> updateBanner(String id) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data'
      };
      var data = dio.FormData.fromMap({
        'bannerimage':
            await dio.MultipartFile.fromFile(image.path, filename: image.name),
        'url':
            '', // You need to provide a URL here or remove this line if not needed
      });

      var dioInstance = dio.Dio();
      var response = await dioInstance.request(
        '$url/banners/$id/update-image',
        options: dio.Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        fetchBanners();
      } else {
        print(response.statusMessage);
      }
    }
  }

  Future<void> deleteBanner(String id) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var dioInstance = dio.Dio();
    var response = await dioInstance.request(
      '$url/deletebanners/$id',
      options: dio.Options(
        method: 'DELETE',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      fetchBanners();
    } else {
      print(response.statusMessage);
    }
  }
}
