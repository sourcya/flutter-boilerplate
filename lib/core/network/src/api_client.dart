part of '../network.dart';

abstract class ApiClient {
  ApiClient._();
  static Future<String?> get apiToken async =>
      MyPreferenceManger.instance.token;

  static PlayxNetworkClient get client => Get.find<PlayxNetworkClient>();


  static Auth0 get auth0 => Get.find<Auth0>();

  static Auth0Web get auth0Web => Get.find<Auth0Web>();


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

  static Future<void> init() async {
    final PlayxNetworkClient client = await ApiClient.createApiClient();
    Get.put<PlayxNetworkClient>(client);

    final Auth0 auth0 = Auth0(
      Constants.auth0Domain,
      Constants.auth0ClientId,
    );

    final Auth0Web auth0Web = Auth0Web(
      Constants.auth0Domain,
      Constants.auth0WebClientId,
    );

    Get.put<Auth0>(auth0);
    Get.put<Auth0Web>(auth0Web);  }

  static Future<void> _signOut() async {
    final preferenceManger = MyPreferenceManger.instance;
    await preferenceManger.signOut();
    AppNavigation.navigateToSplash();
  }
}
