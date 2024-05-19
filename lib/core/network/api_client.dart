import 'package:playx/playx.dart';

import '../navigation/app_navigation.dart';
import '../preferences/preference_manger.dart';
import 'endpoints/endpoints.dart';
import 'exception/custom_exception_message.dart';

abstract class ApiClient {
  ApiClient._();

  static String? get token => MyPreferenceManger.instance.token;

  static Future<PlayxNetworkClient> createApiClient() async {
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
      customHeaders: token == null
          ? null
          : () async => {
                'authorization': 'Bearer $token',
              },
      exceptionMessages: const CustomExceptionMessage(),
      onUnauthorizedRequestReceived: (res) => _signOut(),
    );
  }

  static Future<void> _signOut() async {
    final preferenceManger = MyPreferenceManger.instance;
    await preferenceManger.signOut();
    AppNavigation.navigateToSplash();
  }
}
