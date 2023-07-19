import 'package:playx/playx.dart';

import '../navigation/app_navigation.dart';
import '../network/api_client.dart';
import '../preferences/preference_manger.dart';

/// This class contains app configuration like playx configuration.
class AppConfig extends PlayXAppConfig {
  @override
  String get appTitle => "Sourcya App";

  // setup and boot your dependencies here
  @override
  Future<void> boot() async {
    //USED FOR DEBUGGING
    Fimber.plantTree(DebugTree());
    Get.put<MyPreferenceManger>(MyPreferenceManger());
    final PlayxNetworkClient client = await ApiClient.createApiClient();
    Get.put<PlayxNetworkClient>(client);
    Get.put<AppNavigation>(AppNavigation());
  }
}
