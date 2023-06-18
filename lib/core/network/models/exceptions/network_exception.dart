import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../resources/translation/app_translations.dart';

/// Whether or not it should show the error from the api response.
const _shouldShowApiError = true;

/// Base class for handling most api errors and provides suitable error messages.
sealed class NetworkException {
  String get message;

  const NetworkException();
}

class UnauthorizedRequestException extends NetworkException {
  final String? error;

  const UnauthorizedRequestException({this.error});

  @override
  String get message => _shouldShowApiError
      ? error ?? AppTrans.unauthorizedRequest.tr
      : AppTrans.unauthorizedRequest.tr;
}

class NotFoundException extends NetworkException {
  final String? error;

  const NotFoundException({this.error});

  @override
  String get message => _shouldShowApiError
      ? error ?? AppTrans.notFound.tr
      : AppTrans.notFound.tr;
}

class ConflictException extends NetworkException {
  final String? error;

  const ConflictException({this.error});

  @override
  String get message => _shouldShowApiError
      ? error ?? AppTrans.conflict.tr
      : AppTrans.conflict.tr;
}

class RequestTimeoutException extends NetworkException {
  final String? error;

  const RequestTimeoutException({this.error});

  @override
  String get message => _shouldShowApiError
      ? error ?? AppTrans.requestTimeout.tr
      : AppTrans.requestTimeout.tr;
}

class UnableToProcessException extends NetworkException {
  final String? error;

  const UnableToProcessException({this.error});

  @override
  String get message => AppTrans.unableToProcess.tr;
}

class InternalServerErrorException extends NetworkException {
  final String? error;

  const InternalServerErrorException({this.error});

  @override
  String get message => _shouldShowApiError
      ? error ?? AppTrans.internalServerError.tr
      : AppTrans.internalServerError.tr;
}

class ServiceUnavailableException extends NetworkException {
  final String? error;

  const ServiceUnavailableException({this.error});

  @override
  String get message => _shouldShowApiError
      ? error ?? AppTrans.serviceUnavailable.tr
      : AppTrans.serviceUnavailable.tr;
}

class EmptyResponseException extends NetworkException {
  final String? error;

  const EmptyResponseException({this.error});

  @override
  String get message => _shouldShowApiError
      ? error ?? AppTrans.emptyResponse.tr
      : AppTrans.emptyResponse.tr;
}

class DefaultApiException extends NetworkException {
  final String? error;

  const DefaultApiException({this.error});

  @override
  String get message => _shouldShowApiError
      ? error ?? AppTrans.defaultError.tr
      : AppTrans.defaultError.tr;
}

//Dio errors
class SendTimeoutException extends NetworkException {
  const SendTimeoutException();

  @override
  String get message => AppTrans.sendTimeout.tr;
}

void test() {}

class RequestCanceledException extends NetworkException {
  const RequestCanceledException();

  @override
  String get message => AppTrans.requestCancelled.tr;
}

class NoInternetConnectionException extends NetworkException {
  const NoInternetConnectionException();

  @override
  String get message => AppTrans.noInternetConnection.tr;
}

class FormatException extends NetworkException {
  const FormatException();

  @override
  String get message => AppTrans.formatException.tr;
}

class UnexpectedErrorException extends NetworkException {
  const UnexpectedErrorException();

  @override
  String get message => AppTrans.unexpectedError.tr;
}
