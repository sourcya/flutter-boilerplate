import 'package:playx/playx.dart';

import '../../resources/translation/app_translations.dart';

class CustomExceptionMessage  extends ExceptionMessage{
  const  CustomExceptionMessage();

  @override
  String get badRequest =>  AppTrans.badRequest.tr;

  @override
  String get conflict => AppTrans.conflict.tr;

  @override
  String get defaultError => AppTrans.defaultError.tr;

  @override
  String get emptyResponse =>  AppTrans.emptyResponse.tr;

  @override
  String get formatException => AppTrans.formatException.tr;

  @override
  String get internalServerError => AppTrans.internalServerError.tr;


  @override
  String get noInternetConnection => AppTrans.noInternetConnection.tr;

  @override
  String get notAcceptable =>AppTrans.notAcceptable.tr;

  @override
  String get notFound =>AppTrans.notFound.tr;

  @override
  String get requestCancelled =>AppTrans.requestCancelled.tr;

  @override
  String get requestTimeout => AppTrans.requestTimeout.tr;

  @override
  String get sendTimeout =>  AppTrans.sendTimeout.tr;

  @override
  String get serviceUnavailable => AppTrans.serviceUnavailable.tr;


  @override
  String get unableToProcess => AppTrans.unableToProcess.tr;

  @override
  String get unauthorizedRequest =>AppTrans.unauthorizedRequest.tr;

  @override
  String get unexpectedError => AppTrans.unexpectedError.tr;
}
