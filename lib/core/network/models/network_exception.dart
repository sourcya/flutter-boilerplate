import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../resources/translation/app_translations.dart';
import 'api_error.dart';
import 'message.dart';

part 'network_exception.freezed.dart';

@freezed
class NetworkExceptions with _$NetworkExceptions {
  NetworkExceptions._();
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorizedRequest(String? reason) =
      UnauthorizedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.notFound(String? reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.unProcessableEntity(String? reason) =
      UnprocessableEntity;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.emptyResponse() = EmptyResponse;

  const factory NetworkExceptions.defaultError(String? error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static String? getErrorMessageFromResponse(Map<String, dynamic>? json) {
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

  static NetworkExceptions handleResponse(Response? response) {
    final dynamic jsonData = response?.data;

    if (jsonData is Map<String, dynamic>) {
      final Map<String, dynamic> json = jsonData;
      final String? errMsg = getErrorMessageFromResponse(json);

      final int statusCode = response?.statusCode ?? 0;
      switch (statusCode) {
        case 400:
        case 401:
        case 403:
          return NetworkExceptions.unauthorizedRequest(errMsg);
        case 404:
          return NetworkExceptions.notFound(errMsg);
        case 409:
          return const NetworkExceptions.conflict();
        case 408:
          return const NetworkExceptions.requestTimeout();
        case 422:
          return NetworkExceptions.unProcessableEntity(errMsg);
        case 500:
          return const NetworkExceptions.internalServerError();
        case 503:
          return const NetworkExceptions.serviceUnavailable();
        default:
          final responseCode = statusCode;
          return NetworkExceptions.defaultError(
            "Received invalid status code: $responseCode",
          );
      }
    } else {
      return const NetworkExceptions.emptyResponse();
    }
  }

  static NetworkExceptions getDioException(dynamic error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions =
            const NetworkExceptions.unexpectedError();
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioErrorType.connectionTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioErrorType.unknown:
              networkExceptions = const NetworkExceptions.unexpectedError();
              break;
            case DioErrorType.receiveTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioErrorType.badResponse:
              networkExceptions =
                  NetworkExceptions.handleResponse(error.response);
              break;
            case DioErrorType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioErrorType.badCertificate:
              networkExceptions = const NetworkExceptions.unexpectedError();
              break;
            case DioErrorType.connectionError:
              const NetworkExceptions.noInternetConnection();
              break;
            default:
              networkExceptions = const NetworkExceptions.unexpectedError();
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException catch (e) {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    String errorMessage = "";
    networkExceptions.when(
      notImplemented: () {
        errorMessage = AppTrans.notImplemented.tr;
      },
      requestCancelled: () {
        errorMessage = AppTrans.requestCancelled.tr;
      },
      internalServerError: () {
        errorMessage = AppTrans.internalServerError.tr;
      },
      notFound: (String? reason) {
        errorMessage = reason != null && reason.isNotEmpty
            ? reason
            : AppTrans.defaultError.tr;
      },
      serviceUnavailable: () {
        errorMessage = AppTrans.serviceUnavailable.tr;
      },
      methodNotAllowed: () {
        errorMessage = AppTrans.methodNotAllowed.tr;
      },
      badRequest: () {
        errorMessage = AppTrans.badRequest.tr;
      },
      unauthorizedRequest: (String? error) {
        errorMessage = error != null && error.isNotEmpty
            ? error
            : AppTrans.defaultError.tr;
      },
      unProcessableEntity: (String? error) {
        errorMessage = error != null && error.isNotEmpty
            ? error
            : AppTrans.defaultError.tr;
      },
      unexpectedError: () {
        errorMessage = AppTrans.unexpectedError.tr;
      },
      requestTimeout: () {
        errorMessage = AppTrans.requestTimeout.tr;
      },
      noInternetConnection: () {
        errorMessage = AppTrans.noInternetConnection.tr;
      },
      conflict: () {
        errorMessage = AppTrans.conflict.tr;
      },
      sendTimeout: () {
        errorMessage = AppTrans.sendTimeout.tr;
      },
      unableToProcess: () {
        errorMessage = AppTrans.unableToProcess.tr;
      },
      defaultError: (String? error) {
        errorMessage = error != null && error.isNotEmpty
            ? error
            : AppTrans.defaultError.tr;
      },
      formatException: () {
        errorMessage = AppTrans.formatException.tr;
      },
      notAcceptable: () {
        errorMessage = AppTrans.notAcceptable.tr;
      },
      emptyResponse: () {
        errorMessage = AppTrans.emptyResponse.tr;
      },
    );
    return errorMessage;
  }
}
