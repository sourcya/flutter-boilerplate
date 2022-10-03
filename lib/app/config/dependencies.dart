import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_boilerplate/app/config/endpoints.dart';
import 'package:flutter_boilerplate/app/helpers/http_client.dart';
import 'package:flutter_boilerplate/app/services/auth.dart';
import 'package:playx/playx.dart';

Future<void> boot() async {
  // setup and boot your dependencies here

  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  final HttpClient client = HttpClient(
    Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
        validateStatus: (_) => true,
        followRedirects: true,
      ),
    ),
  );
  Get.put<HttpClient>(client);
  Get.put<AuthService>(AuthService(client));
}
