import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  final isLoading = false.obs;
  final error = ''.obs;

  void handleError(String message) {
    error.value = message;
    isLoading.value = false;
    Get.snackbar(
      forwardAnimationCurve: Curves.bounceIn,
      reverseAnimationCurve: Curves.easeOut,
      duration:const Duration(seconds: 5),
      backgroundColor: Colors.red,
      colorText: Colors.white,
      'Error', 'Oops! Something went wrong while fetching the data. Please try again later.');
    }

    void handleErrorForMoreDta(String message) {
    error.value = message;
    isLoading.value = false;
    Get.snackbar(
  snackPosition: SnackPosition.BOTTOM,

  forwardAnimationCurve: Curves.bounceIn,
      reverseAnimationCurve: Curves.easeOut,
  duration:const Duration(seconds: 3),
backgroundColor: Colors.white,
  colorText: Colors.black,
      'Info', 'Oops!.no more data exist');
    }

  void startLoading() {
    error.value = '';
    isLoading.value = true;
  }

  void stopLoading() {
    isLoading.value = false;
  }
}