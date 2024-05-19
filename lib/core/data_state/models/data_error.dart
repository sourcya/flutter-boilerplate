import 'package:flutter_boilerplate/core/resources/translation/app_translations.dart';
import 'package:playx/playx.dart';

/// This is base class for handling different types of error.
/// Based on each app use case you can customize and change these errors.
sealed class DataError {
  String get message;

  const DataError();

  const factory DataError.noInternetError({String? error}) = NoInternetError;
  const factory DataError.empty({String? error}) = EmptyDataError;
  const factory DataError.error({String? error}) = DefaultDataError;

  factory DataError.fromNetworkError(NetworkException error) {
    switch (error) {
      case EmptyResponseException _:
        return const DataError.empty();
      case NoInternetConnectionException _:
        return const DataError.noInternetError();
      default:
        return DataError.error(error: error.message);
    }
  }
}

class NoInternetError extends DataError {
  final String? error;

  const NoInternetError({this.error});

  @override
  String get message => error ?? AppTrans.noInternetMessage;
}

class EmptyDataError extends DataError {
  final String? error;

  const EmptyDataError({this.error});

  @override
  String get message => error ?? AppTrans.noDataMessage;
}

class DefaultDataError extends DataError {
  final String? error;

  const DefaultDataError({this.error});

  @override
  String get message => error ?? AppTrans.defaultError;
}
