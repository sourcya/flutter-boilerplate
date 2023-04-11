import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../resources/translation/app_translations.dart';

const _shouldShowApiError = true;

abstract class NetworkException {
  String getMessage();
}

class UnauthorizedRequestException extends NetworkException {
  String? error;

  UnauthorizedRequestException({this.error});

  @override
  String getMessage() {
    return _shouldShowApiError
        ? error ?? AppTrans.unauthorizedRequest.tr
        : AppTrans.unauthorizedRequest.tr;
  }
}

class NotFoundException extends NetworkException {
  String? error;

  NotFoundException({this.error});

  @override
  String getMessage() {
    return _shouldShowApiError
        ? error ?? AppTrans.notFound.tr
        : AppTrans.notFound.tr;
  }
}

class ConflictException extends NetworkException {
  String? error;

  ConflictException({this.error});

  @override
  String getMessage() {
    return _shouldShowApiError
        ? error ?? AppTrans.conflict.tr
        : AppTrans.conflict.tr;
  }
}

class RequestTimeoutException extends NetworkException {
  String? error;

  RequestTimeoutException({this.error});

  @override
  String getMessage() {
    return _shouldShowApiError
        ? error ?? AppTrans.requestTimeout.tr
        : AppTrans.requestTimeout.tr;
  }
}

class UnableToProcessException extends NetworkException {
  String? error;
  UnableToProcessException({this.error});

  @override
  String getMessage() {
    return AppTrans.unableToProcess.tr;
  }
}

class InternalServerErrorException extends NetworkException {
  String? error;

  InternalServerErrorException({this.error});

  @override
  String getMessage() {
    return _shouldShowApiError
        ? error ?? AppTrans.internalServerError.tr
        : AppTrans.internalServerError.tr;
  }
}

class ServiceUnavailableException extends NetworkException {
  String? error;

  ServiceUnavailableException({this.error});

  @override
  String getMessage() {
    return _shouldShowApiError
        ? error ?? AppTrans.serviceUnavailable.tr
        : AppTrans.serviceUnavailable.tr;
  }
}

class EmptyResponseException extends NetworkException {
  String? error;

  EmptyResponseException({this.error});

  @override
  String getMessage() {
    return _shouldShowApiError
        ? error ?? AppTrans.emptyResponse.tr
        : AppTrans.emptyResponse.tr;
  }
}

class DefaultApiException extends NetworkException {
  String? error;

  DefaultApiException({this.error});

  @override
  String getMessage() {
    return _shouldShowApiError
        ? error ?? AppTrans.defaultError.tr
        : AppTrans.defaultError.tr;
  }
}

//Dio errors
class SendTimeoutException extends NetworkException {
  @override
  String getMessage() {
    return AppTrans.sendTimeout.tr;
  }
}

class RequestCanceledException extends NetworkException {
  @override
  String getMessage() {
    return AppTrans.requestCancelled.tr;
  }
}

class NoInternetConnectionException extends NetworkException {
  @override
  String getMessage() {
    return AppTrans.noInternetConnection.tr;
  }
}

class FormatException extends NetworkException {
  @override
  String getMessage() {
    return AppTrans.formatException.tr;
  }
}

class UnexpectedErrorException extends NetworkException {
  @override
  String getMessage() {
    return AppTrans.unexpectedError.tr;
  }
}
