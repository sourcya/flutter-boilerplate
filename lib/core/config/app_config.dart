import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:playx/playx.dart';

import '../navigation/app_navigation.dart';
import '../network/api_client.dart';
import '../notifications/fcm/firebase_options.dart';
import '../notifications/push_notification_manager.dart';
import '../preferences/env_manger.dart';
import '../preferences/preference_manger.dart';

/// This class contains app configuration like playx configuration.
class AppConfig extends PlayXAppConfig {
  // setup and boot your dependencies here
  @override
  Future<void> boot() async {
    //USED FOR DEBUGGING
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await PushNotificationManager.instance.init();

    Fimber.plantTree(DebugTree());
    Get.put<MyPreferenceManger>(MyPreferenceManger());
    Get.put<EnvManger>(EnvManger());
    final PlayxNetworkClient client = await ApiClient.createApiClient();
    Get.put<PlayxNetworkClient>(client);
    Get.put<AppNavigation>(AppNavigation());
  }

  @override
  Future<void> asyncBoot() async {
    PushNotificationManager.instance.setupToken();
    PushNotificationManager.instance.setupInteractedMessage();
    PushNotificationManager.instance.listenToForegroundMessage();
  }

  @override
  Future<void> dispose() async {
    PushNotificationManager.instance.dispose();
    super.dispose();
  }
}
