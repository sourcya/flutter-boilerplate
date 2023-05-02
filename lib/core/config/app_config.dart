import 'package:dio/dio.dart';
import 'package:fimber/fimber.dart';
import 'package:playx/config/playx_app_config.dart';
import 'package:playx/playx.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../navigation/app_navigation.dart';
import '../network/api_client.dart';
import '../network/dio/dio_client.dart';
import '../preferences/preference_manger.dart';
import 'keys.dart';

/// This class contains app configuration like playx configuration.
class AppConfig extends PlayXAppConfig {
  @override
  String get appTitle => "Sourcya App";

  // setup and boot your dependencies here
  @override
  Future<void> boot() async {
    //USED FOR DEBUGGING
    Fimber.plantTree(DebugTree());
    await SentryFlutter.init((options) {
      options.dsn = Keys.sentryKey;
    });

    Get.put<MyPreferenceManger>(MyPreferenceManger());
    final dio = DioClient.createDioClient();
    final ApiClient client = ApiClient(dio);
    Get.put<Dio>(dio);
    Get.put<ApiClient>(client);
    Get.put<AppNavigation>(AppNavigation());
  }
}
