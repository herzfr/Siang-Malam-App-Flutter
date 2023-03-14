import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

/* Created By Dwi Sutrisno */

class Snackbar {
  Snackbar.show(String title, String message, Color bgColor, Color txtColor) {
    Get.snackbar(
      title,
      message,
      backgroundColor: bgColor,
      colorText: txtColor,
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 2),
    );
  }

  Snackbar.showWithTime(String title, String message, Color bgColor,
      Color txtColor, int duration) {
    Get.snackbar(
      title,
      message,
      backgroundColor: bgColor,
      colorText: txtColor,
      animationDuration: const Duration(milliseconds: 500),
      duration: Duration(seconds: duration),
    );
  }

  Snackbar.showAndBack(
      String title, String message, Color bgColor, Color txtColor) {
    show(title, message, bgColor, txtColor);
    Future.delayed(const Duration(milliseconds: 3000), () {
      Get.back();
    });
  }

  Snackbar.showAndBackWithResult(
      String title, String message, Color bgColor, Color txtColor) {
    show(title, message, bgColor, txtColor);
    Future.delayed(const Duration(milliseconds: 3000), () {
      Get.back(result: true);
    });
  }

  show(String title, String message, Color bgColor, Color txtColor) {
    Get.snackbar(
      title,
      message,
      backgroundColor: bgColor,
      colorText: txtColor,
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 2),
    );
  }
}
