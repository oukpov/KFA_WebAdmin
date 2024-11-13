// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/page/navigate_home/Report/page/upload_socialmedia_image.dart';
import '../../../../controller/social_media_controller.dart';

class SocialMediaEditionPage extends StatefulWidget {
  const SocialMediaEditionPage({super.key});
  @override
  State<SocialMediaEditionPage> createState() => _SocialMediaEditionPageState();
}

class _SocialMediaEditionPageState extends State<SocialMediaEditionPage> {
  final SocialMediaController _socialMediaController =
      Get.put(SocialMediaController());
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _socialMediaController.getSocialMedia();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Media List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_photo_alternate),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UploadSocialMediaPage(),
                ),
              );
            },
            tooltip: 'Add Image',
          ),
        ],
      ),
      body: Obx(() => _socialMediaController.socialMediaData.value.data == null
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                childAspectRatio: 0.65,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: const EdgeInsets.all(10),
              itemCount:
                  _socialMediaController.socialMediaData.value.data!.length,
              itemBuilder: (context, index) {
                final socialMedia =
                    _socialMediaController.socialMediaData.value.data![index];
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
                            imageUrl: socialMedia.url ?? '',
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
                            InkWell(
                              onTap: () {
                                final TextEditingController platformController =
                                    TextEditingController(
                                        text: socialMedia.platform);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            Text('Edit Social Media Platform'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextField(
                                              controller: platformController,
                                              decoration: InputDecoration(
                                                  labelText: 'Platform URL',
                                                  hintText:
                                                      'Enter platform URL'),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              try {
                                                await _socialMediaController
                                                    .updateSocialMedia(
                                                  id: socialMedia.id.toString(),
                                                  platform:
                                                      platformController.text,
                                                  url: socialMedia.url ?? '',
                                                );
                                                print('id: ${socialMedia.id}');
                                                print(
                                                    'platform: ${platformController.text}');
                                                print(
                                                    'url: ${socialMedia.url}');
                                                Navigator.pop(context);
                                                Get.snackbar(
                                                  'Success',
                                                  'Platform URL updated successfully',
                                                  snackPosition:
                                                      SnackPosition.TOP,
                                                );
                                              } catch (e) {
                                                Get.snackbar(
                                                  'Error',
                                                  'Failed to update platform URL',
                                                  snackPosition:
                                                      SnackPosition.TOP,
                                                );
                                              }
                                            },
                                            child: Text('Save'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Text('Edit Link',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 24,
                              ),
                              onPressed: () {
                                _socialMediaController.deleteSocialMedia(
                                  id: socialMedia.id.toString(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )),
    );
  }
}
