import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate/core/firebase/fcm/fcm_notification_manager.dart';
import 'package:flutter_boilerplate/core/firebase/firebase_options.dart';
import 'package:flutter_boilerplate/core/preferences/env_manger.dart';
import 'package:playx/playx.dart';

import '../../app/app_launch/app/controller/app_controller.dart';
import '../navigation/app_navigation.dart';
import '../network/api_client.dart';
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

    await FcmNotificationManager.instance.init();

    Fimber.plantTree(DebugTree());
    Get.put<MyPreferenceManger>(MyPreferenceManger());
    Get.put<EnvManger>(EnvManger());
    final PlayxNetworkClient client = await ApiClient.createApiClient();
    Get.put<PlayxNetworkClient>(client);
    Get.put<AppNavigation>(AppNavigation());
    Get.put(AppController(), permanent: true);
  }

  @override
  Future<void> asyncBoot() async {}
}
