import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../config/endpoints.dart';

// ignore: avoid_classes_with_only_static_members
class DioClient {
  static Dio createDioClient() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
        validateStatus: (_) => true,
        followRedirects: true,
        connectTimeout: const Duration(seconds: 8),
        sendTimeout: const Duration(seconds: 5),
        contentType: Headers.jsonContentType,
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    }

    return dio;
  }
}
