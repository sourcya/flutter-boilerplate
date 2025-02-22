import 'package:flutter_boilerplate/core/navigation/app_navigation.dart';
import 'package:flutter_boilerplate/core/network/endpoints/endpoints.dart';
import 'package:flutter_boilerplate/core/network/exception/custom_exception_message.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart';
import 'package:playx/playx.dart';

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
      settings: const PlayxNetworkClientSettings(
        logSettings: PlayxNetworkLoggerSettings(
          responseBody: true,
          responseHeader: true,
        ),
        exceptionMessages: CustomExceptionMessage(),
      ),
      // onUnauthorizedRequestReceived: (res) => _signOut(),
    );
  }

  static Future<void> _signOut() async {
    final preferenceManger = MyPreferenceManger.instance;
    await preferenceManger.signOut();
    AppNavigation.navigateToSplash();
  }
}
