import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Uint8List? _imageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Compression Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (croppedFile != null)
              // Image.memory(
              //   get_bytes!,
              //   width: 300,
              //   height: 200,
              //   fit: BoxFit.cover,
              // )
              Image.file(
                croppedFile!,
                width: 300,
                height: 200,
                fit: BoxFit.cover,
              ),
            // else if (_byesData != null)
            //   Image.memory(_byesData!,
            //       width: 300, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    OpenImgae();
                  },
                  child: const Text('Open'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _cropImage();
                  },
                  child: const Text('Crop'),
                ),
                ElevatedButton(
                  onPressed: () {
                    compress();
                  },
                  child: const Text('Compress'),
                ),
                ElevatedButton(
                  onPressed: () {
                    postImages();
                  },
                  child: const Text('posts'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String? base64string;
  late Uint8List list;
  Future<void> compress() async {
    var result = await FlutterImageCompress.compressWithFile(
      file!.absolute.path,
      minHeight: 1280,
      minWidth: 720,
      quality: 80,
    );
    base64string = base64.encode(result!);
    // setState(() {
    //   if (_byesData != null) {
    //     list = _byesData!;
    //   } else {
    //     list = get_bytes!;
    //   }
    // });

    // Uint8List result = await FlutterImageCompress.compressWithList(
    //   list,
    //   minHeight: 1920,
    //   minWidth: 1080,
    //   quality: 96,
    //   rotate: 135,
    // );
  }

  OpenImgae() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files!.elementAt(0);
      final reader = html.FileReader();
      WebUiSettings settings;
      reader.onLoadEnd.listen((event) {
        setState(() {
          _byesData =
              Base64Decoder().convert(reader.result.toString().split(',').last);
          _selectedFile = _byesData;
          croppedFile = File.fromRawPath(_byesData!);
          imageUrl = html.Url.createObjectUrlFromBlob(file.slice());
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  File? file;
  Uint8List? _selectedFile;
  Uint8List? _byesData;
  Uint8List? ImagePost;
  String imageUrl = '';
  File? croppedFile;
  html.File? cropimage_file;
  Uint8List? get_bytes;
  final completer = Completer<Uint8List>();

  String? _croppedBlobUrl;
  Future<void> _cropImage() async {
    WebUiSettings settings;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    settings = WebUiSettings(
      context: context,
      presentStyle: CropperPresentStyle.dialog,
      boundary: CroppieBoundary(
        width: (screenWidth * 0.4).round(),
        height: (screenHeight * 0.4).round(),
      ),
      viewPort: const CroppieViewPort(
        width: 300,
        height: 300,
      ),
      enableExif: true,
      enableZoom: true,
      showZoomer: true,
    );
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageUrl,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [settings],
    );
    if (croppedFile != null) {
      final bytes = await croppedFile.readAsBytes();
      final blob = html.Blob([bytes]);
      cropimage_file = html.File([blob], 'cropped-image.png');
      get_bytes = Uint8List.fromList(bytes);
      // await
      setState(() {
        _croppedBlobUrl = croppedFile.path;
        saveBlobToFile(_croppedBlobUrl!, croppedFile.path);
      });

      if (cropimage_file != null) {
        file = File(croppedFile.path); //convert Path to File
      }
    }
  }

  Future<void> saveBlobToFile(String blobUrl, String filename) async {
    final response = await http.get(Uri.parse(blobUrl));
    final bytes = response.bodyBytes;

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/$filename";
  }

  Future<void> postImages() async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "image": base64string!,
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/image/base64',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }
}
