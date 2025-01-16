import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../getx/UI/download.dart';

class CatchNetworkObx extends StatelessWidget {
  const CatchNetworkObx({
    super.key,
    required this.noImage,
    required this.item,
  });
  final String noImage;
  final List item;
  @override
  Widget build(BuildContext context) {
    final downloadImage = Get.put(DownloadImage());

    return Obx(() {
      if (item.isEmpty) {
        return Image.network(
          "https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/icons_application/downloadImage.png",
        );
      } else {
        return Image.network(
          downloadImage.urlImage(
            item,
            noImage,
          ),
        );
      }
    });
  }
}
