import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:playx/playx.dart' hide Response;

import '../preferences/preference_manger.dart';
import 'models/network_exception.dart';
import 'models/network_result.dart';

/// wrapper around dio to handlers api calls
class ApiClient {
  final Dio dio;
  final MyPreferenceManger preferenceManger;
  ApiClient(this.dio, this.preferenceManger);

  NetworkResult<T> handleNetworkResult<T>(
    Response response,
    Function(Map<String, dynamic> json) fromJson,
  ) {
    final correctCodes = [
      200,
      201,
    ];

    if (response.statusCode == HttpStatus.badRequest ||
        !correctCodes.contains(response.statusCode)) {
      final NetworkExceptions exception =
          NetworkExceptions.handleResponse(response);
      return NetworkResult.error(exception);
    } else {
      if (response.isBlank ?? true) {
        return const NetworkResult.error(NetworkExceptions.emptyResponse());
      } else {
        final json = response.data as Map<String, dynamic>?;
        final data = json != null ? fromJson(json) : null;
        if (data == null) {
          return const NetworkResult.error(NetworkExceptions.emptyResponse());
        } else {
          if (data is T) {
            return NetworkResult.success(data);
          } else {
            return const NetworkResult.error(NetworkExceptions.emptyResponse());
          }
        }
      }
    }
  }

  /// sends a [GET] request to the given [url]
  Future<NetworkResult<T>> get<T>(
    String path, {
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    bool attachToken = true,
    required Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      final res = await dio.get(
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
      );
      return handleNetworkResult(res, fromJson);
    } catch (e) {
      if (kDebugMode) printError(info: e.toString());

      return const NetworkResult.error(
        NetworkExceptions.unexpectedError(),
      );
    }
  }

  Future<NetworkResult<T>> post<T>(
    String path, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    String? contentType,
    bool attachToken = true,
    required Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      final res = await dio.post(
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
      );
      return handleNetworkResult(res, fromJson);
    } catch (e) {
      if (kDebugMode) printError(info: e.toString());
      return const NetworkResult.error(
        NetworkExceptions.unexpectedError(),
      );
    }
  }

  Future<NetworkResult<T>> delete<T>(
    String path, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    String? contentType,
    bool attachToken = true,
    required Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      final res = await dio.delete(
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
      );
      return handleNetworkResult(res, fromJson);
    } catch (e) {
      if (kDebugMode) printError(info: e.toString());

      return const NetworkResult.error(
        NetworkExceptions.unexpectedError(),
      );
    }
  }

  Future<NetworkResult<T>> put<T>(
    String path, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    String? contentType,
    bool attachToken = true,
    required Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      final res = await dio.put(
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
      );
      return handleNetworkResult(res, fromJson);
    } catch (e) {
      if (kDebugMode) printError(info: e.toString());
      return const NetworkResult.error(
        NetworkExceptions.unexpectedError(),
      );
    }
  }
}
