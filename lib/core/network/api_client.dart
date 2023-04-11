import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_boilerplate/core/network/api_handler.dart';
import 'package:playx/playx.dart' hide Response;

import 'dio_client.dart';
import 'models/network_result.dart';

typedef JsonMapper<T> = T Function(Map<String, dynamic> json);

/// wrapper around dio to handlers api calls
class ApiClient {
  late DioClient dioClient;

  ApiClient(Dio dio) {
    dioClient = DioClient(dio);
  }

  /// sends a [GET] request to the given [url]
  /// and returns object of Type [T] not list
  Future<NetworkResult<T>> get<T>(
    String path, {
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    bool attachToken = true,
    CancelToken? cancelToken,
    required JsonMapper<T> fromJson,
  }) async {
    try {
      final res = await dioClient.get(
        path,
        headers: headers,
        query: query,
        attachToken: attachToken,
        cancelToken: cancelToken,
      );
      return ApiHandler.handleNetworkResult(res, fromJson);
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      if (kDebugMode) printError(info: error.toString());
      return ApiHandler.handleDioException(error);
    }
  }

  /// sends a [GET] request to the given [url]
  /// and returns List<object> of Type [T] not object
  Future<NetworkResult<List<T>>> getList<T>(
    String path, {
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    bool attachToken = true,
    CancelToken? cancelToken,
    required JsonMapper<T> fromJson,
  }) async {
    try {
      final res = await dioClient.get(
        path,
        headers: headers,
        query: query,
        attachToken: attachToken,
        cancelToken: cancelToken,
      );
      return ApiHandler.handleNetworkResultForList(res, fromJson);
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      if (kDebugMode) printError(info: error.toString());
      return ApiHandler.handleDioException(error);
    }
  }

  /// sends a [POST] request to the given [url]
  /// and returns object of Type [T] not list
  Future<NetworkResult<T>> post<T>(
    String path, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    String? contentType,
    bool attachToken = true,
    CancelToken? cancelToken,
    required JsonMapper<T> fromJson,
  }) async {
    try {
      final res = await dioClient.post(
        path,
        body: body,
        headers: headers,
        query: query,
        contentType: contentType,
        attachToken: attachToken,
        cancelToken: cancelToken,
      );
      return ApiHandler.handleNetworkResult(res, fromJson);
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      if (kDebugMode) printError(info: error.toString());
      return ApiHandler.handleDioException(error);
    }
  }

  /// sends a [POST] request to the given [url]
  /// and returns List<object> of Type [T] not object
  Future<NetworkResult<List<T>>> postList<T>(
    String path, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    String? contentType,
    bool attachToken = true,
    CancelToken? cancelToken,
    required JsonMapper<T> fromJson,
  }) async {
    try {
      final res = await dioClient.post(
        path,
        body: body,
        headers: headers,
        query: query,
        contentType: contentType,
        attachToken: attachToken,
        cancelToken: cancelToken,
      );
      return ApiHandler.handleNetworkResultForList(res, fromJson);
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      if (kDebugMode) printError(info: error.toString());
      return ApiHandler.handleDioException(error);
    }
  }

  /// sends a [DELETE] request to the given [url]
  /// and returns object of Type [T] not list
  Future<NetworkResult<T>> delete<T>(
    String path, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    String? contentType,
    bool attachToken = true,
    CancelToken? cancelToken,
    required JsonMapper<T> fromJson,
  }) async {
    try {
      final res = await dioClient.delete(
        path,
        body: body,
        headers: headers,
        query: query,
        contentType: contentType,
        attachToken: attachToken,
        cancelToken: cancelToken,
      );
      return ApiHandler.handleNetworkResult(res, fromJson);
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      if (kDebugMode) printError(info: error.toString());
      return ApiHandler.handleDioException(error);
    }
  }

  /// sends a [DELETE] request to the given [url]
  /// and returns List<object> of Type [T] not object
  Future<NetworkResult<List<T>>> deleteList<T>(
    String path, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    String? contentType,
    bool attachToken = true,
    CancelToken? cancelToken,
    required JsonMapper<T> fromJson,
  }) async {
    try {
      final res = await dioClient.delete(
        path,
        body: body,
        headers: headers,
        query: query,
        contentType: contentType,
        attachToken: attachToken,
        cancelToken: cancelToken,
      );
      return ApiHandler.handleNetworkResultForList(res, fromJson);
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      if (kDebugMode) printError(info: error.toString());
      return ApiHandler.handleDioException(error);
    }
  }

  /// sends a [PUT] request to the given [url]
  /// and returns object of Type [T] not list
  Future<NetworkResult<T>> put<T>(
    String path, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    String? contentType,
    bool attachToken = true,
    CancelToken? cancelToken,
    required JsonMapper<T> fromJson,
  }) async {
    try {
      final res = await dioClient.put(
        path,
        body: body,
        headers: headers,
        query: query,
        contentType: contentType,
        attachToken: attachToken,
        cancelToken: cancelToken,
      );
      return ApiHandler.handleNetworkResult(res, fromJson);
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      if (kDebugMode) printError(info: error.toString());
      return ApiHandler.handleDioException(error);
    }
  }

  /// sends a [PUT] request to the given [url]
  /// and returns List<object> of Type [T] not object
  Future<NetworkResult<List<T>>> putList<T>(
    String path, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    String? contentType,
    bool attachToken = true,
    CancelToken? cancelToken,
    required JsonMapper<T> fromJson,
  }) async {
    try {
      final res = await dioClient.put(
        path,
        body: body,
        headers: headers,
        query: query,
        contentType: contentType,
        attachToken: attachToken,
        cancelToken: cancelToken,
      );
      return ApiHandler.handleNetworkResultForList(res, fromJson);
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      if (kDebugMode) printError(info: error.toString());
      return ApiHandler.handleDioException(error);
    }
  }
}
