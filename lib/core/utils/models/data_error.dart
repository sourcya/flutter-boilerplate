import 'package:playx/playx.dart';

import '../../resources/translation/app_translations.dart';

/// This is base class for handling different types of error.
/// Based on each app use case you can customize and change these errors.
sealed class DataError {
  String get message;

  const DataError();

  const factory DataError.noInternetError() = NoInternetError;
  const factory DataError.empty() = EmptyDataError;
  const factory DataError.error(String error) = DefaultDataError;
}

class NoInternetError extends DataError {
  const NoInternetError();

  @override
  String get message => AppTrans.noInternetMessage.tr;
}

class EmptyDataError extends DataError {
  const EmptyDataError();

  @override
  String get message => AppTrans.noDataMessage.tr;
}

class DefaultDataError extends DataError {
  final String error;

  const DefaultDataError(this.error);

  @override
  String get message => AppTrans.defaultError.tr;
}
