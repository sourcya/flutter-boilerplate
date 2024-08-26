import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../navigation/navigation_utils.dart';
import '../widgets/components/custom_text.dart';

///This class provides custom alerts for the app
///like green snackbar like for successful alerts
///and red ones for errors.
abstract class Alert {
  Alert._();

  static void success({
    required String message,
    Duration duration = const Duration(seconds: 3),
    bool isMessageTranslatable = true,
  }) {
    showSnackBar(
      message: message,
      color: Colors.teal,
      duration: duration,
      isMessageTranslatable: isMessageTranslatable,
    );
  }

  static void message({
    required String message,
    Duration duration = const Duration(seconds: 3),
    bool isMessageTranslatable = true,
  }) {
    showSnackBar(
      message: message,
      color: Colors.black54,
      duration: duration,
      isMessageTranslatable: isMessageTranslatable,
    );
  }

  static void error({
    required String message,
    Duration duration = const Duration(seconds: 3),
    bool isMessageTranslatable = true,
  }) {
    showSnackBar(
      message: message,
      color: PlayxColors.red,
      duration: duration,
      isMessageTranslatable: isMessageTranslatable,
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

  static void showBanner({
    required String message,
    required Color color,
    String? buttonText,
    TextAlign textAlign = TextAlign.start,
    List<Widget> actions = const [SizedBox.shrink()],
  }) {
    final context = NavigationUtils.navigationContext;
    if (context != null) {
      final banner = MaterialBanner(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
          textAlign: textAlign,
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

  static void showSnackBar({
    required String message,
    required Color color,
    Duration duration = const Duration(seconds: 3),
    bool isMessageTranslatable = true,
  }) {
    final context = NavigationUtils.navigationContext;
    if (context != null) {
      final snackBar = SnackBar(
        content: CustomText(
          message,
          color: Colors.white,
          isTranslatable: isMessageTranslatable,
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: duration,
      );
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }
}
