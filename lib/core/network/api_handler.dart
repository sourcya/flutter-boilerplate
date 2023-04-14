import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/core/network/models/network_exception.dart';
import 'package:get/get_utils/get_utils.dart';

import '../navigation/app_navigation.dart';
import '../preferences/preference_manger.dart';
import 'api_client.dart';
import 'models/api_error.dart';
import 'models/message.dart';
import 'models/network_result.dart';

// ignore: avoid_classes_with_only_static_members
abstract class ApiHandler {
  static Future<NetworkResult<T>> handleNetworkResult<T>(
    Response response,
    JsonMapper<T> fromJson,
  ) async {
    try {
      final correctCodes = [
        200,
        201,
      ];

      if (response.statusCode == HttpStatus.badRequest ||
          !correctCodes.contains(response.statusCode)) {
        final NetworkException exception = _handleResponse(response);

        if (exception is UnauthorizedRequestException) {
          await _signOut();
        }
        return NetworkResult.error(exception);
      } else {
        if (response.isBlank ?? true) {
          return NetworkResult.error(EmptyResponseException());
        } else {
          final data = response.data;

          if (data == null) {
            return NetworkResult.error(EmptyResponseException());
          }

          try {
            final json = data as Map<String, dynamic>;
            final result = fromJson(json);
            return NetworkResult.success(result);
            // ignore: avoid_catches_without_on_clauses
          } catch (e) {
            return NetworkResult.error(
              UnableToProcessException(),
            );
          }
        }
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return NetworkResult.error(UnexpectedErrorException());
    }
  }

  static Future<NetworkResult<List<T>>> handleNetworkResultForList<T>(
    Response response,
    JsonMapper<T> fromJson,
  ) async {
    try {
      final correctCodes = [
        200,
        201,
      ];

      if (response.statusCode == HttpStatus.badRequest ||
          !correctCodes.contains(response.statusCode)) {
        final NetworkException exception = _handleResponse(response);
        if (exception is UnauthorizedRequestException) {
          await _signOut();
        }
        return NetworkResult.error(exception);
      } else {
        if (response.isBlank ?? true) {
          return NetworkResult.error(EmptyResponseException());
        } else {
          final data = response.data;

          if (data == null) {
            return NetworkResult.error(EmptyResponseException());
          }

          try {
            final List<T> result = (data as List)
                .map((item) => fromJson(item as Map<String, dynamic>))
                .toList();
            return NetworkResult.success(result);
            // ignore: avoid_catches_without_on_clauses
          } catch (e) {
            return NetworkResult.error(
              UnableToProcessException(),
            );
          }
        }
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return NetworkResult.error(UnexpectedErrorException());
    }
  }

  static NetworkResult<T> handleDioException<T>(dynamic error) {
    return NetworkResult.error(_getDioException(error));
  }

  static NetworkException _handleResponse(Response? response) {
    final dynamic jsonData = response?.data;

    if (jsonData is Map<String, dynamic>) {
      final Map<String, dynamic> json = jsonData;
      final String? errMsg = _getErrorMessageFromResponse(json);

      final int statusCode = response?.statusCode ?? 0;
      switch (statusCode) {
        case 400:
        case 401:
        case 403:
          return UnauthorizedRequestException(error: errMsg);
        case 404:
          return NotFoundException(
            error: errMsg,
          );
        case 409:
          return ConflictException(
            error: errMsg,
          );
        case 408:
          return RequestTimeoutException(
            error: errMsg,
          );
        case 422:
          return UnableToProcessException(
            error: errMsg,
          );
        case 500:
          return InternalServerErrorException(
            error: errMsg,
          );
        case 503:
          return ServiceUnavailableException(
            error: errMsg,
          );
        default:
          return DefaultApiException(
            error: errMsg,
          );
      }
    } else {
      return EmptyResponseException();
    }
  }

  static NetworkException _getDioException(dynamic error) {
    if (error is Exception) {
      try {
        NetworkException networkExceptions = UnexpectedErrorException();
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              networkExceptions = RequestCanceledException();
              break;
            case DioErrorType.connectionTimeout:
              networkExceptions = RequestTimeoutException();
              break;
            case DioErrorType.unknown:
              networkExceptions = UnexpectedErrorException();
              break;
            case DioErrorType.receiveTimeout:
              networkExceptions = SendTimeoutException();
              break;
            case DioErrorType.badResponse:
              networkExceptions = _handleResponse(error.response);
              break;
            case DioErrorType.sendTimeout:
              networkExceptions = SendTimeoutException();
              break;
            case DioErrorType.badCertificate:
              networkExceptions = UnexpectedErrorException();
              break;
            case DioErrorType.connectionError:
              networkExceptions = NoInternetConnectionException();
              break;
            default:
              networkExceptions = UnexpectedErrorException();
          }
        } else if (error is SocketException) {
          networkExceptions = NoInternetConnectionException();
        } else {
          networkExceptions = UnexpectedErrorException();
        }
        return networkExceptions;
      } on FormatException catch (_) {
        return FormatException();
      } catch (_) {
        return UnexpectedErrorException();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return UnableToProcessException();
      } else {
        return UnexpectedErrorException();
      }
    }
  }

  static String? _getErrorMessageFromResponse(Map<String, dynamic>? json) {
    final ApiError? error = json != null ? ApiError.fromJson(json) : null;
    final List<ApiMessage>? apiMessages = error?.message;
    if (apiMessages == null || apiMessages.isEmpty) {
      return null;
    } else {
      final ApiMessage apiMessage = apiMessages.first;
      final List<Messages>? messages = apiMessage.messages;

      return (messages == null || messages.isEmpty)
          ? null
          : messages.first.message;
    }
  }

  static Future<void> _signOut() async {
    final preferenceManger = MyPreferenceManger.instance;
    await preferenceManger.signOut();
    AppNavigation.instance.navigateToSplash();
  }
}
