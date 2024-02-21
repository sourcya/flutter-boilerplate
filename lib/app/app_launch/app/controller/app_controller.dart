import 'package:flutter_boilerplate/core/firebase/fcm/fcm_notification_manager.dart';
import 'package:playx/playx.dart';

class AppController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    FcmNotificationManager.instance.setupToken();
    FcmNotificationManager.instance.setupInteractedMessage();
    FcmNotificationManager.instance.listenToForegroundMessage();
  }

  @override
  void onClose() {
    FcmNotificationManager.instance.dispose();
    super.onClose();
  }
}
