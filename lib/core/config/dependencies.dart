import 'package:dio/dio.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:playx/playx.dart';

import '../navigation/app_navigation.dart';
import '../network/api_client.dart';
import '../network/dio_client.dart';
import '../preferences/preference_manger.dart';

Future<void> boot() async {
  // setup and boot your dependencies here

  WidgetsFlutterBinding.ensureInitialized();

  //USED FOR DEBUGGING
  Fimber.plantTree(DebugTree());

  final preferenceManger = MyPreferenceManger();
  Get.put<MyPreferenceManger>(preferenceManger);

  final Dio dio = DioClient.createDioClient();
  final ApiClient client = ApiClient(dio, preferenceManger);
  Get.put<ApiClient>(client);

  Get.put<AppNavigation>(AppNavigation());
}
