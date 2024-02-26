import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:playx/playx.dart';

import 'fcm/fcm_notification_manager.dart';

class PushNotificationManager extends FcmNotificationManager {
  PushNotificationManager._internal();
  static final PushNotificationManager _instance =
      PushNotificationManager._internal();

  static PushNotificationManager get instance => _instance;

  @override
  Future<void> handleOpeningMessage(RemoteMessage message) async {
    Fimber.d('PushNotificationManager : handleOpeningMessage :${message.data}');
  }

  @override
  Future<void> handleSavingToken(String token) async {
    Fimber.d('PushNotificationManager : handleSavingToken $token');
  }
}
