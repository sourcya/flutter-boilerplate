import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/colors.dart';

///This class provides custom alerts for the app
///like green snackbar like for successful alerts
///and red ones for errors.
abstract class Alert {
  Alert._();

  static void success({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    showSnackBar(
      message: message,
      color: Colors.teal,
      duration: duration,
    );
  }

  static void message({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    showSnackBar(
      message: message,
      color: Colors.black54,
      duration: duration,
    );
  }

  static void error({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    showSnackBar(
      message: message,
      color: AppColors.red,
      duration: duration,
    );
  }

  static void debugError({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    showSnackBar(
      message: kDebugMode ? 'error happened' : message,
      color: Colors.teal,
      duration: duration,
    );
  }

  static void showBanner(
      {required String message,
      required Color color,
      String? buttonText,
      List<Widget> actions = const []}) {
    final context = Get.context;
    if (context != null) {
      final banner = MaterialBanner(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: color,
        actions: actions,
      );

      ScaffoldMessenger.of(context).removeCurrentMaterialBanner();

      ScaffoldMessenger.of(context).showMaterialBanner(banner);
    }
  }

  static void hideBanner() {
    final context = Get.context;
    if (context != null) {
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    }
  }

  static void showSnackBar(
      {required String message,
      required Color color,
      Duration duration = const Duration(seconds: 3)}) {
    if (Platform.isAndroid) {
      final context = Get.context;

      if (context != null) {
        final snackBar = SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          duration: duration,
        );
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      } else {
        Get.closeAllSnackbars();
        Get.snackbar(message, '');
      }
    } else {
      Get.closeAllSnackbars();
      Get.snackbar(message, '');
    }
  }
}
