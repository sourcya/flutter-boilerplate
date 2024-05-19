import 'package:playx/playx.dart';

import '../../resources/translation/app_translations.dart';

class CustomExceptionMessage extends ExceptionMessage {
  const CustomExceptionMessage();

  @override
  String get badRequest => AppTrans.badRequest;

  @override
  String get conflict => AppTrans.conflict;

  @override
  String get defaultError => AppTrans.defaultError;

  @override
  String get emptyResponse => AppTrans.emptyResponse;

  @override
  String get formatException => AppTrans.formatException;

  @override
  String get internalServerError => AppTrans.internalServerError;

  @override
  String get noInternetConnection => AppTrans.noInternetConnection;

  @override
  String get notAcceptable => AppTrans.notAcceptable;

  @override
  String get notFound => AppTrans.notFound;

  @override
  String get requestCancelled => AppTrans.requestCancelled;

  @override
  String get requestTimeout => AppTrans.requestTimeout;

  @override
  String get sendTimeout => AppTrans.sendTimeout;

  @override
  String get serviceUnavailable => AppTrans.serviceUnavailable;

  @override
  String get unableToProcess => AppTrans.unableToProcess;

  @override
  String get unauthorizedRequest => AppTrans.unauthorizedRequest;

  @override
  String get unexpectedError => AppTrans.unexpectedError;
}
