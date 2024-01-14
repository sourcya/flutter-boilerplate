import 'package:playx/playx.dart';

import '../resources/translation/app_translations.dart';

sealed class ResultError {
  String get message;

  const ResultError();

  const factory ResultError.noInternetError() = NoInternetResultError;
  const factory ResultError.empty() = EmptyResultError;
  const factory ResultError.error(String error) = DefaultResultError;


  factory ResultError.fromNetworkError(NetworkException error) {
    switch (error) {
      case EmptyResponseException _:
        return const ResultError.empty();
      case NoInternetConnectionException _:
        return const ResultError.noInternetError();
      default:
        return  ResultError.error(error.message);
    }
  }

}

class NoInternetResultError extends ResultError {
  const NoInternetResultError();

  @override
  String get message => AppTrans.noInternetMessage.tr;
}

class EmptyResultError extends ResultError {
  const EmptyResultError();

  @override
  String get message => AppTrans.noDataMessage.tr;
}

class DefaultResultError extends ResultError {
  final String error;

  const DefaultResultError(this.error);

  @override
  String get message => AppTrans.defaultError.tr;
}

