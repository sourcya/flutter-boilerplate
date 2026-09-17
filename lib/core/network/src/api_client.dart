part of '../network.dart';

abstract class ApiClient {
  ApiClient._();
  static Future<String?> get apiToken => MyPreferenceManger.instance.token;

  static PlayxNetworkClient get client => getIt.get<PlayxNetworkClient>();

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
        exceptionMessages: CustomExceptionMessage(),
      ),
      onUnauthorizedRequestReceived: (res) => SessionManager.instance.handleUnauthorizedResponse(),
    );
  }

  static Future<void> init() async {
    final PlayxNetworkClient client = await ApiClient.createApiClient();
    getIt.registerSingleton<PlayxNetworkClient>(client);
  }
}
