import 'package:flutter_boilerplate/core/preferences/env_manger.dart';
import 'package:playx/playx.dart';

import '../navigation/app_navigation.dart';
import '../network/api_client.dart';
import '../preferences/preference_manger.dart';

/// This class contains app configuration like playx configuration.
class AppConfig extends PlayXAppConfig {
  // setup and boot your dependencies here
  @override
  Future<void> boot() async {
    //USED FOR DEBUGGING
    Fimber.plantTree(DebugTree());
    Get.put<MyPreferenceManger>(MyPreferenceManger());
    Get.put<EnvManger>(EnvManger());
    final PlayxNetworkClient client = await ApiClient.createApiClient();
    Get.put<PlayxNetworkClient>(client);
    Get.put<AppNavigation>(AppNavigation());
  }

  @override
  Future<void> asyncBoot() async {
   return Future.delayed(10.seconds);
  }
}
