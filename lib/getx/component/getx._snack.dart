import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Component extends GetxController {
  var isTapAllowed = true.obs;

  Future<void> handleTap(title, subtitle) async {
    if (isTapAllowed.value) {
      isTapAllowed.value = false;

      Get.snackbar(
        title,
        subtitle,
        colorText: Colors.black,
        padding:
            const EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
        borderColor: const Color.fromARGB(255, 48, 47, 47),
        borderWidth: 1.0,
        borderRadius: 5,
        backgroundColor: const Color.fromARGB(255, 235, 242, 246),
        icon: const Icon(Icons.add_alert),
      );
      await Future.delayed(const Duration(seconds: 5));
      isTapAllowed.value = true;
    }
  }
}
