import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../sponsor_list_page.dart';

class UploadImagePage extends StatefulWidget {
  const UploadImagePage({Key? key}) : super(key: key);

  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  Uint8List? _selectedFile;
  String? _selectedFileName;
  bool _isUploading = false;

  Future<void> pickAndUploadImageWeb() async {
    if (_selectedFile == null) {
      Get.snackbar('Error', 'Please select an image first');
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/insertbanners'));
      request.files.add(http.MultipartFile.fromBytes(
          'bannerimage', _selectedFile!,
          filename: _selectedFileName));
      var res = await request.send();
      if (res.statusCode == 200) {
        // ignore: use_build_context_synchronously
        AwesomeDialog(
            context: context,
            animType: AnimType.leftSlide,
            headerAnimationLoop: false,
            dialogType: DialogType.success,
            showCloseIcon: false,
            title: 'Save Successfully',
            desc: 'Your image has been uploaded!',
            btnOkOnPress: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const SponsorListPage()),
              );
            },
            btnOkIcon: Icons.check_circle,
            onDismissCallback: (type) {
              Get.back();
            }).show();
      } else {
        Get.snackbar('Error', 'Failed to upload image',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            icon: Icon(Icons.error, color: Colors.white));
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while uploading',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: const Icon(Icons.error, color: Colors.white));
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> OpenImgae() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.draggable = true;
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files!.first;
      final reader = html.FileReader();
      reader.onLoadEnd.listen((event) {
        setState(() {
          _selectedFile = const Base64Decoder()
              .convert(reader.result.toString().split(',').last);
          _selectedFileName = file.name;
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Upload Image",
              style: TextStyle(fontWeight: FontWeight.bold)),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: _isUploading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.cloud_upload, size: 28),
              onPressed: pickAndUploadImageWeb,
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              if (_selectedFile != null)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InteractiveViewer(
                      boundaryMargin: const EdgeInsets.all(20.0),
                      minScale: 0.1,
                      maxScale: 4.0,
                      child: Image.memory(
                        _selectedFile!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                )
              else
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(Icons.image, size: 80, color: Colors.grey[400]),
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: OpenImgae,
                icon: const Icon(Icons.add_a_photo),
                label: const Text("Select Image"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}