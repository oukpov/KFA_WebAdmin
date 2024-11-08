import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/page/navigate_home/Report/page/upload_promotion_image.dart';
import '../../../../controller/slider_controller.dart';
import '../../../../models/slider_model.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  final SliderController _sliderController = Get.put(SliderController());
  final PageController _pageController = PageController();
  Uint8List? _selectedFile;
  String? _selectedFileName;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _sliderController.fetchPromotionWeb();
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
        title: const Text("Promotion List",
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_photo_alternate),
            onPressed: () {
              Get.to(() => UploadPromotionPage());
            },
            tooltip: 'Add Image',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_selectedFile != null)
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                padding: const EdgeInsets.all(16),
                child: Image.memory(
                  _selectedFile!,
                  fit: BoxFit.contain,
                ),
              ),
            Obx(
              () => _sliderController.listPromotionWeb.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: CarouselSlider.builder(
                          itemCount: _sliderController.listPromotionWeb.length,
                          itemBuilder: (context, index, realIndex) {
                            return Stack(
                              children: [
                                InkWell(
                                  onTap: () async {},
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fitWidth,
                                        imageUrl: _sliderController
                                            .listPromotionWeb[index]['url'],
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
                                ),
                                Positioned(
                                  top: 10,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        AwesomeDialog(
                                          context: context,
                                          animType: AnimType.scale,
                                          dialogType: DialogType.warning,
                                          title: 'Delete Promotion',
                                          desc:
                                              'Are you sure you want to delete this promotion?',
                                          btnOkText: 'Delete',
                                          btnCancelText: 'Cancel',
                                          btnOkColor: Colors.red,
                                          btnOkIcon: Icons.delete_forever,
                                          btnCancelIcon: Icons.cancel,
                                          btnCancelOnPress: () {},
                                          btnOkOnPress: () async {
                                            await _sliderController
                                                .deletePromotionImage(
                                                    _sliderController
                                                            .listPromotionWeb[
                                                        index]['id']);
                                            await _sliderController
                                                .fetchPromotionWeb();
                                          },
                                        ).show();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          options: CarouselOptions(
                            height: 300,
                            autoPlay: false,
                            aspectRatio: 16 / 5,
                            viewportFraction: 0.65,
                            onPageChanged: (index, reason) {
                              setState(() {});
                            },
                          )),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
