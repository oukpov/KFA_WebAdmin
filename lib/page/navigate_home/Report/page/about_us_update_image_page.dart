import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/about_us_image_controller.dart';
import 'about_us_image_page.dart';

class AboutUsUpdateImagePage extends StatefulWidget {
  final int imageId;
  const AboutUsUpdateImagePage({Key? key, required this.imageId})
      : super(key: key);

  @override
  _AboutUsUpdateImagePageState createState() => _AboutUsUpdateImagePageState();
}

class _AboutUsUpdateImagePageState extends State<AboutUsUpdateImagePage> {
  final AboutUsImageController _imageController =
      Get.put(AboutUsImageController());
  Uint8List? _selectedFile;
  String? _selectedFileName;
  bool _isUploading = false;

  Future<void> pickAndUpdateImageWeb() async {
    if (_selectedFile == null) {
      Get.snackbar('Error', 'Please select an image first');
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      var formData = dio.FormData.fromMap({
        'image': await dio.MultipartFile.fromBytes(
          _selectedFile!,
          filename: _selectedFileName,
        ),
      });

      var dioClient = dio.Dio();
      var response = await dioClient.post(
        'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/aboutusImage/updateimage/${widget.imageId}',
        data: formData,
        options: dio.Options(
          headers: {
            'Accept': 'application/json',
          },
          contentType: 'multipart/form-data',
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        // ignore: use_build_context_synchronously
        AwesomeDialog(
            context: context,
            animType: AnimType.leftSlide,
            headerAnimationLoop: false,
            dialogType: DialogType.success,
            showCloseIcon: false,
            title: 'Update Successfully',
            desc: 'Your image has been updated!',
            btnOkOnPress: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const AboutUsImagePage()),
              );
            },
            btnOkIcon: Icons.check_circle,
            onDismissCallback: (type) {
              Get.back();
            }).show();

        await _imageController.fetchAboutUsImageData();
      } else {
        print(response.statusMessage);
        // ignore: use_build_context_synchronously
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Error',
          desc: 'Failed to update image: ${response.statusMessage}',
          btnOkOnPress: () {},
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.red,
        ).show();
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: 'Error',
        desc: 'An error occurred while updating: $e',
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
      print(e);
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> OpenImage() async {
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text("Update Image About Us ${widget.imageId}",
              style: const TextStyle(fontWeight: FontWeight.bold)),
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
              onPressed: pickAndUpdateImageWeb,
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
                onPressed: OpenImage,
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
