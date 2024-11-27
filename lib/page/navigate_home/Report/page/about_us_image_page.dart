import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/page/navigate_home/Report/page/upload_about_us_image_page.dart';
import 'package:web_admin/page/navigate_home/Report/page/upload_about_us_image_slide_page.dart';
import '../../../../controller/about_us_image_controller.dart';
import 'about_us_update_image_page.dart';

class AboutUsImagePage extends StatefulWidget {
  const AboutUsImagePage({super.key});

  @override
  State<AboutUsImagePage> createState() => _AboutUsImagePageState();
}

class _AboutUsImagePageState extends State<AboutUsImagePage> {
  final AboutUsImageController _imageController =
      Get.put(AboutUsImageController());
  final PageController _pageController = PageController();
  Uint8List? _selectedFile;
  String? _selectedFileName;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _imageController.fetchAboutUsImageData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us Images",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_selectedFile != null)
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                padding: const EdgeInsets.all(16),
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
            Obx(
              () => _imageController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        spacing: 16.0,
                        runSpacing: 16.0,
                        children: List.generate(
                          _imageController.aboutUsImageList.length > 10
                              ? 10
                              : _imageController.aboutUsImageList.length,
                          (index) {
                            final image =
                                _imageController.aboutUsImageList[index];
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: InteractiveViewer(
                                      boundaryMargin:
                                          const EdgeInsets.all(20.0),
                                      minScale: 0.1,
                                      maxScale: 4.0,
                                      child: CachedNetworkImage(
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.contain,
                                        imageUrl: image.url ?? '',
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 8),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                spreadRadius: 1,
                                                blurRadius: 3,
                                                offset: const Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.blue,
                                              size: 24,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AboutUsUpdateImagePage(
                                                    imageId:
                                                        int.parse(image.id!),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        // Container(
                                        //   decoration: BoxDecoration(
                                        //     shape: BoxShape.circle,
                                        //     color: Colors.white,
                                        //     boxShadow: [
                                        //       BoxShadow(
                                        //         color: Colors.black
                                        //             .withOpacity(0.2),
                                        //         spreadRadius: 1,
                                        //         blurRadius: 3,
                                        //         offset: const Offset(0, 1),
                                        //       ),
                                        //     ],
                                        //   ),
                                        //   child: IconButton(
                                        //     icon: const Icon(
                                        //       Icons.delete,
                                        //       color: Colors.red,
                                        //       size: 24,
                                        //     ),
                                        //     onPressed: () {
                                        //       AwesomeDialog(
                                        //         context: context,
                                        //         animType: AnimType.scale,
                                        //         dialogType: DialogType.warning,
                                        //         title: 'Delete Image',
                                        //         desc:
                                        //             'Are you sure you want to delete this image?',
                                        //         btnOkText: 'Delete',
                                        //         btnCancelText: 'Cancel',
                                        //         btnOkColor: Colors.red,
                                        //         btnOkIcon: Icons.delete_forever,
                                        //         btnCancelIcon: Icons.cancel,
                                        //         btnCancelOnPress: () {},
                                        //         btnOkOnPress: () async {
                                        //           await _imageController
                                        //               .deleteAboutUsImage(
                                        //                   int.parse(image.id!));
                                        //         },
                                        //       ).show();
                                        //     },
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
