import 'dart:convert';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universal_html/html.dart' as html;
import 'package:web_admin/page/navigate_home/Report/page/upload_image_page.dart';

import '../../../../controller/banner_controller.dart';
import '../../../../models/banner_model.dart';

class SponsorListPage extends StatefulWidget {
  const SponsorListPage({super.key});
  @override
  State<SponsorListPage> createState() => _SponsorListPageState();
}

class _SponsorListPageState extends State<SponsorListPage> {
  List<BannerModel> banners = [];
  bool isLoading = true;
  Uint8List? _byesData;
  Uint8List? _selectedFile;
  String imageUrl = '';
  bool cropORopen = true;
  String base64string = '';
  BannerController bannerController = BannerController();

  @override
  void initState() {
    super.initState();
    fetchBanners();
  }

  Future<void> fetchBanners() async {
    try {
      setState(() {
        isLoading = true;
      });
      await bannerController.fetchBanners();
      setState(() {
        banners = bannerController.banners;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching banners: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updateBanner(String id) async {
    try {
      await bannerController.updateBanner(id);
      fetchBanners();
    } catch (e) {
      print('Error updating banner: $e');
    }
  }

  Future<void> deleteBanner(String id) async {
    try {
      await bannerController.deleteBanner(id);
      fetchBanners();
    } catch (e) {
      print('Error deleting banner: $e');
    }
  }

  void _navigateToInsertPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UploadImagePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sponsor List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_photo_alternate),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UploadImagePage(),
                ),
              );
            },
            tooltip: 'Add Image',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                childAspectRatio: 0.65,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: const EdgeInsets.all(10),
              itemCount: banners.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: double.infinity,
                            imageUrl: banners[index].url ?? '',
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                                size: 24,
                              ),
                              onPressed: () {
                                updateBanner(banners[index].id.toString());
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 24,
                              ),
                              onPressed: () {
                                deleteBanner(banners[index].id.toString());
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class InsertBannerPage extends StatefulWidget {
  final Function onBannerInserted;

  const InsertBannerPage({Key? key, required this.onBannerInserted})
      : super(key: key);

  @override
  _InsertBannerPageState createState() => _InsertBannerPageState();
}

class _InsertBannerPageState extends State<InsertBannerPage> {
  final BannerController _bannerController = BannerController();
  final TextEditingController _urlController = TextEditingController();

  Future<void> _pickImage() async {
    _bannerController.openImgae();
    setState(() {
      //  _byesData = _bannerController.byesData;
    });
  }

  Future<void> _insertBanner() async {
    if (_bannerController.byesData != null && _urlController.text.isNotEmpty) {
      try {
        await _bannerController.insertBanner(BannerModel(
          bannerimage: base64Encode(_bannerController.byesData!),
        ));
        widget.onBannerInserted();
        Navigator.of(context).pop();
      } catch (e) {
        print('Error inserting banner: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to insert banner: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image and enter a URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Exciting New Banner'),
        backgroundColor: Colors.blue[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.add_photo_alternate),
                label: const Text('Choose Your Banner Image'),
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _insertBanner,
                child: const Text('Add Your Amazing Banner!'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
