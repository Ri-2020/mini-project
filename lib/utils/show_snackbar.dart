import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar(message) {
  Get.rawSnackbar(
      message: message,
      margin: const EdgeInsets.all(8),
      borderRadius: 8,
      maxWidth: 400,
      backgroundColor: Colors.black.withOpacity(0.8),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2));
  return;
}
