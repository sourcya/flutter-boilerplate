import 'package:playx/playx.dart';
import 'package:sentry_dio/sentry_dio.dart';

import '../navigation/app_navigation.dart';
import '../preferences/preference_manger.dart';
import 'endpoints/endpoints.dart';
import 'exception/custom_exception_message.dart';

abstract class ApiClient {
  ApiClient._();
  static Future<String?> get apiToken async =>
      MyPreferenceManger.instance.token;

  static PlayxNetworkClient get client => Get.find<PlayxNetworkClient>();

  static Future<PlayxNetworkClient> createApiClient() async {
    final dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
        validateStatus: (_) => true,
        followRedirects: true,
        connectTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        contentType: Headers.jsonContentType,
      ),
    );

    dio.addSentry();

    return PlayxNetworkClient(
      dio: dio,
      customHeaders: () async {
        final token = await apiToken;
        if (token == null) {
          return {};
        }

        return {
          'authorization': 'Bearer $token',
        };
      },
      logSettings: const LoggerSettings(
        responseBody: true,
        responseHeader: true,
      ),
      exceptionMessages: const CustomExceptionMessage(),
      // onUnauthorizedRequestReceived: (res) => _signOut(),
    );
  }

  static Future<void> _signOut() async {
    final preferenceManger = MyPreferenceManger.instance;
    await preferenceManger.signOut();
    AppNavigation.navigateToSplash();
  }
}
