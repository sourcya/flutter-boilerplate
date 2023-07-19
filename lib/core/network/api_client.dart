import 'package:flutter_boilerplate/core/navigation/app_navigation.dart';
import 'package:flutter_boilerplate/core/network/endpoints/endpoints.dart';
import 'package:flutter_boilerplate/core/network/exception/custom_exception_message.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart';
import 'package:playx/playx.dart';

abstract class ApiClient {
  ApiClient._();

  static Future<PlayxNetworkClient> createApiClient() async {
    final token = MyPreferenceManger.instance.token;
    return PlayxNetworkClient(
      dio: Dio(
        BaseOptions(
          baseUrl: Endpoints.baseUrl,
          validateStatus: (_) => true,
          followRedirects: true,
          connectTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 20),
          contentType: Headers.jsonContentType,
        ),
      ),
      customHeaders: {
        'authorization': 'Bearer $token',
      },
      exceptionMessages: const CustomExceptionMessage(),
      onUnauthorizedRequestReceived: () => _signOut(),
    );
  }

  static Future<void> _signOut() async {
    final preferenceManger = MyPreferenceManger.instance;
    await preferenceManger.signOut();
    AppNavigation.instance.navigateToSplash();
  }
}
