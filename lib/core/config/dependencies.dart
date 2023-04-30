import 'package:dio/dio.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:playx/playx.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../navigation/app_navigation.dart';
import '../network/api_client.dart';
import '../network/dio/dio_client.dart';
import '../preferences/preference_manger.dart';
import 'keys.dart';

Future<void> boot() async {
  // setup and boot your dependencies here

  WidgetsFlutterBinding.ensureInitialized();

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
