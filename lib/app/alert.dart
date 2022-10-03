import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

abstract class Alert {
  Alert._();
  static void success(String message) {
    Get.snackbar(message, '');
  }

  static void error(String message) {
    Get.snackbar(message, '');
  }

  static void debugError(String message) {
    Get.snackbar(kDebugMode ? 'error happened' : message, '');
  }
}
