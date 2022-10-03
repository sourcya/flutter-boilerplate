import 'dart:io';

import 'package:dio/dio.dart';
import 'package:playx/playx.dart' hide Response;

Object? extractError(dynamic data) {
  if (data is Map) {
    return data['error'];
  }
  return null;
}

void throwIfNot(int httpStatus, Response response) {
  if (response.statusCode != httpStatus) {
    throw extractError(response.data) ?? response.data as Object;
  }
}

/// wrapper around dio to handlers api calls
class HttpClient {
  final Dio dio;

  HttpClient(this.dio);

  Response _validate(Response res) {
    // final badCodes = [
    //   400,
    //   404,
    //   401,
    //   404,
    //   422,
    //   500,
    // ];
    final correctCodes = [
      200,
      201,
    ];

    if (res.statusCode == HttpStatus.badRequest) {
      if ((res.data as Map)['message'] is String) {
        throw (res.data as Map<String, dynamic>)['message'] as String;
      }

      throw ((((res.data as Map)['message'] as List).first['messages'] as List)
          .first as Map<String, dynamic>)['message'] as String;
    } else if (!correctCodes.contains(res.statusCode)) {
      throw 'server error ${res.statusCode}';
    }
    return res;
  }

  /// sends a [GET] request to the given [url]
  Future<Response> get(
    String path, {
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    bool attachToken = true,
  }) async {
    final res = await dio.get(
      path,
      queryParameters: query,
      options: Options(
        headers: {
          // 'accept-lang': Lang.current.languageCode,
          if (attachToken)
            'authorization': 'Bearer ${Prefs.getString('token')}',
          ...headers,
        },
      ),
    );
    return _validate(res);
  }

  Future<Response> post(
    String path, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    String? contentType,
    bool attachToken = true,
  }) async {
    final res = await dio.post(
      path,
      data: body,
      queryParameters: query,
      options: Options(
        headers: {
          // 'accept-lang': Lang.current.languageCode,
          if (attachToken)
            'authorization': 'Bearer ${Prefs.getString('token')}',
          ...headers,
        },
        contentType: contentType,
      ),
    );
    return _validate(res);
  }

  Future<Response> delete(
    String path, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    String? contentType,
    bool attachToken = true,
  }) async {
    final res = await dio.delete(
      path,
      data: body,
      queryParameters: query,
      options: Options(
        headers: {
          // 'accept-lang': Lang.current.languageCode,
          if (attachToken)
            'authorization': 'Bearer ${Prefs.getString('token')}',
          ...headers,
        },
        contentType: contentType,
      ),
    );
    return _validate(res);
  }

  Future<Response> put(
    String path, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    String? contentType,
    bool attachToken = true,
  }) async {
    final res = await dio.put(
      path,
      data: body,
      queryParameters: query,
      options: Options(
        headers: {
          // 'accept-lang': Lang.current.languageCode,
          if (attachToken)
            'authorization': 'Bearer ${Prefs.getString('token')}',
          ...headers,
        },
        contentType: contentType,
      ),
    );
    return _validate(res);
  }
}
