import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class BannerUpdateExample extends StatefulWidget {
  final String bannerId;
  const BannerUpdateExample({Key? key, required this.bannerId})
      : super(key: key);

  @override
  _BannerUpdateExampleState createState() => _BannerUpdateExampleState();
}

class _BannerUpdateExampleState extends State<BannerUpdateExample> {
  bool isLoading = false;
  String? currentImagePath;

  Future<void> updateBanner() async {
    try {
      setState(() {
        isLoading = true;
      });

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // Optimize image quality
      );

      if (image != null) {
        setState(() {
          currentImagePath = image.path;
        });

        var formData = FormData.fromMap({
          'bannerimage': await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          ),
          'url': '', // Remove if not needed
        });

        final dio = Dio();
        final response = await dio.post(
          'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/banners/${widget.bannerId}/update-image',
          data: formData,
          options: Options(
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'multipart/form-data',
            },
            validateStatus: (status) => true, // Handle all status codes
          ),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Banner updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          // Call your fetch function to refresh the data
          // fetchBanners();
        } else {
          throw Exception(response.statusMessage ?? 'Failed to update banner');
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating banner: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Show current image if available
        if (currentImagePath != null)
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.file(
              File(currentImagePath!),
              fit: BoxFit.cover,
            ),
          ),

        const SizedBox(height: 16),

        // Update button
        ElevatedButton(
          onPressed: isLoading ? null : updateBanner,
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Update Banner Image'),
        ),
      ],
    );
  }
}

// Usage example:
class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Banner')),
      body: BannerUpdateExample(bannerId: '31'),
    );
  }
}
