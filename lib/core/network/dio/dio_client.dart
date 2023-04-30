import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../preferences/preference_manger.dart';
import '../endpoints/endpoints.dart';

// ignore: avoid_classes_with_only_static_members
class DioClient {
  Dio dio;
  final MyPreferenceManger preferenceManger = MyPreferenceManger.instance;

  DioClient(this.dio);

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

  /// sends a [GET] request to the given [url]
  Future<Response> get<T>(
    String path, {
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    bool attachToken = true,
    CancelToken? cancelToken,
  }) async {
    return dio.get(
      path,
      queryParameters: query,
      options: Options(
        headers: {
          // 'accept-lang': Lang.current.languageCode,

          if (attachToken && preferenceManger.token != null)
            'authorization': 'Bearer ${preferenceManger.token}',
          ...headers,
        },
      ),
      cancelToken: cancelToken,
    );
  }

  Future<Response> post<T>(
    String path, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    String? contentType,
    bool attachToken = true,
    CancelToken? cancelToken,
  }) async {
    return dio.post(
      path,
      data: body,
      queryParameters: query,
      options: Options(
        headers: {
          // 'accept-lang': Lang.current.languageCode,
          if (attachToken && preferenceManger.token != null)
            'authorization': 'Bearer ${preferenceManger.token}',
          ...headers,
        },
        contentType: contentType,
      ),
      cancelToken: cancelToken,
    );
  }

  Future<Response> delete<T>(
    String path, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    String? contentType,
    bool attachToken = true,
    CancelToken? cancelToken,
  }) async {
    return await dio.delete(
      path,
      data: body,
      queryParameters: query,
      options: Options(
        headers: {
          // 'accept-lang': Lang.current.languageCode,
          if (attachToken && preferenceManger.token != null)
            'authorization': 'Bearer ${preferenceManger.token}',
          ...headers,
        },
        contentType: contentType,
      ),
      cancelToken: cancelToken,
    );
  }

  Future<Response> put<T>(
    String path, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    String? contentType,
    bool attachToken = true,
    CancelToken? cancelToken,
  }) async {
    return dio.put(
      path,
      data: body,
      queryParameters: query,
      options: Options(
        headers: {
          // 'accept-lang': Lang.current.languageCode,
          if (attachToken && preferenceManger.token != null)
            'authorization': 'Bearer ${preferenceManger.token}',
          ...headers,
        },
        contentType: contentType,
      ),
      cancelToken: cancelToken,
    );
  }
}
